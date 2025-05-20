//
//  GreetView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI
import SwiftSVG
import GoogleSignIn
import GoogleSignInSwift


struct GreetView: View {
    @StateObject private var authVM = AuthViewModel() {
        didSet {
            print("✅ authVM initialized")
        }
    }
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var showSignUp = false
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        print("👀 GreetView rendered")
        return NavigationStack {
            ZStack {
                SVGView(name: "Vector")
                    .frame(width: 320, height: 700)
                    .ignoresSafeArea()
                SVGView(name: "Vector_2")
                    .frame(width: 0, height: 0)
                    .ignoresSafeArea()
                
                VStack(spacing: 30.0) {
                    VStack {
                        Text("Привіт!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 72)
                        
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "applelogo")
                                    .frame(width: 20, height: 20)
                                Text("Продовжити з Apple")
                                    .font(.system(size: 16, weight: .medium)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(16)
                        }
                        
                        Button(action: {
                            print("🟡 Button tapped")
                            Task {
                                await authVM.signInWithGoogle()
                            }
                        }) {
                            HStack {
                                Image("google-icon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Продовжити з Google")
                                    .font(.system(size: 16, weight: .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(16)
                        }
                        
                        
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 1)
                            .fill(Color.black)
                            .frame(height: 2)
                            .padding(.horizontal, 4)
                        
                        Text("або")
                            .foregroundColor(.black)
                        
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: 2)
                            .padding(.horizontal, 4)
                    }
                    .padding(.vertical, 6)
                    
                    
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                        
                        SecureField("Пароль", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                        
                        Button(action: {}) {
                            Text("Забули пароль?")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                                .underline()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        Button("Увійти") {
                            authVM.signInWithEmail(email: email, password: password) { success in
                                if success {
                                    isLoggedIn = true
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 36)
                        .padding(.vertical, 12)
                        .background(Color.black)
                        .clipShape(Capsule())
                        
                    }
                    
                    HStack(spacing: 4) {
                        Text("Немає акаунту?")
                            .foregroundColor(.black)
                        Button("Зареєструватися") {
                            showSignUp = true
                        }
                        .underline()
                        .foregroundColor(.black)
                        
                    }
                    .font(.system(size: 14, weight: .semibold))
                    
                    Spacer()
                    
                    Text("Покращуй своє місто разом з нами")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.darkGreen)
                        .padding(.bottom, 24)
                    
                    .navigationDestination(isPresented: $isLoggedIn) {
                        AppNavigationView()
                    }
                    .navigationDestination(isPresented: $showSignUp) {
                        SignUpView()
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    GreetView()
}
