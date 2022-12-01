//
//  Pokemon.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import UIKit

struct Pokemon: Codable{
    let name: String
    let type: String
    let description: String
    let imageUrl: String
    let id: Int
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    
    var backgroundColor: UIColor{
        switch type{
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "poison": return .systemGreen
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemGray
        case "ground": return .systemOrange
        case "flying": return .systemTeal
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
}


