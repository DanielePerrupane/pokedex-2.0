//
//  DetailView.swift
//  pokedex
//
//  Created by Daniele Perrupane on 30/07/24.
//

import SwiftUI

struct DetailView: View {
    
    var body: some View {
        
        ZStack {
            
            //PKMN IMAGE
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 200, height: 200)
            Text("Pokèmon \nImage")
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .border(Color.black)
            
        }
        VStack(alignment: .center) {
            
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
        
        
            
    }
}

#Preview {
    DetailView()
}
