//
//  FavoritesWidget.swift
//  FavoritesWidget
//
//  Created by Sami Tamim on 12/6/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    // Load animal data from favorites list
    @AppStorage("animal", store: UserDefaults(suiteName: "group.com.TahmidMuttaki.AnimalRescue.AnimalWidget"))
    var widgetData: Data = Data()
    
    func placeholder(in context: Context) -> AnimalEntry {
        AnimalEntry(date: Date(), pictureUrl: "...", animalName: "...")
    }

    func getSnapshot(in context: Context, completion: @escaping (AnimalEntry) -> ()) {
        guard let animal = try? JSONDecoder().decode([AnimalStruct].self, from: widgetData)
        else {
            print("error decoding animal")
            return
        }
        let randomNum = Int.random(in: 0 ..< animal.count)
        let entry = AnimalEntry(date: Date(), pictureUrl: animal[randomNum].photoUrl, animalName: animal[randomNum].name)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [AnimalEntry] = []
        
        guard let animal = try? JSONDecoder().decode([AnimalStruct].self, from: widgetData)
        else {
            print("error decoding animal")
            return
        }
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 3 {
            let randomNum = Int.random(in: 0 ..< animal.count)
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = AnimalEntry(date: entryDate, pictureUrl: animal[randomNum].photoUrl, animalName: animal[randomNum].name)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct AnimalEntry: TimelineEntry {
    let date: Date
    let pictureUrl: String
    let animalName: String
}

struct FavoritesWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color
                .white
                .edgesIgnoringSafeArea(.all)
            
            getImageFromUrl(url: entry.pictureUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack{
                Text(entry.animalName)
                    .padding(.top, 10)
                Spacer()
            }
            
        }
    }
}

@main
struct FavoritesWidget: Widget {
    let kind: String = "FavoritesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FavoritesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Favorites Widget")
        .description("This widget will show images of favorite pets.")
    }
}

struct FavoritesWidget_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesWidgetEntryView(entry: AnimalEntry(date: Date(), pictureUrl: "...", animalName: "..."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
