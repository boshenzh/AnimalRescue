//
//  FavoritesItem.swift
//  AnimalRescue
//
//  Created by Boshen Zhang on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct FavoriteItem: View {
    
    // Input Parameter
    let animal: AnimalStruct
    
    var body: some View {
        HStack {
            // Public function getImageFromUrl is given in UtilityFunctions.swift
            getImageFromUrl(url:"\(animal.photoUrl)", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text("Name: \(animal.name)")
                Text("Species: \(animal.species)")
                Text("Age: \(animal.ageString)")
            }   // End of HStack
            .font(.system(Font.TextStyle.body, design: Font.Design.default))
        }
        
    }
}

