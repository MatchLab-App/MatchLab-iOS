//
//  HomeView.swift
//  MatchLab
//
//  Created by 나현흠 on 8/6/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("bottomColor")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("MatchLabLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 67)
                    .padding(.top, 55)
                    
                
                RoundedRectangle(cornerRadius: 10)
                    .padding(.horizontal, 123)
                    .padding(.top, 30)
                    .padding(.bottom, 120)
                    .frame(maxWidth: .infinity)
                
                Text("버튼을 눌러 \n 상대의 타입을 선택해주세요")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 185)
                    .padding(.horizontal, 120)
                    .lineLimit(2)
                    .font(.system(size: 14))
                    .fixedSize(horizontal: false, vertical: true)
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .opacity(0.1)
                        .ignoresSafeArea(edges: .all)
                    
                    TypeButton(imageName: "grass")
                }
                
                ForEach(TypeList, id: \.self) { type in
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
