//
//  SearchResultsView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 04/10/2023.
//

import Foundation
import SwiftUI

struct SearchResultsView<Item: SearchableItem>: View {
    
    let items: [Item]
    @Binding var selectedItems: [Item]
    @Binding var searchText: String
    @Binding var showResults: Bool
    @Binding var displayCount: Int
    
    var body: some View {
        if showResults {
            VStack(alignment: .leading, spacing: 10) {
                List {
                    ForEach(items, id: \.self) { item in
                        HStack(spacing: 16) {
                            Image(item.codeName.lowercased())
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(item.displayName)
                            Spacer()
                            
                            Text("86")
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.vertical,2)
                                .padding(.horizontal, 8)
                                .background(Color(hex: "#E0E0E0"))
                                .cornerRadius(8)
                        }
                        .padding(5)
                        .onTapGesture {
                            selectedItems.append(item)
                            searchText = ""
                            showResults = false
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .frame(height: CGFloat(displayCount) * (24 + 16 + 24))
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 5)
            .transition(.opacity.combined(with: .scale(scale: 0.8)))
            .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 0), value: showResults)
        }
    }
}

