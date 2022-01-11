//
//  FindAnimals.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import CoreData
fileprivate var selectedAnimalName = ""
fileprivate var selectedAnimalSex = ""

struct Grid: View {
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
   
    // ❎ CoreData FetchRequest returning all Song entities in the database
    @FetchRequest(fetchRequest: Pet.allPetsFetchRequest()) var allPets: FetchedResults<Pet>
   
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Song entities with all the changes.
    @EnvironmentObject var userData: UserData
   
    @State private var showAnimalInfoAlert = false
    
    // Fit as many images per row as possible with minimum image width of 100 points each.
    // spacing defines spacing between columns
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 3) ]
    
    var body: some View {
        ScrollView {
            // spacing defines spacing between rows
            LazyVGrid(columns: columns, spacing: 3) {
                // 🔴 Specifying id: \.self is critically important to prevent photos being listed as out of order
                ForEach(allPets, id: \.self) { animal in
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: animal.photo?.photoUrl ?? "", defaultFilename: "ImageUnavailable")
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 120, maxWidth: 120, minHeight: 120, maxHeight: 120, alignment: .center)
                        .onTapGesture {
                            selectedAnimalName = animal.name ?? ""
                            selectedAnimalSex = animal.sex ?? ""

                            self.showAnimalInfoAlert = true
                        }
                }
            }   // End of LazyVGrid
            .padding()
            
        }   // End of ScrollView
        .alert(isPresented: $showAnimalInfoAlert, content: { self.animalInfoAlert })
    }
    
     var animalInfoAlert: Alert {
        Alert(title: Text("Name: \(selectedAnimalName)\n Sex: \(selectedAnimalSex)"),
              dismissButton: .default(Text("OK")))
    }

}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid()
    }
}
