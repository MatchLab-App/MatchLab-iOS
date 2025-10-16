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
    @State private var selectedType2: PokemonType = .fire
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("bottomColor")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                NavigationBar()
                    .padding(.bottom, 19)
                SearchButton()
                    .padding(.bottom, 41)
                OpponentType()
                    .padding(.bottom, 39)
                Image("SelectedTriangle")
                    .padding(.bottom, 11)
                OpponentButton(selectedType1: $selectedType1, selectedType2: $selectedType2)
                
                Spacer()
            }
        }
    }
    struct OpponentType: View {
        var body: some View {
            VStack(spacing: 0) {
                Text(opponentType)
                    .font(.appleSDGothicNeo(.bold, size: 24))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 8)
                Text(opponentTypeDescription)
                    .font(.appleSDGothicNeo(.light, size: 15))
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    HomeView()
}
