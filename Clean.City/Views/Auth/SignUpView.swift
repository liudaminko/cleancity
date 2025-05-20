//
//  SignUpView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            SVGView(name: "Vector_5")
                .ignoresSafeArea()
                .frame(width: 400, height: 600)
            
            SVGView(name: "Vector_6")
                .ignoresSafeArea()
                .frame(width: 410, height: 420)


            VStack {
                // Заголовок — у два рядки
                Text("Створення\nакаунту")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.top, 60)

                Spacer()

                VStack(spacing: 16) {
                    TextField("Ім’я", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)
                    
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
                    
                    SecureField("Повторити пароль", text: .constant(""))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 32)
                    
                    Button(action: {}) {
                        Text("Зареєструватися")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(.black)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 16)
                }

                VStack(spacing: 4) {
                    Text("Уже є акаунт?")                            .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, 8)

                    Button(action: {}) {
                        Text("Увійти")
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
    SignUpView()
}
