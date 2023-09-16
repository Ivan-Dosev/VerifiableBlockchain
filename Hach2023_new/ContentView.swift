//
//  ContentView.swift
//  Hach2023_new
//
//  Created by dimitrov on 15.09.23.
//

import SwiftUI
import web3swift
import  CryptoKit

struct ContentView: View {
    


    
    var body: some View {
        TabView {
            OneView()
                .tabItem {
                    Label("University", systemImage: "scroll.fill")
                }

            TwoView()
                .tabItem {
                    Label("Richemont", systemImage: "calendar.badge.clock")
                }
            
            ScanView()
                .tabItem {
                    Label("Scanner", systemImage: "arrow.triangle.2.circlepath.camera.fill")
                }
            PersonView()
                .tabItem {
                    Label("Login", systemImage: "person.circle")
                }
        }
        .tint(.black)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

