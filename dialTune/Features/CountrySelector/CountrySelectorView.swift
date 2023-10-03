//
//  CountrySelectorView.swift
//  dialTune
//
//  Created by KudzaisheMhou on 03/10/2023.
//

import SwiftUI

struct CountrySelectorView: View {
    
    var countries: [Country] {
        NSLocale.isoCountryCodes.compactMap { code -> Country? in
            guard let name = Locale.current.localizedString(forRegionCode: code) else { return nil }
            
            return Country(id: code, name: name)
        }
    }
    
    var body: some View {
        SearchView(items: countries)
    }
 
}

#Preview {
    CountrySelectorView()
}
