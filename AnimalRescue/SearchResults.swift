//
//  SearchResults.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/7/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct SearchResults: View {
        var body: some View {
        List {
            ForEach(rescueGroupsAnimalsList) { aAnimal in
                NavigationLink(destination: SearchResultDetails(animal: aAnimal)) {
                    AnimalItem(animal: aAnimal)
                }
            }
            
        }   // End of List
        .navigationBarTitle(Text("Animals Found"), displayMode: .inline)
    }
}

