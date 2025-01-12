//
//  GameSettings.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct GameSettings {
    
    struct Screen {
        /* iPhone 15 Pro : 2556 * 1179 */
        /* FHD : 1920 * 1080 */
        static let width: CGFloat = 2556
        static let height: CGFloat = 1179
        static let fps: Int = 60
        
        static var scaleRatio: CGFloat {
            let currentSize = UIScreen.main.bounds.size
            return max(width / currentSize.width, height / currentSize.height)
        }
    }
    
    struct Character {
        static let width: CGFloat = 5
        static let height: CGFloat = 7.5
    }
    
    struct Entity {
        static let width: CGFloat = 5
        static let height: CGFloat = 5
    }
    
    struct Ground {
        static let height: CGFloat = 5
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
