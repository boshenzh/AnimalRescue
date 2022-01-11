//
//  Photo.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/9/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//
import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Photo, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Photo, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Photo entity public class
public class Photo: NSManagedObject, Identifiable {
 
    @NSManaged public var photoUrl: String?
    @NSManaged public var pet: Pet?
}
 
