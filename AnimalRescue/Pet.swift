//
//  Animal.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/9/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Song entity public class
public class Pet: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    @NSManaged public var adoptionFeeString: String?
    @NSManaged public var ageGroup: String?
    @NSManaged public var ageString: String?
    @NSManaged public var availableDate: String?
    @NSManaged public var birthDate: String?
    @NSManaged public var breedString: String?
    @NSManaged public var colorDetails: String?
    @NSManaged public var indoorOutdoor: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var sex: String?
    @NSManaged public var url: String?

    @NSManaged public var photo: Photo?
}
 
extension Pet {
    /*
     ❎ CoreData @FetchRequest in SongsList.swift invokes this Song class method
        to fetch all of the Song entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Song.allSongsFetchRequest() in any .swift file in your project.
     */
    static func allPetsFetchRequest() -> NSFetchRequest<Pet> {
       
        let request: NSFetchRequest<Pet> = Pet.fetchRequest() as! NSFetchRequest<Pet>
        /*
         List the songs in alphabetical order with respect to artistName;
         If artistName is the same, then sort with respect to songName.
         */
        request.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "name", ascending: true),
            // Secondary sort key: songName
            NSSortDescriptor(key: "species", ascending: true)
        ]
       
        return request
    }
   
//    /*
//     ❎ CoreData @FetchRequest in SearchDatabase.swift invokes this Song class method
//        to fetch filtered Song entities from the database for the given search query.
//        The 'static' keyword designates the func as a class method invoked by using the
//        class name as Song.filteredSongsFetchRequest() in any .swift file in your project.
//     */
//    static func filteredSongsFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<Animal> {
//
//        let fetchRequest = NSFetchRequest<Animal>(entityName: "Animal")
//
//        /*
//         List the found songs in alphabetical order with respect to artistName;
//         If artistName is the same, then sort with respect to songName.
//         */
//        fetchRequest.sortDescriptors = [
//            // Primary sort key: artistName
//            NSSortDescriptor(key: "artistName", ascending: true),
//            // Secondary sort key: songName
//            NSSortDescriptor(key: "songName", ascending: true)
//        ]
//
//        // Case insensitive search [c] for searchQuery under each category
//        switch searchCategory {
//        case "Album Name":
//            fetchRequest.predicate = NSPredicate(format: "albumName CONTAINS[c] %@", searchQuery)
//        case "Artist Name":
//            fetchRequest.predicate = NSPredicate(format: "artistName CONTAINS[c] %@", searchQuery)
//        case "Song Name":
//            fetchRequest.predicate = NSPredicate(format: "songName CONTAINS[c] %@", searchQuery)
//        case "Genre":
//            fetchRequest.predicate = NSPredicate(format: "genre CONTAINS[c] %@", searchQuery)
//        case "Rating":
//            fetchRequest.predicate = NSPredicate(format: "rating CONTAINS[c] %@", searchQuery)
//        case "Compound":
//            let components = searchQuery.components(separatedBy: "AND")
//            let genreQuery = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
//            let ratingQuery = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
//
//            fetchRequest.predicate = NSPredicate(format: "genre CONTAINS[c] %@ AND rating CONTAINS[c] %@", genreQuery, ratingQuery)
//        default:
//            print("Search category is out of range")
//        }
//
//        return fetchRequest
//    }
}
 
