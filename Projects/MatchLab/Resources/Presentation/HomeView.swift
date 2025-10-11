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
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black, Color("bottomColor")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    HomeView()
}
