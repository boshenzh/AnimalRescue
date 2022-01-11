//
//  AnimalStruct.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

public struct Animal: Hashable, Codable, Identifiable {
    public var id: String        // Storage Type: String, Use Type (format): UUID
    var animalType: String
    var photoUrl: String
}

public struct AnimalStruct: Hashable, Codable, Identifiable {
    public var id: String        // Storage Type: String, Use Type (format): UUID
    var adoptionFeeString: String
    var ageGroup: String
    var ageString: String
    var availableDate: String
    var birthDate: String
    var breedString: String
    var colorDetails: String
    var indoorOutdoor: String
    var name: String
    var species: String
    var sex: String
    var url: String
    var photoUrl: String
}
