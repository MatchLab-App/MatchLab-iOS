//
//  OpponentButton.swift
//  MatchLab
//
//  Created by 나현흠 on 10/17/25.
//

import SwiftUI

let unselected_small = "미선택"

struct OpponentButton: View {
    @Binding var selectedType1: PokemonType
    @Binding var selectedType2: PokemonType
    
    var body: some View {
        Button(action: {}, label: {
            if #available(iOS 26.0, *) {
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .glassEffect(in: .rect(cornerRadius: 11))
                        .frame(maxWidth: .infinity)
                        .frame(height: 93)
                        .tint(Color.black)
                        .opacity(0.1)
                        .padding(.horizontal, 122)
                    
                    HStack {
                        VStack(spacing: 0) {
                            HStack {
                                Text(defense)
                                    .font(.appleSDGothicNeo(.bold, size: 12))
                                    .foregroundStyle(Color.gray)
                                    .padding(.leading, 128)
                                
                                Spacer()
                                Image("defence_icon")
                                    .padding(.trailing, 128)
                            }
                            HStack {
                                VStack(spacing: 0) {
                                    Image(selectedType1.smallImageName)
                                        .padding(.bottom, 6)
                                    Text(selectedType1.label)
                                        .font(.appleSDGothicNeo(.bold, size: 11))
                                        .foregroundStyle(Color.white)
                                }
                                .padding(.trailing, 8)
                                VStack(spacing: 0) {
                                    Image(selectedType2.smallImageName)
                                        .padding(.bottom, 6)
                                    Text(selectedType2.label)
                                        .font(.appleSDGothicNeo(.bold, size: 11))
                                        .foregroundStyle(Color.white)
                                }
                            }
                        }
                    }
                    
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .foregroundColor(.gray)
                        .opacity(0.1)
                        .padding(.horizontal, 46)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.appleSDGothicNeo(.black, size: 24))
                            .padding(.leading, 19)
                            .padding(.trailing, 30)
                        
                        Text(nameType)
                            .foregroundColor(.gray)
                            .font(.appleSDGothicNeo(.bold, size: 20))
                        Spacer()
                    }
                    .frame(height: 58)
                    .padding(.horizontal, 46)
                }
            }
        })
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(String(localized: "accessibility.selected.defense"))
        .accessibilityValue([selectedType1.label, selectedType2.label].joined(separator: ", "))
    }
}

//#Preview {
//    OpponentButton(selectedType1: .water, selectedType2: .fire)
//}
