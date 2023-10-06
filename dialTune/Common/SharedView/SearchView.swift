//
//  SearchView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 04/10/2023.
//

import SwiftUI

protocol SearchableItem: Identifiable, Hashable {
    var codeName: String { get }
    var displayName: String { get }
}

struct SearchView<Item: SearchableItem>: View {
    
    var items: [Item]
    @Binding var searchText: String
    @Binding var showResults: Bool
    @Binding var selectedItems: [Item]
    @Binding var displayCount: Int
    @Binding var isSearchActive: Bool
    
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var animationOffset: CGFloat = -150
    

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField(" Country Search...", text: $searchText)
                    .focused($isTextFieldFocused)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onChange(of: searchText) { value in
                        withAnimation {
                            showResults = !value.isEmpty
                            displayCount = min(items.filter { $0.displayName.contains(value) }.count, 5)
                        }
                    }
                    .onChange(of: isTextFieldFocused) { val in
                        withAnimation {
                            showResults = val
                            displayCount = min(items.filter { $0.displayName.contains(searchText) }.count, 5)
                        }
                    }
                
                // Add the cancel button
                if isSearchActive {
                    Button(action: {
                        withAnimation {
                            searchText = ""
                            isSearchActive = false
                            showResults = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(height: 50)
            .background(
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(hex: "#E0E0E0"))
                        
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color(hex: "#FFCCBC"), Color.clear]), startPoint: .leading, endPoint: .trailing)
                            .offset(x: animationOffset)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 1.4)
                            .onAppear() {
                                withAnimation(Animation.linear(duration: 4.8).repeatForever(autoreverses: true)) {
                                    withAnimation {
                                        animationOffset = UIScreen.main.bounds.width - 50
                                    }
                                }
                            }
                    }
                    .clipped()
                }
            )
            .transition(.opacity)
            .animation(.smooth, value: showResults)
            

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 12) {
                ForEach(selectedItems, id: \.self) { item in
                    HStack {
                        Text(item.displayName)
                            .font(.system(size: 12, weight: .semibold))
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Image(systemName: "xmark.circle.fill")
                            .onTapGesture {
                                withAnimation {
                                    if let index = selectedItems.firstIndex(of: item) {
                                        selectedItems.remove(at: index)
                                    }
                                }
                            }
                    }
                    .frame(height: 30)
                    .padding(.horizontal, 4)
                    .background(Color(hex: "#EEEEEE"))
                    .cornerRadius(4)
                }
            }
            .transition(.move(edge: .trailing))
            .animation(.easeIn(duration: 0.4), value: showResults)
        }
        .padding(.leading, 8)
        .padding(.trailing, 30)
    }
}
