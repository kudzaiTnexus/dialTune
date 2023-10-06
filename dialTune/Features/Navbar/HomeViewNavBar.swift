//
//  HomeViewNavBar.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import Foundation
import SwiftUI

struct HomeViewNavBar: View {
    @State private var isSearchActive: Bool = false
    @State private var searchText: String = ""
    @State private var showResults: Bool = false
    @State private var selectedItems: [Country] = []
    @State private var displayCount: Int = 0
    
    var countries: [Country] {
        NSLocale.isoCountryCodes.compactMap { code -> Country? in
            guard let name = Locale.current.localizedString(forRegionCode: code) else { return nil }
            
            return Country(id: code, name: name)
        }
    }
    
    var itemsMatchingSearchPredicate: [Country] {
        countries.filter { $0.displayName.contains(searchText) }
    }
    
    
    var body: some View {
        
        VStack {
            DTNavBar(
                title: .image(Image(systemName: "music.mic")),
                leadingViews: [AnyView(Button(action: {}) {
                    AnyView(Button(action: {
                        withAnimation {
                            isSearchActive.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                    })
                })],
                trailingViews: [AnyView(Button(action: {}) { Image(systemName: "bell") }),
                                AnyView(Button(action: {}) { Image(systemName: "gear") })],
                isSearchActive: isSearchActive,
                searchView: AnyView(
                    SearchView(
                        items: countries,
                        searchText: $searchText,
                        showResults: $showResults,
                        selectedItems: $selectedItems,
                        displayCount: $displayCount,
                        isSearchActive: $isSearchActive
                    )
                    .overlay(
                        showResults ?
                        AnyView(
                            SearchResultsView(
                                items: itemsMatchingSearchPredicate,
                                selectedItems: $selectedItems,
                                searchText: $searchText,
                                showResults: $showResults,
                                displayCount: $displayCount
                            )
                            .offset(y: searchResultOffsetVals)
                            .padding(.horizontal, 24)
                            .onTapGesture { }
                        )
                        : AnyView(EmptyView())
                    )
                )
            )
        }
    }
    
    // not really the most idea way to calcualte this but im open to any ideas
    // if you looking at this code please just comment or create an issue on github
    // letting me know of a better way to do this
    var searchResultOffsetVals: CGFloat {
        switch itemsMatchingSearchPredicate.count {
        case 1:
            55
        case 2:
            90
        case 3:
            120
        case 4:
            160
        default:
            180
        }
    }
}
