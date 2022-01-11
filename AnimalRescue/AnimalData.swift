//
//  AnimalData.swift
//  AnimalRescue
//
//  Created by Boshen Zhang on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import Foundation
import SwiftUI

// Global array of Country structs
var animalStructList = [AnimalStruct]()
var orderedSearchableAnimalsList = [String]()


/*
 *********************************
 MARK: - Read Countries Data Files
 *********************************
 */
public func readAnimalsDataFiles() {
    
    var documentDirectoryHasFiles = false
    let animalsDataFullFilename = "AnimalsData.json"
    
    // Obtain URL of the CountriesData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(animalsDataFullFilename)
    
    do {
        /*
         Try to get the contents of the file. The left hand side is
         suppressed by using '_' since we do not use it at this time.
         Our purpose is just to check to see if the file is there or not.
         */
        
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        /*
         If 'try' is successful, it means that the CountriesData.json
         file exists in document directory on the user's device.
         ---
         If 'try' is unsuccessful, it throws an exception and
         executes the code under 'catch' below.
         */
        
        documentDirectoryHasFiles = true
        
        /*
         --------------------------------------------------
         |   The app is being launched after first time   |
         --------------------------------------------------
         The CountriesData.json file exists in document directory on the user's device.
         Load it from Document Directory into countryStructList.
         */
        print("Trying to load AnimalsData from document directory.")
        // The function is given in UtilityFunctions.swift
        animalStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: animalsDataFullFilename, fileLocation: "Document Directory")
        print("AnimalsData is loaded from document directory")
        
    } catch {
        documentDirectoryHasFiles = false
        
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The CountriesData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into countryStructList.
         
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
        print("Trying to load AnimalsData from Main Bundle.")
        // The function is given in UtilityFunctions.swift
        animalStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: animalsDataFullFilename, fileLocation: "Main Bundle")
        print("AnimalsData is loaded from main bundle")

        for animal in animalStructList {
            //let selectedAnimalAttributesForSearch = "\(animal.id)|\(animal.animalType)"
            let selectedAnimalAttributesForSearch = "\(animal.id)|\(animal.ageGroup)|\(animal.name)|\(animal.breedString)|\(animal.colorDetails)|\(animal.indoorOutdoor)|\(animal.sex)|\(animal.species)|\(animal.ageString)"
            orderedSearchableAnimalsList.append(selectedAnimalAttributesForSearch)
        }
        
    }   // End of do-catch
    
    /*
     ----------------------------------------
     Read OrderedSearchableCountriesList File
     ----------------------------------------
     */
    if documentDirectoryHasFiles {
        // Obtain URL of the file in document directory on the user's device
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("OrderedSearchableAnimalsList")
        
        // Instantiate an NSArray object and initialize it with the contents of the file
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableAnimalsList = arrayObtained as! [String]
        } else {
            print("OrderedSearchableAnimalsList file is not found in document directory on the user's device!")
        }
    }
}

/*
 ********************************************************
 MARK: - Write Countries Data Files to Document Directory
 ********************************************************
 */
public func writeAnimalsDataFiles() {
    /*
     --------------------------------------------------------------------------
     Write countryStructList into CountriesData.json file in Document Directory
     --------------------------------------------------------------------------
     */
    
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("AnimalsData.json")
    
    // Encode countryStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(animalStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded Animals data to document directory!")
        }
    } else {
        fatalError("Unable to encode Animal data!")
    }
    
    /*
     ------------------------------------------------------
     Write orderedSearchableCountriesList into a file named
     OrderedSearchableCountriesList in Document Directory
     ------------------------------------------------------
     */
    
    // Obtain URL of the file in document directory on the user's device
    let urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("OrderedSearchableAnimalsList")
    
    /*
     Swift Array does not yet provide the 'write' function, but NSArray does.
     Therefore, typecast the Swift array as NSArray so that we can write it.
     */
    
    (orderedSearchableAnimalsList as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    /*
     The flag "atomically" specifies whether the file should be written atomically or not.
     
     If flag atomically is TRUE, the file is first written to an auxiliary file, and
     then the auxiliary file is renamed as OrderedSearchableCountriesList.
     
     If flag atomically is FALSE, the file is written directly to OrderedSearchableCountriesList.
     This is a bad idea since the file can be corrupted if the system crashes during writing.
     
     The TRUE option guarantees that the file will not be corrupted even if the system crashes during writing.
     */
}
