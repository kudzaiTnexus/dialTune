//
//  GenericRail.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import Foundation
import SwiftUI

struct GenericRail<Content: CardView>: View {
    var items: [Content]
    @State private var showAll: Bool = false
    
    var displayItems: [Content] {
        if showAll {
            return items
        }
        return Array(items.prefix(4))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<displayItems.count, id: \.self) { index in
                    GeometryReader { geometry in
                        let minX = geometry.frame(in: .global).minX
                        let normalizedOffset = (minX - UIScreen.main.bounds.width / 2 + Content.width / 2) / UIScreen.main.bounds.width
                        let scale = 1 + 0.1 * normalizedOffset
                        let rotation = Angle(degrees: Double(normalizedOffset * 15))
                        
                        displayItems[index]
                            .frame(width: Content.width, height: Content.height)
                            .scaleEffect(scale)
                            .rotationEffect(rotation)
                    }
                    .frame(width: Content.width, height: Content.height)
                }
                
                if !showAll {
                    Button(action: {
                        withAnimation {
                            showAll = true
                        }
                    }, label: {
                        Text("Load More")
                            .frame(width: Content.width, height: Content.height)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                }
            }
            .padding()
        }
    }
}






