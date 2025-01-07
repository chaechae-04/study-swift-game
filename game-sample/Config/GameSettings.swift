//
//  GameSettings.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct GameSettings {
    
    struct Screen {
        static let width: CGFloat = 1024
        static let height: CGFloat = 768
        static let fps: Int = 60
    }
    
    struct Difficulty {
        static let easy: Float = 1.0
        static let normal: Float = 1.5
        static let hard: Float = 2.0
    }
    
    struct System {
        static let gravity: CGFloat = -9.8
        static let devbugMode: Bool = false
    }
    
}
