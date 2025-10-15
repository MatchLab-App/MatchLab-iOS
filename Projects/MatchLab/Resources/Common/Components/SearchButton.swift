//
//  SearchButton.swift
//  MatchLab
//
//  Created by 나현흠 on 10/14/25.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button(action: {}, label: {
            if #available(iOS 26.0, *) {
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .foregroundColor(.gray)
                        .opacity(0.1)
                        .glassEffect()
                        .padding(.horizontal, 46)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.appleSDGothicNeo(.black, size: 24))
                            .padding(.leading, 19)
                            .padding(.trailing, 30)
                        
                        Text("이름으로 타입 검색")
                            .foregroundColor(.gray)
                            .font(.appleSDGothicNeo(.bold, size: 20))
                        Spacer()
                    }
                    .frame(height: 58)
                    .padding(.horizontal, 46)
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
                        
                        Text("이름으로 타입 검색")
                            .foregroundColor(.gray)
                            .font(.appleSDGothicNeo(.bold, size: 20))
                        Spacer()
                    }
                    .frame(height: 58)
                    .padding(.horizontal, 46)
                }
            }
        })
    }
}

#Preview {
    SearchButton()
}
