//
//  HomeView.swift
//  MatchLab
//
//  Created by 나현흠 on 8/6/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isPressed: Bool = false
    @State private var typeSelect: Bool = false
    @State private var selectedType1: PokemonType = .noType
    @State private var selectedType2: PokemonType = .noType
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("bottomColor")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            if selectedType1 == .noType {
                VStack {
                    NavigationBar(isSelected: .constant(selectedType1 != .noType))
                        .padding(.bottom, 19)
                    SearchButton()
                        .padding(.bottom, 41)
                    OpponentType()
                        .padding(.bottom, 39)
                    Image("SelectedTriangle")
                        .padding(.bottom, 11)
                    OpponentButton(selectedType1: $selectedType1, selectedType2: $selectedType2)
                        .padding(.bottom, 40)
                    Text(oppopentTypeSelect)
                        .foregroundStyle(Color.textGray)
                        .font(.appleSDGothicNeo(.regular, size: 15))
                        .padding(.bottom, 47)
                    CustomDivider()
                        .padding(.bottom, 33)
                    
                    TypeSelectCarousel(selectedType1: $selectedType1, selectedType2: $selectedType2)
                    Spacer()
                }
            } else {
                VStack {
                    NavigationBar(isSelected: .constant(selectedType1 != .noType))
                        .padding(.bottom, 40)
                    OpponentType()
                        .padding(.bottom, 39)
                    Image("SelectedTriangle")
                        .padding(.bottom, 11)
                    OpponentButton(selectedType1: $selectedType1, selectedType2: $selectedType2)
                        .padding(.bottom, 40)
                    Text(opponentTypeSelect2)
                        .foregroundStyle(Color.textGray)
                        .font(.appleSDGothicNeo(.regular, size: 15))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.bottom, 30)
                    NextButton()
                        .padding(.bottom, 33)
                    CustomDivider()
                        .padding(.bottom, 33)
                    
                    TypeSelectCarousel(selectedType1: $selectedType1, selectedType2: $selectedType2)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
