//
//  SGVView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI
import SwiftSVG

struct SVGView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> UIView {
        let svgURL = Bundle.main.url(forResource: name, withExtension: "svg")!
        let svgView = UIView(SVGURL: svgURL) { _ in
        }
        return svgView
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

