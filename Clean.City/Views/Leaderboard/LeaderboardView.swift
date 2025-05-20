//
//  LeaderboardView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct UserScore: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
    let place: Int
}

struct LeaderboardView: View {
    @State private var selectedTab = "По місту"
    private let tabs = ["По місту", "По країні"]

    private let users: [UserScore] = [
        UserScore(name: "Олексій А.", score: 380, place: 1),
        UserScore(name: "Людмила М.", score: 360, place: 2),
        UserScore(name: "Олексій А.", score: 270, place: 3),
        UserScore(name: "Антон Г.", score: 260, place: 4),
        UserScore(name: "Ірина К.", score: 255, place: 5),
        UserScore(name: "Ігор С.", score: 250, place: 6),
        UserScore(name: "Дмитро Л.", score: 230, place: 7),
        UserScore(name: "Володимир Б.", score: 210, place: 8),
        UserScore(name: "Сашко М.", score: 200, place: 9),
        UserScore(name: "Марина П.", score: 170, place: 10),
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Рейтинг")
                .font(.largeTitle).bold()
                .foregroundColor(.darkGreen)
            
            Spacer()

            Picker("", selection: $selectedTab) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 4)

            Text("По Львову")
                .font(.headline)
                .padding(.horizontal)

            List(users) { user in
                HStack {
                    Group {
                        if user.place == 1 {
                            Image(systemName: "trophy.fill").foregroundColor(.yellow)
                        } else if user.place == 2 {
                            Image(systemName: "trophy.fill").foregroundColor(.gray)
                        } else if user.place == 3 {
                            Image(systemName: "trophy.fill").foregroundColor(.orange)
                        } else {
                            Text("\(user.place)")
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 24)
                        }
                    }
                    Text(user.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(user.score)")
                        .foregroundColor(.black)
                }
                .padding(.vertical, 6)
            }
            .listStyle(.plain)
        }
        .padding(.horizontal)
    }
}


#Preview {
    LeaderboardView()
}
