//
//  ProfileHomeView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct ProfileHomeView: View {
    @State private var showPointsView = false
    @EnvironmentObject private var profileVM: ProfileViewModel

    var body: some View {
        ScrollView {
            HStack {
                Text("Профіль")
                    .font(.largeTitle).bold()
                    .foregroundColor(.darkGreen)
                Spacer()
                Button(action: {
                    // TODO: Перехід до SettingsView
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            VStack(spacing: 16) {
                header
                stats
                actions
                contributions
                achievements
            }
            .padding(.horizontal, 24)
        }
        .navigationDestination(isPresented: $showPointsView) {
            PointsView()
        }

    }

    var header: some View {
        VStack(spacing: 8) {
            if let urlString = profileVM.profile?.avatarUrl,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Image("profile_photo").resizable()
                    } else {
                        ProgressView()
                    }
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 126, height: 126)
                .clipShape(Circle())
            } else {
                Image("profile_photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 126, height: 126)
                    .clipShape(Circle())
            }

            Text(profileVM.profile?.displayName ?? "")
                .font(.system(size: 26, weight: .bold))
            Text("@\(profileVM.profile?.username ?? "")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    var stats: some View {
        VStack(spacing: 4) {
            Button(action: {
                showPointsView = true
            }) {
                HStack(spacing: 4) {
                    Text("360")
                        .bold()
                    Text("балів")
                    Image(systemName: "chevron.right")
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.lightGrey, lineWidth: 1)
                )
            }


            Text("Дослідниця Чисто.City 2025")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

    var actions: some View {
        HStack {
            ProfileStatView(label: profileVM.profile?.city ?? "-", value: "Місто")
            Divider().frame(height: 40)
            ProfileStatView(label: "3", value: "Підписки")
            Divider().frame(height: 40)
            ProfileStatView(label: "1", value: "Підписників")
        }
        .font(.subheadline)
        .foregroundColor(.black)
    }
    
    var contributions: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Твої внески").font(.system(size: 20, weight: .bold))
            Text("12 прибирань").font(.subheadline).foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.lightGrey, lineWidth: 1)
        )
    }

    var achievements: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Досягнення")
                    .font(.system(size: 20, weight: .bold))
                HStack {
                    Spacer()
                    Button("Показати усі") {}
                        .font(.footnote)
                        .underline()
                        .foregroundColor(.darkGreen)
                }
            }

            HStack(spacing: 12) {
                ForEach(0..<4) { index in
                    Circle()
                        .fill(Color.darkGreen.opacity(0.9))
                        .frame(width: 72, height: 72)
                        .overlay(
                            Image(systemName: "leaf")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(10)
                        )
                }
            }


        }
    }
}


struct ProfileStatView: View {
    var label: String
    var value: String

    var body: some View {
        VStack {
            Text(label).bold()
            Text(value).font(.caption).foregroundColor(.gray)
        }
    }
}


#Preview {
    ProfileHomeView()
}
