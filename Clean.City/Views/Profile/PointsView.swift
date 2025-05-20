//
//  PointsView.swift
//  Clean.City
//
//  Created by Liudmyla Minkovets on 19.05.2025.
//

import SwiftUI

struct Offer: Identifiable {
    let id = UUID()
    let imageName: String
    let brandIconName: String
    let title: String
    let description: String
    let points: Int
}

struct PointsView: View {
    @Environment(\.dismiss) var dismiss

    let ecoProducts: [Offer] = [
        Offer(
            imageName: "eco1",
            brandIconName: "gola-grechka-icon",
            title: "Гола гречка",
            description: "Знижка 20% на Набір «Прибирай з любов’ю»",
            points: 200
        ),
        Offer(
            imageName: "eco2",
            brandIconName: "no-waste-icon",
            title: "No Waste Coffee Shop",
            description: "Даруємо люфу для посуду і тіла",
            points: 300
        ),
        Offer(
            imageName: "eco1",
            brandIconName: "gola-grechka-icon",
            title: "Гола гречка",
            description: "Знижка 20% на Набір «Прибирай з любов’ю»",
            points: 200
        )
    ]

    let foodDrinks: [Offer] = [
        Offer(
            imageName: "vegan",
            brandIconName: "vegetus-icon",
            title: "Vegetus",
            description: "Знижка 10% на весь асортимент",
            points: 200
        ),
        Offer(
            imageName: "coffee",
            brandIconName: "no-waste-icon",
            title: "No Waste Coffee Shop",
            description: "Пригощаємо кавою безоплатно",
            points: 150
        ),
        Offer(
            imageName: "eco1",
            brandIconName: "gola-grechka-icon",
            title: "Гола гречка",
            description: "Знижка 20% на Набір «Прибирай з любов’ю»",
            points: 200
        )
    ]


    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                Color("BackgroundGreen").ignoresSafeArea()

                VStack(spacing: 0) {
                    headerSection

                    VStack(alignment: .leading, spacing: 16) {
                        categorySection(title: "Еко-товари", offers: ecoProducts)
                        categorySection(title: "Їжа та напої", offers: foodDrinks)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(32, corners: [.topLeft, .topRight])
                    .offset(y: -40)
                }
            }
        }
        .ignoresSafeArea()
    }


    private var headerSection: some View {
        ZStack(alignment: .topLeading) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 280)

                SVGView(name: "Vector_7")
                    .frame(width: 0, height: 200)
                    .ignoresSafeArea()

                SVGView(name: "Vector_8")
                    .frame(width: 390, height: 266)
                    .ignoresSafeArea()

                HStack {
                    Spacer()
                    Image("seedling")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .offset(x: -10, y: 20)
                }
                .padding(.trailing)
                HStack {
                    Spacer()
                    Image("seedling")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .offset(x: 12, y: 60)
                        .rotationEffect(.degrees(30))
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                    }

                    Spacer()

                    Text("Пропозиції")
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "info.circle")
                    }
                }
                .font(.title3)
                .foregroundColor(.black)
                .padding(.horizontal)

                VStack(spacing: 12) {
                    Text("360")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("балів")
                        .font(.title2)

                    Button(action: {}) {
                        Label("історія", systemImage: "clock.arrow.circlepath")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal, 32)
            }
            .padding(.top, 60)
        }
        .frame(height: 280)
    }



    private func categorySection(title: String, offers: [Offer]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Button("Показати усі") { }
                    .font(.subheadline)
                    .foregroundColor(Color.darkGreen)
            }
            .padding(.top, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(offers) { offer in
                        VStack(spacing: 0) {
                            ZStack(alignment: .topTrailing) {
                                Image(offer.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 180, height: 100)
                                    .clipped()
                                    .cornerRadius(12, corners: [.topLeft, .topRight])

                                HStack(spacing: 4) {
                                    Image(systemName: "leaf.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                    Text("\(offer.points)")
                                        .font(.caption).bold()
                                }
                                .padding(6)
                                .foregroundColor(.white)
                                .background(Color.darkGreen)
                                .clipShape(Capsule())
                                .padding(8)
                            }

                            ZStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(offer.title)
                                        .font(.subheadline)
                                        .bold()
                                    Text(offer.description)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.lightGrey)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])

                                Image(offer.brandIconName)
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: -36)
                            }
                        }
                        .frame(width: 180)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                }
            }

        }
    }
}



#Preview {
    PointsView()
}
