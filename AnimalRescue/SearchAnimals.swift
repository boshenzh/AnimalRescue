
//
//  Search.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/6/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//
import SwiftUI

struct SearchAnimals: View {
    //@State private var searchFieldValue = ""
    @State private var showMissingInputDataAlert = false

    let searchSpecies = ["alpacas", "birds", "cats", "chickens", "chinchillas", "cows", "degus", "dogs", "donkeys",
                         "ducks", "ferrets", "fish", "frogs", "geckos", "geese", "gerbils", "goats", "groundhogs",
                         "guineapigs", "hamsters", "hedgehogs", "hermitcrabs", "horses", "iguanas", "lizards", "llama",
                         "mice", "otters", "pigs", "ponies", "prairiedogs", "rabbits", "rats", "sheep", "skunks", "snakes",
                         "sugargliders", "tarantulas", "tortoises", "turkeys", "turtles"]
    
    
    @State private var selectedIndex = 2
    @State private var previousIndex = -1

    @State private var searchCompleted = false

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                Form {
                    
                    
                    Section(header: Text("Select Species")) {
                        Picker("Selected animal:", selection: $selectedIndex) {
                            ForEach(0 ..< searchSpecies.count, id: \.self) {
                                Text(self.searchSpecies[$0])
                            }
                        }
                        //.pickerStyle(WheelPickerStyle())
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    }
                    
                    
                    
                    Section(header: Text("Search Animal")) {
                        HStack {
                            Button(action: {
                                if self.inputDataValidated() {
                                    self.searchApi()
                                    self.searchCompleted = true
                                } else {
                                    self.showMissingInputDataAlert = true
                                }
                            }) {
                                Text(self.selectedIndex == self.previousIndex ? "Search Completed" : "Search")
                            }
                            .frame(width: 240, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                        }   // End of HStack
                    }
                    
                    if self.selectedIndex == self.previousIndex {
                        Section(header: Text("Show Animals Found")) {
                            NavigationLink(destination: showSearchResults) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                        .foregroundColor(.blue)
                                    Text("Show Animals")
                                        .font(.system(size: 16))
                                }
                            }
                            .frame(minWidth: 300, maxWidth: 500)
                        }
                    }
                    
                }   // End of Form
                .navigationBarTitle(Text("Search Animals"), displayMode: .inline)
                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })
                
            }   // End of ZStack
            
        }   // End of NavigationView
        .customNavigationViewStyle()  // Given in NavigationStyle.swift
        
    }   // End of body
    
    /*
     ------------------
     MARK: - Search API
     ------------------
     */
    func searchApi() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        //let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        self.previousIndex = self.selectedIndex
        getAnimalRescueDataFromApi(animal: self.searchSpecies[self.selectedIndex])
        // Public function obtainCountryDataFromApi is given in CountryApiData.swift
        //obtainCountryDataFromApi(category: searchCategories[selectedIndex], query: queryTrimmed)
    }
    
    /*
     ---------------------------
     MARK: - Show Search Results
     ---------------------------
     */
    var showSearchResults: some View {
        
        // Global variable countryFound is given in CountryApiData.swift
        if rescueGroupsAnimalsList.isEmpty {
            return AnyView(notFoundMessage)
        }
        return AnyView(SearchResults())
    }
    
    /*
     ---------------------------------
     MARK: - Country Not Found Message
     ---------------------------------
     */
    var notFoundMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("No Animal Found!\n\n No \(self.searchSpecies[self.selectedIndex]) found from the API! Please enter another search query.")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
    }
    
    /*
     --------------------------------
     MARK: - Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("Country Search Field is Empty!"),
              message: Text("Please enter a search query!"),
              dismissButton: .default(Text("OK")) )
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }
    
    /*
     -----------------------------
     MARK: - Input Data Validation
     -----------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        //let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //if queryTrimmed.isEmpty {
        //    return false
        //}
        return true
    }
    
}
