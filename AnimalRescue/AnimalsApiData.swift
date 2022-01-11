//
//  AnimalsApiData.swift
//  AnimalRescue
//
//  Created by Sami Tamim on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import Foundation

var catsGridList = [Animal]()
var dogsGridList = [Animal]()
var foxesGridList = [Animal]()
var randomAnimalsList = [Animal]()
var catFacts = [String]()

/*
 ******************************
 MARK: - Get JSON Data from API
 ******************************
 */
public func getJsonDataFromApi(apiUrl: String) -> Data? {
    
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return nil
    }
    
    let jsonData: Data?
    do {
        /*
         Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
         Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
         */
        jsonData = try Data(contentsOf: apiQueryUrlStruct!, options: Data.ReadingOptions.mappedIfSafe)
        return jsonData
        
    } catch {
        return nil
    }
}

public func populateLists() {
    catsGridList = [Animal]()
    dogsGridList = [Animal]()
    foxesGridList = [Animal]()
    randomAnimalsList = [Animal]()
    catFacts = [String]()
    getCatFactsFromApi()
    catFacts.shuffle()
    for _ in 1...50 {
        catsGridList.append(getCatFromApi())
        dogsGridList.append(getDogFromApi())
        foxesGridList.append(getFoxFromApi())
    }
    
    for index in 1...48 {
        let number = Int.random(in: 1...3)
        switch number {
        case 1:
            randomAnimalsList.append(catsGridList[index])
        case 2:
            randomAnimalsList.append(dogsGridList[index])
        case 3:
            randomAnimalsList.append(foxesGridList[index])
        default:
            break
        }
    }
    
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getCatFromApi() -> Animal {
    let catPictureUrl = "https://aws.random.cat/meow"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: catPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving cat")
            return getCatFromApi()
        }
        
        if let photoLink = jsonDataDictionary["file"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getCatFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving cat")
            return getCatFromApi()
        }
        
    }
    catch {
        print("error retrieving cat")
    }
    
    return Animal(id: UUID().uuidString, animalType: "Cat", photoUrl: photoUrl)
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getDogFromApi() -> Animal {
    let dogPictureUrl = "https://dog.ceo/api/breeds/image/random"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: dogPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving dog")
            return getDogFromApi()
        }
        
        if let photoLink = jsonDataDictionary["message"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getDogFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving dog")
            return getDogFromApi()
        }
        
    }
    catch {
        print("error retrieving dog")
    }
    
    return Animal(id: UUID().uuidString, animalType: "Dog", photoUrl: photoUrl)
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getFoxFromApi() -> Animal {
    let foxPictureUrl = "https://randomfox.ca/floof/"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: foxPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving fox")
            return getFoxFromApi()
        }
        
        if let photoLink = jsonDataDictionary["image"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getFoxFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving fox")
            return getFoxFromApi()
        }
        
    }
    catch {
        print("error retrieving fox")
    }
    
    return Animal(id: UUID().uuidString, animalType: "Fox", photoUrl: photoUrl)
}

public func getCatFactsFromApi() {
    catFacts = [String]()
    let catFactsUrl = "https://cat-fact.herokuapp.com/facts"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: catFactsUrl)
    
    /*
     
     {"all":[{"_id":"58e00a1a0aac31001185ed18","text":"Cats and humans have nearly identical sections of the brain that control emotion.","type":"cat","user":{"_id":"58e007480aac31001185ecef","name":{"first":"Kasimir","last":"Schulz"}},"upvotes":12,"userUpvoted":null},{"_id":"5b0c5e3e7ab3c50014df65fe","text":"People who own cats have on average 2.1 pets per household, where dog owners have about 1.6.","type":"cat","user":{"_id":"5a9ac18c7478810ea6c06381","name":{"first":"Alex","last":"Wohlbruck"}},"upvotes":8,"userUpvoted":null},{"_id":"58e00a000aac31001185ed15","text":"Female cats are typically right-pawed while male cats are typically left-pawed.","type":"cat","user":{"_id":"58e007480aac31001185ecef","name":{"first":"Kasimir","last":"Schulz"}},"upvotes":8,"userUpvoted":null},{"_id":"5b1b4055841d9700146158d3","text":"Scottish sailer Alexander Selkirk once survived for 4 years on a deserted island thanks to feral cats that protected him from large rats during the night.","type":"cat","user":{"_id":"5a9ac18c7478810ea6c06381","name":{"first":"Alex","last":"Wohlbruck"}},"upvotes":7,"userUpvoted":null},{"_id":"599f89639a11040c4a163440","text":"Here is a video of some cats in zero gravity. youtu.be/O9XtK6R1QAk","type":"cat","user":{"_id":"5a9ac18c7478810ea6c06381","name":{"first":"Alex","last":"Wohlbruck"}},"upvotes":7,"userUpvoted":null}
     ]}
     
     */
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving cat facts object")
            return
        }
        
        if let jsonArray = jsonDataDictionary["all"] as? [Any] {
            for aJsonObject in jsonArray {
                
                var resultJsonObject = [String: Any]()
                
                if let jObject = aJsonObject as? [String: Any] {
                    resultJsonObject = jObject
                } else {
                    print("error retrieving cat facts results object")
                    return
                }
                
                if let upvotes = resultJsonObject["upvotes"] as? Int {
                    if (upvotes <= 0) {
                        break
                    }
                } else {
                    print("error retrieving cat facts text object")
                    return
                }
                
                if let text = resultJsonObject["text"] as? String {
                    catFacts.append(text)
                } else {
                    print("error retrieving cat facts text object")
                    return
                }
            }
        } else {
            // Return an empty response indicating that API access was unsuccessful
            print("error retrieving cat fact")
            return
        }
    }
    catch {
        print("error retrieving cat fact")
        return
    }
}
