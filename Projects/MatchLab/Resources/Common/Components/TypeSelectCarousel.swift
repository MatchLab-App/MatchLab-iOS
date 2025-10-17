//
//  TypeSelectCarousel.swift
//  MatchLab
//
//  Created by 나현흠 on 10/18/25.
//

import SwiftUI

extension PokemonType {
    var bigImageName: String {
        switch self {
        case .normal: return "normal_big"
        case .bug: return "bug_big"
        case .fairy: return "fairy_big"
        case .grass: return "grass_big"
        case .rock: return "rock_big"
        case .fighting: return "fighting_big"
        case .ghost: return "ghost_big"
        case .psychic: return "psychic_big"
        case .fire: return "fire_big"
        case .water: return "water_big"
        case .ice: return "ice_big"
        case .flying: return "flying_big"
        case .dark: return "dark_big"
        case .steel: return "steel_big"
        case .dragon: return "dragon_big"
        case .noType: return "noType_big"
        case .ground: return "ground_big"
        case .poison: return "poison_big"
        case .electric: return "electronic_big"
        }
    }
}

/// Single round gradient badge displaying a big type icon.
struct TypeBadge: View {
    let type: PokemonType
    let isSelected: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? Color.white.opacity(0.9) : Color.clear, lineWidth: 3)
                .shadow(color: isSelected ? Color.white : Color.clear, radius: 8)
            Image(type.bigImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
        .frame(width: 72)
    }
}

// MARK: - Preference to track each cell's X position in a named coordinate space
private struct ItemXPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int : CGFloat], nextValue: () -> [Int : CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

/// Infinite horizontal carousel that seamlessly loops by recentering when you get near either edge.
struct TypeSelectCarousel: View {
    @Binding var selectedType1: PokemonType
    @Binding var selectedType2: PokemonType

    private let base: [PokemonType] = [.normal,.bug,.fairy,.grass,.rock,.fighting,.ghost,.psychic,.fire,.water,.ice,.flying,.dark,.steel,.dragon]

    // Repeat data 3x so we can re-center to the middle copy.
    private var looped: [PokemonType] { base + base + base }
    private var middleStart: Int { base.count } // first index of the middle copy

    @State private var currentIndex: Int = 0

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                let rows = [GridItem(.fixed(72)), GridItem(.fixed(72)), GridItem(.fixed(72))]
                HStack(alignment: .top, spacing: 0) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(Array(looped.indices), id: \.self) { idx in
                            let type = looped[idx]
                            let rowIndex = idx % 3 // 0: top, 1: middle, 2: bottom

                            TypeBadge(type: type, isSelected: type == selectedType1 || type == selectedType2)
                                .onTapGesture {
                                    if selectedType1 == .noType {
                                        selectedType1 = type
                                    } else if selectedType2 == .noType {
                                        selectedType2 = type
                                    } else {
                                        selectedType1 = type
                                        selectedType2 = .noType
                                    }
                                }
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.preference(key: ItemXPreferenceKey.self, value: [idx: geo.frame(in: .named("carousel")).minX])
                                    }
                                )
                                .id(idx)
                                .offset(x: rowIndex == 1 ? 36 : 0) // middle row shifted right
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .coordinateSpace(name: "carousel")
            .onAppear {
                // Jump to the start of the middle copy so user can scroll both ways immediately
                currentIndex = middleStart
                proxy.scrollTo(middleStart, anchor: .center)
            }
            .onPreferenceChange(ItemXPreferenceKey.self) { map in
                guard !map.isEmpty else { return }

                // Find the item closest to the horizontal center of the ScrollView
                let centerX: CGFloat = 0
                let screenHalf = UIScreen.main.bounds.width / 2
                let nearest = map.min(by: { lhs, rhs in
                    abs((lhs.value + 44) - screenHalf) < abs((rhs.value + 44) - screenHalf)
                })?.key

                if let nearest = nearest {
                    currentIndex = nearest
                }
            }
            .onChange(of: currentIndex) { _, newValue in
                // When we approach edges, recenter to the equivalent index in the middle copy to create an infinite effect.
                let n = base.count
                let total = looped.count
                let leftEdge = n / 2
                let rightEdge = total - n / 2 - 1

                if newValue <= leftEdge {
                    let target = newValue + n
                    withoutAnimation { proxy.scrollTo(target, anchor: .center) }
                    currentIndex = target
                } else if newValue >= rightEdge {
                    let target = newValue - n
                    withoutAnimation { proxy.scrollTo(target, anchor: .center) }
                    currentIndex = target
                }
            }
        }
    }

    /// Helper to perform non-animated jumps so the user doesn't notice recentering.
    private func withoutAnimation(_ updates: () -> Void) {
        let transaction = Transaction(animation: nil)
        withTransaction(transaction) {
            updates()
        }
    }
}

#Preview {
    @State var type1: PokemonType = .noType
    @State var type2: PokemonType = .noType
    TypeSelectCarousel(selectedType1: $type1, selectedType2: $type2)
}
