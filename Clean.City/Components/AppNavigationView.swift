//
//  AppNavigationView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI
import CoreLocation

struct AppNavigationView: View {
    @StateObject private var locationManager = LocationManager()


    var body: some View {
        TabView {
            MapView(locationManager: locationManager)
                .tabItem {
                    Image(systemName: "map")
                    Text("Карта")
                }
                .onAppear {
                    locationManager.requestLocationAccess()
                }

            NewsView()
                .tabItem {
                    Image(systemName: "megaphone")
                    Text("Новини")
                }

            LeaderboardView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Рейтинг")
                }

            ProfileHomeView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Профіль")
                }
        }
        .tint(.darkGreen)

    }
}



#Preview {
    AppNavigationView()
}
