//
//  UserData.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    /*
     -------------------------------
     MARK: - Slide Show Declarations
     -------------------------------
     */
    let numberOfImagesInSlideShow = 9
    var counter = 0
    /*
     Create a Timer using initializer () and store its object reference into slideShowTimer.
     A Timer() object invokes a method after a certain time interval has elapsed.
     */
    var slideShowTimer = Timer()
    
    /*
     ===============================================================================
     MARK: -               Publisher-Subscriber Design Pattern
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
     
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
     
     When a change occurs in userData (e.g., deleting a country from the list, reordering countries list,
     adding a new country to the list), every View subscribed to it is notified to re-render its View.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     NOTE:  Only Views can subscribe to it. You cannot subscribe to it within
     a non-View Swift file such as our CountriesData.swift file.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
    
    // Publish imageNumber to refresh the View body in Home.swift when it is changed in the slide show
    @Published var imageNumber = 0
    
    @Published var animalsList = animalStructList
    @Published var searchableOrderedAnimalsList = orderedSearchableAnimalsList
    
    // Publish if the user is authenticated or not
    @Published var userAuthenticated = false
    @Published var savedInDatabase =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)

    /*
     --------------------------
     MARK: - Scheduling a Timer
     --------------------------
     */
    public func startTimer() {
        // Stop timer if running
        stopTimer()
        
        /*
         Schedule a timer to invoke the fireTimer() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        slideShowTimer = Timer.scheduledTimer(timeInterval: 3,
                                              target: self,
                                              selector: (#selector(fireTimer)),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    public func stopTimer() {
        counter = 0
        slideShowTimer.invalidate()
    }
    
    @objc func fireTimer() {
        counter += 1
        if counter == numberOfImagesInSlideShow {
            counter = 0
        }
        /*
         Each time imageNumber is changed here, the View body in Home.swift will be re-rendered to
         reflect the change since it subscribes to changes in imageNumber as specified above.
         */
        imageNumber = counter
    }
    
}

