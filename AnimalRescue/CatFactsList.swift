//
//  Shelters.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct CatFactsList: View {
   
    var body: some View {
        NavigationView {
            List {
                ForEach(catFacts, id: \.self) { catFact in
                    CatFactsItem(catFact: catFact)
                }
            }   // End of List
            .navigationBarTitle(Text("Cat Facts"), displayMode: .inline)
           
        }   // End of NavigationView
        .customNavigationViewStyle()      // Given in NavigationStyle.swift
       
    }   // End of body
 
}

struct CatFactsList_Previews: PreviewProvider {
    static var previews: some View {
        CatFactsList()
    }
}
