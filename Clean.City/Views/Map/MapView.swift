//
//  MapView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

enum FilterType: String, CaseIterable, Identifiable {
    case сміття, картон, скло, одяг

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .сміття: return "trash"
        case .картон: return "arrow.2.circlepath"
        case .скло: return "drop"
        case .одяг: return "tshirt"
        }
    }
}

import SwiftUI

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFilter: FilterType = .сміття

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Карта")
                    .font(.largeTitle).bold()
                    .foregroundColor(.primary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(FilterType.allCases, id: \.self) { filter in
                            HStack {
                                Image(systemName: filter.iconName)
                                Text(filter.rawValue)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                selectedFilter == filter ?
                                    Color.darkGreen :
                                    Color(UIColor.systemGray5)
                            )
                            .foregroundColor(selectedFilter == filter ? .white : .primary)
                            .clipShape(Capsule())
                            .onTapGesture {
                                selectedFilter = filter
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                colorScheme == .dark ? Color.black : Color.white
            )
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            
            MapLibreView(locationManager: locationManager)
                .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    MapView(locationManager: LocationManager())
}
