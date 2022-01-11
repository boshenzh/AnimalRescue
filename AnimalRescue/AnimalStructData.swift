//
//  PetData.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/9/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import CoreData
 
// Array of MusicAlbum structs for use only in this file
fileprivate var animalStructStructList = [AnimalStruct]()
 
/*
 ***********************************
 MARK: - Create Music Album Database
 ***********************************
 */
public func createAnimalStructDatabase() {
 
    animalStructStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "AnimalsData.json", fileLocation: "Main Bundle")
   
    populateDatabase()
}
 
/*
*********************************************
MARK: - Populate Database If Not Already Done
*********************************************
*/
func populateDatabase() {
   
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Pet>(entityName: "Pet")
    fetchRequest.sortDescriptors = [
        // Primary sort key: artistName
        NSSortDescriptor(key: "name", ascending: true),
        // Secondary sort key: songName
        NSSortDescriptor(key: "species", ascending: true)
    ]
   
    var listOfAllPetEntitiesInDatabase = [Pet]()
   
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllPetEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
   
    if listOfAllPetEntitiesInDatabase.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
   
    print("Database will be populated!")
   
    for item in animalStructStructList {
        /*
         =====================================================
         Create an instance of the Song Entity and dress it up
         =====================================================
        */
       
        // ❎ Create an instance of the Song entity in CoreData managedObjectContext
        let petEntity = Pet(context: managedObjectContext)
       
        // ❎ Dress it up by specifying its attributes
        petEntity.id = item.id
        petEntity.adoptionFeeString = item.adoptionFeeString
        petEntity.ageGroup = item.ageGroup
        petEntity.ageString = item.ageString
        petEntity.availableDate = item.name
        petEntity.birthDate = item.birthDate
        petEntity.breedString = item.breedString
        petEntity.colorDetails = item.colorDetails
        petEntity.indoorOutdoor = item.indoorOutdoor
        petEntity.name = item.name
        petEntity.species = item.species
        petEntity.sex = item.sex
        petEntity.url = item.url


        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
         */
        let aPhoto = Photo(context: managedObjectContext)
       
        // Dress it up by specifying its attribute
        aPhoto.photoUrl = item.photoUrl
       
        // Establish One-to-One Relationship between Recipe and Photo
        petEntity.photo = aPhoto      // A recipe can have only one photo
        aPhoto.pet = petEntity     // A photo can belong to only one recipe
       
       
       
        /*
         ==================================
         Save Changes to Core Data Database
         ==================================
        */
       
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
       
    }   // End of for loop
 
}
 
