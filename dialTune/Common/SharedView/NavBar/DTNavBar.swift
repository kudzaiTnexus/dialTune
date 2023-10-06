//
//  DTNavBar.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import SwiftUI

enum NavigationTitle {
    case text(String)
    case image(Image)
}

struct DTNavBar<Leading: View, Trailing: View>: View {
    var title: NavigationTitle
    var leadingViews: [Leading]?
    var trailingViews: [Trailing]?
    var isSearchActive: Bool
    var searchView: AnyView?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                HStack {
                    if !isSearchActive {
                        HStack(spacing: 10) {
                            ForEach(0..<(leadingViews?.count ?? 0), id: \.self) {
                                leadingViews?[$0]
                                    .frame(width: 30, height: 30)
                                    .scaledToFill()
                            }
                        }
                        .frame(width: geometry.size.width * 0.25, alignment: .leading)

                    Spacer()
                    
                    switch title {
                    case .text(let titleText):
                        Text(titleText)
                            .font(.headline)
                            .foregroundColor(.primary)
                    case .image(let titleImage):
                        titleImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 24)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        ForEach(0..<(trailingViews?.count ?? 0), id: \.self) {
                            trailingViews?[$0]
                        }
                    }
                    .frame(width: geometry.size.width * 0.25, alignment: .trailing)
                    } else if let searchV = searchView {
                        searchV
                            .frame(height: 30)
                            .transition(.move(edge: .leading))
                            .animation(.snappy(duration: 0.8, extraBounce: 0.1))
                            .frame(width: geometry.size.width)
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.2))
            }
        }
        .frame(height: 60)
    }
}



//#Preview {
//    DTNavBar()
//}

