//
//  CardView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 06/10/2023.
//

import Foundation
import SwiftUI

protocol CardView: View {
    static var width: CGFloat { get }
    static var height: CGFloat { get }
}


struct SmallCard: View, CardView {
    static var width: CGFloat = 300
    static var height: CGFloat = 150

    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .cornerRadius(8)
    }
}

struct LargeCard: View, CardView {
    static var width: CGFloat = 380
    static var height: CGFloat = 250

    var body: some View {
        Rectangle()
            .fill(Color.red)
            .cornerRadius(8)
    }
}
