//
//  ProfileViewModel.swift
//  Clean.City
//
//  Created by Codex.
//

import Foundation
import FirebaseAuth

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?

    struct Profile: Identifiable, Codable {
        let id: String
        let username: String
        let displayName: String
        let avatarUrl: String?
        let city: String?
        let bio: String?
        let createdAt: Date
        let updatedAt: Date
    }

    private struct CreateProfileRequest: Codable {
        let username: String
        let displayName: String
        let avatarUrl: String?
        let city: String?
        let bio: String?
    }

    /// Fetches the user profile from the backend, creating or updating it as needed.
    func fetchProfile(uid: String) async {
        guard let user = Auth.auth().currentUser else {
            print("❌ No authenticated Firebase user")
            return
        }
        let username = user.email ?? user.uid
        let displayName = user.displayName ?? username
        let avatarUrl = user.photoURL?.absoluteString
        print("uid: \(uid)")
        let requestBody = CreateProfileRequest(
            username: username,
            displayName: displayName,
            avatarUrl: avatarUrl,
            city: nil,
            bio: nil
        )
        
        print("request body: \(requestBody)")

        guard let url = URL(string: "https://d8b0-45-12-26-249.ngrok-free.app/profiles/\(uid)") else {
            print("❌ Invalid URL for profile endpoint")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(requestBody)

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("❌ Backend error: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }

            let decoder = JSONDecoder()
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                guard let date = isoFormatter.date(from: dateString) else {
                    throw DecodingError.dataCorruptedError(in: container,
                        debugDescription: "Invalid date: \(dateString)")
                }
                return date
            }
            let fetchedProfile = try decoder.decode(Profile.self, from: data)
            self.profile = fetchedProfile
        } catch {
            print("❌ Failed to fetch profile:", error.localizedDescription)
        }
    }
}
