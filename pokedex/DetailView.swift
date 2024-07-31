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

        
        VStack(alignment: .center) {
            //PKMN IMAGE
            CachedAsyncImage(url: URL(string: (pokemon.sprites.other.officialArtwork.frontDefault)))
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                
            HStack {
                
                //TYPE 1
                Text("Type 1")
                    .padding(.vertical,5)
                    .padding(.horizontal,15)
                    .background(
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.clear)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            )
                        
                    )
                   
                //TYPE 2
                Text("Type 2")
                    .padding(.vertical,5)
                    .padding(.horizontal,15)
                    .background(
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(.clear)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            )
                        
                    )
                
                
            }
            .padding(.bottom)
            
            //FLAVOR TEXT
            RoundedRectangle(cornerRadius: 5.0)
                .frame(width: 100,height: 25)
                .overlay {
                    Text("Flavor Text")
                        .foregroundStyle(.white)
                }
            
        }
        .padding(.top,20)
        
        
            
    }
    
    
    func configure(with pokemonDetail: Pokemon) {
        
        if (pokemonDetail.types.count == 2) {
            
            
            
            
        } else {
            
            
            
        }
        
        
        
        
    }
}
