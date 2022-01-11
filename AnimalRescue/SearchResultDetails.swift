//
//  SearchResultDetails.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/7/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import MapKit
import CoreData
struct SearchResultDetails: View {
    @EnvironmentObject var userData: UserData
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var showAnimalAddedAlert = false

//    // Song Entity
//    @State private var adoptionFee = ""
//    @State private var ageGroup = ""
//    @State private var ageString = ""
//    @State private var AvailableDate = ""
//    @State private var birthDate = ""
//    @State private var breedString = ""
//    @State private var colorDetails = ""
//    @State private var indoorOutdoor = ""
//    @State private var name = ""
//    @State private var species = ""
//    @State private var sex = ""
//    @State private var url = ""
//    @State private var photoUrl = ""
//

    // Input Parameter
    let animal: AnimalStruct
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Section(header: Text("Animal Name")) {
                    Text(animal.name)
                }
                Section(header: Text("Species")) {
                    Text(animal.species)
                }
                Section(header: Text("Breed")) {
                    Text(animal.breedString)
                }
            Group {

                Section(header: Text("Animal looks")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url:animal.photoUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                }
             
                
                Section(header: Text("Animal Age")) {
                    Text("\(animal.ageString)")
                }
                Section(header: Text("Animal Sex")) {
                    Text("\(animal.sex)")
                }

                Section(header: Text("Animal Age group")) {
                    Text("\(animal.ageGroup), \(animal.ageString)")
                }
              
                Section(header: Text("Color Details")) {
                    Text("\(animal.colorDetails)")
                }
                Section(header: Text("Birth Date")) {
                    Text("\(animal.birthDate)")
                }

                Section(header: Text("Adoption fees")) {
                    if animal.adoptionFeeString != "Not Listed"{

                    Text("\(animal.adoptionFeeString) Dollars")
                    }
                    else{
                        Text("\(animal.adoptionFeeString)")

                    }
                }

                if animal.url != "Not Listed"{

                Section(header: Text("For more Information")) {
                    NavigationLink(destination:
                                    WebView(url: animal.url)
                                    .navigationBarTitle(Text("\(animal.name)"), displayMode: .inline)
                    ){
                        HStack {
                            Image(systemName: "gear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                                .foregroundColor(.blue)
                            Text("More about \(animal.name)")
                                .font(.system(size: 16))
                        }
                        .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                    }
                }
                }
                Section(header: Text("Add To favorite")) {
                    Button(action: {
                        // Append the country found to userData.countriesList
                        self.userData.animalsList.append(animal)
 
                        saveToDatabase() 
                        // Set the global variable point to the changed list
                        animalStructList = self.userData.animalsList
                       
                        let selectedAnimalAttributesForSearch = "\(animal.id)|\(animal.ageGroup)|\(animal.name)|\(animal.breedString)|\(animal.colorDetails)|\(animal.indoorOutdoor)|\(animal.sex)|\(animal.species)|\(animal.ageString)"
                       
                        self.userData.searchableOrderedAnimalsList.append(selectedAnimalAttributesForSearch)
                       
                        // Set the global variable point to the changed list
                        orderedSearchableAnimalsList = self.userData.searchableOrderedAnimalsList
                        self.showAnimalAddedAlert = true

                        
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                                .foregroundColor(.blue)
                            Text("Add Animal to Favorites")
                                .font(.system(size: 16))
                        }
                    }
                }

                
            }

 
        }   // End of Form
        .navigationBarTitle(Text("\(animal.name)"), displayMode: .inline)
            .font(.system(size: 14))
        .alert(isPresented: $showAnimalAddedAlert, content: { self.animalAddedAlert })

       
    }   // End of body
    var animalAddedAlert: Alert {
        Alert(title: Text("Pet Added!"),
              message: Text("This Pet is added to your favorites list!"),
              dismissButton: .default(Text("OK")) )
    }

    func saveToDatabase() {
       
       
        /*
         =====================================================
         Create an instance of the Song Entity and dress it up
         =====================================================
        */
       
        // ❎ Create a new Song entity in CoreData managedObjectContext
        let newPet = Pet(context: self.managedObjectContext)
       
        // ❎ Dress up the new Song entity
        newPet.name = animal.name
        newPet.adoptionFeeString = animal.adoptionFeeString
        newPet.ageGroup = animal.ageGroup
        newPet.ageString = animal.ageString
        newPet.availableDate = animal.availableDate
        newPet.birthDate = animal.birthDate
        newPet.breedString = animal.breedString
        newPet.colorDetails = animal.colorDetails
        newPet.indoorOutdoor = animal.indoorOutdoor
        newPet.species = animal.species
        newPet.sex = animal.sex
        newPet.url = animal.url
        newPet.photo?.photoUrl = animal.photoUrl




        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
        */
       
        // ❎ Create a new Photo entity in CoreData managedObjectContext
        let aPhoto = Photo(context: self.managedObjectContext)
       
        // Dress it up by specifying its attribute
        aPhoto.photoUrl = animal.photoUrl
       
        // Establish One-to-One Relationship between Recipe and Photo
        newPet.photo = aPhoto      // A recipe can have only one photo
        aPhoto.pet = newPet     // A photo can belong to only one recipe
        /*
         ==============================
         Establish Entity Relationships
         ==============================
        */
               /*
         =============================================
         MARK: - ❎ Save Changes to Core Data Database
         =============================================
         */
       
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
       
    }   // End of function
}
