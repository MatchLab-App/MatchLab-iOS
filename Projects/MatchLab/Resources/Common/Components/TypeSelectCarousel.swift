//
//  TypeSelectCarousel.swift
//  MatchLab
//
//  Created by 나현흠 on 10/18/25.
//

import SwiftUI

/// Single round gradient badge displaying a big type icon.
struct TypeBadge: View {
    let type: PokemonType
    let isSelected: Bool
    private let size: CGFloat = 73

    var body: some View {
        ZStack {
            Image(type.bigImageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)

            Circle()
                .stroke(isSelected ? Color.white.opacity(0.9) : Color.clear, lineWidth: 3)
                .shadow(color: isSelected ? Color.white : Color.clear, radius: 8)
                .frame(width: size, height: size)
        }
        .frame(width: size, height: size)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(type.label)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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
    var selectedAttackType: PokemonType = .noType
    var onSelect: ((PokemonType) -> Void)?

    private let base: [PokemonType] = PokemonType.selectable

    // Repeat data 3x so we can re-center to the middle copy.
    private var looped: [PokemonType] { base + base + base }
    private var middleStart: Int { base.count } // first index of the middle copy

    @State private var currentIndex: Int = 0

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                let rows = [GridItem(.fixed(73)), GridItem(.fixed(73)), GridItem(.fixed(73))]
                HStack(alignment: .top, spacing: 0) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(Array(looped.indices), id: \.self) { idx in
                            let type = looped[idx]
                            let rowIndex = idx % 3 // 0: top, 1: middle, 2: bottom

                            Button {
                                if let onSelect {
                                    onSelect(type)
                                } else {
                                    if selectedType1 == .noType {
                                        selectedType1 = type
                                    } else if selectedType2 == .noType {
                                        selectedType2 = type
                                    } else {
                                        selectedType1 = type
                                        selectedType2 = .noType
                                    }
                                }
                            } label: {
                                TypeBadge(
                                    type: type,
                                    isSelected: type == selectedType1
                                    || type == selectedType2
                                    || type == selectedAttackType
                                )
                            }
                            .buttonStyle(.plain)
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
