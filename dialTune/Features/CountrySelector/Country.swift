//
//  Country.swift
//  dialTune
//
//  Created by KudzaisheMhou on 04/10/2023.
//

import Foundation

struct Country: Identifiable, Hashable {
    let id: String
    let name: String
}

extension Country: SearchableItem {
    var codeName: String { self.id }
    var displayName: String { self.name }
}
