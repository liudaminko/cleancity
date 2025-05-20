//
//  MapView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI
import MapLibre
import CoreLocation

struct MapLibreView: UIViewRepresentable {
    @ObservedObject var locationManager: LocationManager
    var trashLocations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 49.8397, longitude: 24.0297), // Львів
        CLLocationCoordinate2D(latitude: 49.8419, longitude: 24.0315)
    ]

    func makeUIView(context: Context) -> MLNMapView {
        let mapView = MLNMapView(frame: .zero)
        mapView.styleURL = URL(string: "https://api.maptiler.com/maps/streets/style.json?key=BWZDOlepKGykUPlraLlR")
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MLNMapView, context: Context) {
        if let coordinate = locationManager.userLocation {
            mapView.setCenter(coordinate, zoomLevel: 14, animated: true)
        }

        mapView.removeAnnotations(mapView.annotations ?? [])

        for location in trashLocations {
            let annotation = MLNPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Сміття"
            mapView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MLNMapViewDelegate {
        func mapView(_ mapView: MLNMapView, imageFor annotation: MLNAnnotation) -> MLNAnnotationImage? {
            let identifier = "trash-icon"
            if let image = mapView.dequeueReusableAnnotationImage(withIdentifier: identifier) {
                return image
            } else {
                let image = UIImage(named: "trash-pin") ?? UIImage(systemName: "trash")!
                return MLNAnnotationImage(image: image, reuseIdentifier: identifier)
            }
        }
    }
}



#Preview {
    MapLibreView(locationManager: LocationManager())
}
