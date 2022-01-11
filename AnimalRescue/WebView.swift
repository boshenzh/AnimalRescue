//
//  WebView.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/7/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    // Input Parameter
    let url: String
 
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView(frame: .zero)
    }
 
    // A WKWebView object displays interactive web content in a web browser within the app
    func updateUIView(_ webView: WKWebView, context: Context) {
       
        // Convert url from String type to URL struct type
        guard let urlStruct = URL(string: url) else {
            // Show nothing since url is invalid
            return
        }
        /*
         Convert the URL struct into a URLRequest struct.
         URLRequest is a URL load request that is independent of protocol or URL scheme.
         */
        let urlLoadRequest = URLRequest(url: urlStruct)
       
        /*
         Swiping from left screen edge to right shows the previous (back) web view.
         Swiping from right screen edge to left shows the next (forward) web view.
         */
        webView.allowsBackForwardNavigationGestures = true
     
        // Ask the webView object to display the web page for the given url
        webView.load(urlLoadRequest)
    }
 
}
 
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.apple.com")
    }
}
 
 
