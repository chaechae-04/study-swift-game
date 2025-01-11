//
//  ButtonLayout.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct MenuButtonConfig {
    static var size: CGSize {
        // 200 -> 50
        // 60  -> 15
        // 1/4
        let baseWidth: CGFloat = 50
        let baseHeight: CGFloat = 15
        let ratio = GameSettings.Screen.scaleRatio
        return CGSize(
            width: baseWidth * ratio, 
            height: baseHeight * ratio
        )
    }
    
    static var spacing: CGFloat {
        return 25 * GameSettings.Screen.scaleRatio
    }
    
    struct Position {
        static var titleY: CGFloat {
            return -25 * GameSettings.Screen.scaleRatio
        }
        
        static var firstButtonY: CGFloat {
            return 25 * GameSettings.Screen.scaleRatio
        }
    }
    
    struct Style {
        static var fontSize: CGFloat {
            return 5 * GameSettings.Screen.scaleRatio
        }
        static let fillColor: SKColor = .gray
        static let strokeColor: SKColor = .white
    }
    
    struct Text {
        static let title = "Sample Game"
        static let stages = ["Stage 1", "Stage 2", "Stage 3"]
    }
}

/* 아직 고쳐야 함 */
struct SystemButtonConfig {
    struct Pause {
        static var size: CGSize {
            let baseWidth: CGFloat = 40
            let baseHeight: CGFloat = 40
            return CGSize(
                width: baseWidth * GameSettings.Screen.scaleRatio,
                height: baseHeight * GameSettings.Screen.scaleRatio
            )
        }
        static var padding: CGFloat {
            return 20 * GameSettings.Screen.scaleRatio
        }
        static let text: String = "||"
    }
}
