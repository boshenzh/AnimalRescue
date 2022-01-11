//
//  FavoritesList.swift
//  AnimalRescue
//
//  Created by Boshen Zhang on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//
import SwiftUI
 
struct FavoritesList: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    @State private var searchItem = ""
   
    var body: some View {
        NavigationView {
            List {
                SearchBar(searchItem: $searchItem, placeholder: "Search Animals")
               
                ForEach(userData.searchableOrderedAnimalsList.filter {self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self)
                { item in
                    NavigationLink(destination: FavoriteDetails(animal: self.searchItemAnimal(searchListItem: item)))
                    {
                        FavoriteItem(animal: self.searchItemAnimal(searchListItem: item))
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("Favorites"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
           
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
   
    func searchItemAnimal(searchListItem: String) -> AnimalStruct {
        /*
         searchListItem = "id|name|alpha2code|capital|languages|currency"
         country id = searchListItem.components(separatedBy: "|")[0]
         */
        // Find the index number of countriesList matching the country attribute 'id'
        let index = userData.animalsList.firstIndex(where: {$0.id == searchListItem.components(separatedBy: "|")[0]})!

        return userData.animalsList[index]
    }

    /*
     -------------------------------
     MARK: - Delete Selected Country
     -------------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
        'offsets.first' is an unsafe pointer to the index number of the array element
        to be deleted. It is nil if the array is empty. Process it as an optional.
        */
        if let index = offsets.first {
            userData.animalsList.remove(at: index)
            userData.searchableOrderedAnimalsList.remove(at: index)
        }
        // Set the global variable point to the changed list
        animalStructList = userData.animalsList
       
        // Set the global variable point to the changed list
        orderedSearchableAnimalsList = userData.searchableOrderedAnimalsList
    }
   
    /*
     -----------------------------
     MARK: - Move Selected Country
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.animalsList.move(fromOffsets: source, toOffset: destination)
        userData.searchableOrderedAnimalsList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
        animalStructList = userData.animalsList
       
        // Set the global variable point to the changed list
        orderedSearchableAnimalsList = userData.searchableOrderedAnimalsList
    }
}
 
struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
 
