//
//  Config.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import Foundation

let nameType: String = "이름으로 타입 검색"

let opponentType: String = "상대 타입"
let opponentTypeDescription: String = "1~2개를 선택하세요"
let oppopentTypeSelect: String = "상대의 첫 번째 타입을 고르세요"
let opponentTypeSelect2: String = "두 번째 타입을 고르거나 다음으로 버튼을 눌러 \n 상대 타입 선택을 종료하세요"

let goNext: String = "다음으로"
let goFirst: String = "처음으로"

let attackType: String = "시전 기술 타입"
let attackTypeDescription: String = "1개를 선택하세요"
let attacktypeSelect: String = "아래의 타입 아이콘에서 \n 시전 기술의 타입을 고르세요"

let attack: String = "공격"
let defense: String = "수비"

let noEffectiveness: String = "0배 데미지"
let noEffectivenessDescription: String = "효과가 없다"

let superWeakEffectiveness: String = "0.25배 데미지"
let weakEffectiveness: String = "0.5배 데미지"
let weakEffectivenessDescription: String = "효과가 별로다"

let normalEffectiveness: String = "1배 데미지"
let normalEffectivenessDescription: String = "중립 상성"

let strongEffectiveness: String = "2배 데미지"
let superStrongEffectiveness: String = "4배 데미지"
let strongEffectivenessDescription: String = "효과가 굉장하다!"

let currentRecords: String = "최근 기록"
let viewTypeChard: String = "상성표 보기 (6세대 이후)"
let setting: String = "설정"

let languageSetting: String = "언어 설정"
let english: String = "영어"
let korean: String = "한국어"
let japanese: String = "일본어"
let fileAccessPermission: String = "파일 접근 허용"

let appServiceTitle: String = "이 앱은 공식 서비스가 아닙니다"
let appServiceDescription: String = "본 애플리케이션은 Nintendo, Game Freak, Creatures Inc., 또는 The Pokémon Company와  어떠한 공식적 제휴, 승인, 보증 관계도 없습니다. "
let appServiceDescription2: String = "Pokémon 및 그 관련 캐릭터의 저작권은 해당 소유자에게 귀속됩니다. 본 앱은 팬 프로젝트로서 순수한 비상업적 목적 하에 개발되었습니다."
let appServiceDescription3: String = "이 앱에 사용된 모든 리소스(아이콘, 데이터, 그래픽 등)는 The Pokémon Company의 공식 자료를 사용하지 않고, 독자적으로 재구성 및 제작된 비공식 리소스입니다. 자유로운 공유 및 사용이 가능합니다."

let readFullNotice: String = "안내문 전문 읽기"

let contact: String = "문의하기"
let contactMail: String = "nakisara01@icloud.com"

let confirmed: String = "확인했습니다"

let welcome: String = "환영합니다!"
let touchTheScreen: String = "화면을 터치하세요"

enum PokemonType: String, CaseIterable, Codable {
    case grass, fire, fighting, flying, fairy, ground, ice, bug, rock, poison
    case water, dragon, electric, ghost, normal, psychic, steel, dark, noType

    var label: String {
        switch self {
        case .grass: return "풀"
        case .fire: return "불"
        case .fighting: return "격투"
        case .flying: return "비행"
        case .fairy: return "페어리"
        case .ground: return "땅"
        case .ice: return "얼음"
        case .bug: return "벌레"
        case .rock: return "바위"
        case .poison: return "독"
        case .water: return "물"
        case .dragon: return "드래곤"
        case .electric: return "전기"
        case .ghost: return "고스트"
        case .normal: return "노말"
        case .psychic: return "에스퍼"
        case .steel: return "강철"
        case .dark: return "악"
        case .noType: return "미선택"
        }
    }
}
