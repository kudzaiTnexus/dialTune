//
//  MainView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 16) {
                
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                GenericRail(items: Array(repeating: SmallCard(), count: 10))
                RailView(railTitle: "Continue Schedule", railHeight: 320, railWidth: 260)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                RailView(railTitle: "Continue Schedule", railHeight: 150, railWidth: 300)
                
                GenericRail(items: Array(repeating: LargeCard(), count: 10))
            }
        }
        .padding(.top, 60) // this is the easier option to force scrolling under our custom nav
    }
}

#Preview {
    MainView()
}
