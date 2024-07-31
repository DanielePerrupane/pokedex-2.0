//
//  DetailView.swift
//  pokedex
//
//  Created by Daniele Perrupane on 30/07/24.
//

import SwiftUI

struct DetailView: View {
    
    
    
    var pokemon: Pokemon
    
    var body: some View {

        
        VStack {
            //PKMN IMAGE
            CachedAsyncImage(url: URL(string: (pokemon.sprites.other.officialArtwork.frontDefault)))
                .frame(width: 250, height: 250)
                
            
            //PKMN NAME
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom,20)
                
            HStack {
                
                if (pokemon.types.count == 2) {
                    
                    //TYPE 1
                    Text(pokemon.types[0].type.name.capitalized)
                        .padding(.vertical,5)
                        .padding(.horizontal,15)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.clear)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                )
                        )
                       
                    //TYPE 2
                    Text(pokemon.types[1].type.name.capitalized)
                        .padding(.vertical,5)
                        .padding(.horizontal,15)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.clear)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                )
                        )
                } else {
                    
                    //TYPE 1
                    Text(pokemon.types[0].type.name.capitalized)
                        .padding(.vertical,5)
                        .padding(.horizontal,15)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(.clear)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                )
                        )
                }
            }
            .padding(.bottom,20)
            
            
            //FLAVOR TEXT
            Text(pokemon.flavorText)
                .font(.subheadline)
                
            
        }
        .padding(.bottom,200)
    }
    
}
