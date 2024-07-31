//
//  ContentView.swift
//  pokedex
//
//  Created by Daniele Perrupane on 30/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var pokemonarray: [Pokemon] = []
    @State private var errorMessage: String?
    var pokemonID = Array(1...151)
    let title = "Pokèmon"
    
    
    let columns = [
    
        GridItem(.flexible()),
        GridItem(.flexible())
    
    ]
    
    var body: some View {
        
        
        NavigationStack {
            
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(pokemonarray, id: \.id) { pokemon in
                        NavigationLink(destination: DetailView(), label: {
                            VStack {
                               AsyncImage(url: URL(string: pokemon.sprites.other.officialArtwork.frontDefault)) { phase in
                                   switch phase {
                                   case .empty:
                                       ProgressView()
                                   case .success(let image):
                                       image
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 150, height: 150)
                                           .cornerRadius(10)
                                   case .failure:
                                       Image(systemName: "xmark.circle")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 150, height: 150)
                                           .foregroundColor(.red)
                                   @unknown default:
                                       EmptyView()
                                   }
                               }
                                Text(pokemon.name.capitalized)
                            }
                        })
                        
                    }
                }
            }.navigationTitle(title)
            .onAppear {
                 
                fetchAndPopulatePokemonData(ids: pokemonID) { result in
                    switch result {
                    case .success(let pokemons) :
                        self.pokemonarray = pokemons
                    case .failure(let error) :
                        self.errorMessage = error.localizedDescription
                        
                    }
                }
                
            }
            
        }
    }
}


// MARK: - Fetching Data

func fetchAndPopulatePokemonData(ids: [Int], completion: @escaping (Result<[Pokemon], Error>) -> Void) {
    let dispatchGroup = DispatchGroup()
    var pokemonResults: [Int: Pokemon] = [:]
    var fetchError: Error?
    
    for id in ids {
        dispatchGroup.enter()
        fetchCompletePokemonData(id: id) { result in
            switch result {
            case .success(let pokemon):
                pokemonResults[id] = pokemon
            case .failure(let error):
                fetchError = error
            }
            dispatchGroup.leave()
        }
    }
    
    dispatchGroup.notify(queue: .main) {
        if let error = fetchError {
            completion(.failure(error))
        } else {
            let sortedPokemons = ids.compactMap { pokemonResults[$0] }
            completion(.success(sortedPokemons))
        }
    }
}

func fetchCompletePokemonData(id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
    let dispatchGroup = DispatchGroup()
    
    var fetchedName: String?
    var fetchedSprites: Sprites?
    var fetchedTypes: [TypeSlot] = []
    var fetchedFlavorText: String?
    var fetchError: Error?
    
    dispatchGroup.enter()
    fetchPokemonImagesAndTypes(id: id) { result in
        switch result {
        case .success(let pokemonResponse):
            fetchedSprites = pokemonResponse.sprites
            fetchedTypes = pokemonResponse.types
        case .failure(let error):
            fetchError = error
        }
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    fetchPokemonNameAndFlavorText(id: id) { result in
        switch result {
        case .success(let pokemonSpeciesResponse):
            fetchedName = pokemonSpeciesResponse.name
            if let flavorTextEntry = pokemonSpeciesResponse.flavor_text_entries.first(where: { $0.language.name == "en" }) {
                fetchedFlavorText = flavorTextEntry.flavor_text.replacingOccurrences(of: "\n", with: " ")
            }
        case .failure(let error):
            fetchError = error
        }
        dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) {
        if let error = fetchError {
            completion(.failure(error))
        } else if let name = fetchedName, let sprites = fetchedSprites, let flavorText = fetchedFlavorText {
            let pokemon = Pokemon(id: id, name: name, sprites: sprites, types: fetchedTypes, flavorText: flavorText)
            completion(.success(pokemon))
        } else {
            completion(.failure(NSError(domain: "Incomplete data", code: 3, userInfo: nil)))
        }
    }
}

func fetchPokemonImagesAndTypes(id: Int, completion: @escaping (Result<PokemonResponse, Error>) -> Void) {
    let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data", code: 2, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let pokemonResponse = try decoder.decode(PokemonResponse.self, from: data)
            completion(.success(pokemonResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

func fetchPokemonNameAndFlavorText(id: Int, completion: @escaping (Result<PokemonSpeciesResponse, Error>) -> Void) {
    let urlString = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 1, userInfo: nil)))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data", code: 2, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let pokemonSpeciesResponse = try decoder.decode(PokemonSpeciesResponse.self, from: data)
            completion(.success(pokemonSpeciesResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}



#Preview {
    ContentView()
}
