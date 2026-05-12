//
//  Config.swift
//  MatchLab
//
//  Created by 나현흠 on 7/21/25.
//

import Foundation

enum L10n {
    static let nameType = String(localized: "search.placeholder")

    static let opponentType = String(localized: "opponent.type.title")
    static let opponentTypeDescription = String(localized: "opponent.type.description")
    static let oppopentTypeSelect = String(localized: "opponent.first.prompt")
    static let opponentTypeSelect2 = String(localized: "opponent.second.prompt")

    static let goNext = String(localized: "action.next")
    static let goFirst = String(localized: "action.restart")

    static let attackType = String(localized: "attack.type.title")
    static let attackTypeDescription = String(localized: "attack.type.description")
    static let attacktypeSelect = String(localized: "attack.type.prompt")

    static let attack = String(localized: "role.attack")
    static let defense = String(localized: "role.defense")

    static let noEffectiveness = String(localized: "effectiveness.none.title")
    static let noEffectivenessDescription = String(localized: "effectiveness.none.description")

    static let superWeakEffectiveness = String(localized: "effectiveness.quarter.title")
    static let weakEffectiveness = String(localized: "effectiveness.half.title")
    static let weakEffectivenessDescription = String(localized: "effectiveness.weak.description")

    static let normalEffectiveness = String(localized: "effectiveness.normal.title")
    static let normalEffectivenessDescription = String(localized: "effectiveness.normal.description")

    static let strongEffectiveness = String(localized: "effectiveness.double.title")
    static let superStrongEffectiveness = String(localized: "effectiveness.quad.title")
    static let strongEffectivenessDescription = String(localized: "effectiveness.strong.description")

    static let currentRecords = String(localized: "menu.recent")
    static let viewTypeChard = String(localized: "menu.type.chart")
    static let setting = String(localized: "menu.settings")

    static let languageSetting = String(localized: "settings.language")
    static let english = String(localized: "language.english")
    static let korean = String(localized: "language.korean")
    static let japanese = String(localized: "language.japanese")
    static let fileAccessPermission = String(localized: "settings.file.access")

    static let appServiceTitle = String(localized: "notice.title")
    static let appServiceDescription = String(localized: "notice.body.first")
    static let appServiceDescription2 = String(localized: "notice.body.second")
    static let appServiceDescription3 = String(localized: "notice.body.third")

    static let readFullNotice = String(localized: "settings.read.full.notice")

    static let contact = String(localized: "settings.contact")
    static let contactMail = String(localized: "settings.contact.email")

    static let confirmed = String(localized: "action.confirmed")

    static let welcome = String(localized: "start.welcome")
    static let touchTheScreen = String(localized: "start.touch.screen")
    static let version = String(localized: "start.version")
    static let startDisclaimer = String(localized: "start.disclaimer")
}

let nameType: String = L10n.nameType

let opponentType: String = L10n.opponentType
let opponentTypeDescription: String = L10n.opponentTypeDescription
let oppopentTypeSelect: String = L10n.oppopentTypeSelect
let opponentTypeSelect2: String = L10n.opponentTypeSelect2

let goNext: String = L10n.goNext
let goFirst: String = L10n.goFirst

let attackType: String = L10n.attackType
let attackTypeDescription: String = L10n.attackTypeDescription
let attacktypeSelect: String = L10n.attacktypeSelect

let attack: String = L10n.attack
let defense: String = L10n.defense

let noEffectiveness: String = L10n.noEffectiveness
let noEffectivenessDescription: String = L10n.noEffectivenessDescription

let superWeakEffectiveness: String = L10n.superWeakEffectiveness
let weakEffectiveness: String = L10n.weakEffectiveness
let weakEffectivenessDescription: String = L10n.weakEffectivenessDescription

let normalEffectiveness: String = L10n.normalEffectiveness
let normalEffectivenessDescription: String = L10n.normalEffectivenessDescription

let strongEffectiveness: String = L10n.strongEffectiveness
let superStrongEffectiveness: String = L10n.superStrongEffectiveness
let strongEffectivenessDescription: String = L10n.strongEffectivenessDescription

let currentRecords: String = L10n.currentRecords
let viewTypeChard: String = L10n.viewTypeChard
let setting: String = L10n.setting

let languageSetting: String = L10n.languageSetting
let english: String = L10n.english
let korean: String = L10n.korean
let japanese: String = L10n.japanese
let fileAccessPermission: String = L10n.fileAccessPermission

let appServiceTitle: String = L10n.appServiceTitle
let appServiceDescription: String = L10n.appServiceDescription
let appServiceDescription2: String = L10n.appServiceDescription2
let appServiceDescription3: String = L10n.appServiceDescription3

let readFullNotice: String = L10n.readFullNotice

let contact: String = L10n.contact
let contactMail: String = L10n.contactMail

let confirmed: String = L10n.confirmed

let welcome: String = L10n.welcome
let touchTheScreen: String = L10n.touchTheScreen

enum PokemonType: String, CaseIterable, Codable, Identifiable {
    case grass, fire, fighting, flying, fairy, ground, ice, bug, rock, poison
    case water, dragon, electric, ghost, normal, psychic, steel, dark, noType

    var id: String { rawValue }

    static let selectable: [PokemonType] = [
        .normal, .bug, .fairy, .grass, .rock, .fighting,
        .ghost, .psychic, .fire, .water, .ice, .flying,
        .dark, .steel, .dragon, .ground, .poison, .electric
    ]

    var label: String {
        switch self {
        case .grass: return String(localized: "pokemon.type.grass")
        case .fire: return String(localized: "pokemon.type.fire")
        case .fighting: return String(localized: "pokemon.type.fighting")
        case .flying: return String(localized: "pokemon.type.flying")
        case .fairy: return String(localized: "pokemon.type.fairy")
        case .ground: return String(localized: "pokemon.type.ground")
        case .ice: return String(localized: "pokemon.type.ice")
        case .bug: return String(localized: "pokemon.type.bug")
        case .rock: return String(localized: "pokemon.type.rock")
        case .poison: return String(localized: "pokemon.type.poison")
        case .water: return String(localized: "pokemon.type.water")
        case .dragon: return String(localized: "pokemon.type.dragon")
        case .electric: return String(localized: "pokemon.type.electric")
        case .ghost: return String(localized: "pokemon.type.ghost")
        case .normal: return String(localized: "pokemon.type.normal")
        case .psychic: return String(localized: "pokemon.type.psychic")
        case .steel: return String(localized: "pokemon.type.steel")
        case .dark: return String(localized: "pokemon.type.dark")
        case .noType: return String(localized: "pokemon.type.none")
        }
    }

    var smallImageName: String {
        switch self {
        case .electric: return "electronic_small"
        case .noType: return "noType_small"
        default: return "\(rawValue)_small"
        }
    }

    var bigImageName: String {
        switch self {
        case .electric: return "electronic_big"
        case .noType: return "noType_big"
        default: return "\(rawValue)_big"
        }
    }
}
