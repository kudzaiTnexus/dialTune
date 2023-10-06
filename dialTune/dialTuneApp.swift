//
//  dialTuneApp.swift
//  dialTune
//
//  Created by KudzaisheMhou on 01/10/2023.
//

import SwiftUI
import Combine

@main
struct dialTuneApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .navigationBarHidden(true)
            }
            .safeAreaInset(edge: .top) {
                HomeViewNavBar()
            }
        }
    }
}



