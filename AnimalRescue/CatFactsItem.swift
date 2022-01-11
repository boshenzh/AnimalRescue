//
//  CatFactsItem.swift
//  AnimalRescue
//
//  Created by Sami Tamim on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct CatFactsItem: View {
   
    // Input Parameter
    let catFact: String
   
    var body: some View {
        HStack {
            getImageFromUrl(url: catsGridList[Int.random(in: 1...47)].photoUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0)
           
            Text(catFact)
            // Set font and size for the whole VStack content
            .font(.system(size: 18))
           
        }   // End of HStack
    }
}

struct CatFactsItem_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsItem(catFact: catFacts[0])
    }
}
