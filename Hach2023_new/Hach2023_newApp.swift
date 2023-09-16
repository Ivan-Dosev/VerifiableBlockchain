//
//  Hach2023_newApp.swift
//  Hach2023_new
//
//  Created by dimitrov on 15.09.23.
//

import SwiftUI
import Firebase

@main
struct Hach2023_newApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    func initFirebase() {
                         FirebaseApp.configure()
    }
}
