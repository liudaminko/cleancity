//
//  LoginView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            SVGView(name: "Vector_3")
                .ignoresSafeArea()
                .frame(width: 430, height: 500)
            SVGView(name: "Vector_4")
                .ignoresSafeArea()
                .frame(width: 350, height: 770)

            VStack {
                Text("Увійти\nдо акаунту")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.top, 60)

                Spacer()

                VStack(spacing: 16) {
                    TextField("Email", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)

                    SecureField("Пароль", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)

                    Button(action: {}) {
                        Text("Забули пароль?")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .underline()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    
                    Button(action: {}) {
                        Text("Увійти")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(Color.darkGreen)
                            .clipShape(Capsule())
                    }
                    .padding(.vertical, 32)

                }

                VStack(spacing: 4) {
                    Text("Немає акаунту?")                            .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 8)

                    Button(action: {}) {
                        Text("Зареєструватися")
                            .font(.system(size: 16, weight: .semibold))
                            .underline()
                    }
                }
                .font(.system(size: 14))
                .foregroundColor(.black)
                .padding(.top, 8)

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}


#Preview {
    LoginView()
}
