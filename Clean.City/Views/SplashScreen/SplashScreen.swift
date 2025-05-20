//
//  SplashScreen.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var visibleText = ""

    let fullText = "Чисто.City"
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 27 / 255, green: 94 / 255, blue: 32 / 255).ignoresSafeArea()
            Text(visibleText)
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
        }
        .onReceive(timer) { _ in
            if visibleText.count < fullText.count {
                let nextChar = fullText[fullText.index(fullText.startIndex, offsetBy: visibleText.count)]
                visibleText.append(nextChar)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
