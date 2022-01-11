//
//  FavoritesDetails.swift
//  AnimalRescue
//
//  Created by Boshen Zhang on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//


import SwiftUI
import MapKit
 
struct FavoriteDetails: View {
   
    // Input Parameter
    let animal: AnimalStruct
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Group {
                Section(header: Text("Animal Name")) {
                    Text(animal.name)
                }
                Section(header: Text("Species")) {
                    Text(animal.species)
                }
                Section(header: Text("Breed")) {
                    Text(animal.breedString)
                }
                Section(header: Text("Animal looks")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url:animal.photoUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                }
//                Section(header: Text("Play movie trailer")) {
//                    NavigationLink(destination:
//                                    WebView(url: "http://www.youtube.com/embed/\(movie.youTubeTrailerId)")
//                                    .navigationBarTitle(Text("Play Movie Trailer"), displayMode: .inline)
//                    ){
//                        HStack {
//                            Image(systemName: "play.rectangle.fill")
//                                .imageScale(.medium)
//                                .font(Font.title.weight(.regular))
//                                .foregroundColor(.red)
//                            Text("Play YouTube Movie Trailer")
//                                .font(.system(size: 16))
//                        }
//                        .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
//                    }
//                }
                
                Section(header: Text("Animal Age")) {
                    Text("\(animal.ageString)")
                }
                Section(header: Text("Animal Sex")) {
                    Text("\(animal.sex)")
                }
                Section(header: Text("Animal Age group")) {
                    Text("\(animal.ageGroup), \(animal.ageString)")
                }
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
                
                
            

 
        }   // End of Form
        .navigationBarTitle(Text("\(animal.name)"), displayMode: .inline)
            .font(.system(size: 14))
       
    }   // End of body

}
 
struct FavoriteDetails_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDetails(animal: animalStructList[0])
    }
}
 
