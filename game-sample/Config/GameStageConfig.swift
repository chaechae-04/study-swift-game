//
//  GameStageConfig.swift
//  game-sample
//
//  Created by 이영수 on 1/9/25.
//

import SpriteKit

struct GameStageConfig {
    struct Size {
        static var field: CGSize {
            return CGSize(
                width: GameSettings.Screen.width * GameSettings.Screen.scaleRatio,
                height: GameSettings.Screen.height * GameSettings.Screen.scaleRatio
            )
        }
        
        static var character: CGSize {
            return CGSize(
                width: GameSettings.Character.width * GameSettings.Screen.scaleRatio,
                height: GameSettings.Character.height * GameSettings.Screen.scaleRatio
            )
        }
        
        static var entity: CGSize {
            return CGSize(
                width: GameSettings.Entity.width * GameSettings.Screen.scaleRatio,
                height: GameSettings.Entity.height * GameSettings.Screen.scaleRatio
            )
        }
        
        static var ground: CGSize {
            return CGSize(
                width: GameSettings.Screen.width * GameSettings.Screen.scaleRatio,
                height: GameSettings.Ground.height * GameSettings.Screen.scaleRatio
            )
        }
    }
    
    struct Position {
        static func ground() -> CGPoint {
            return CGPoint(
                x: GameSettings.Screen.width * GameSettings.Screen.scaleRatio / 2,
                y: 20 * GameSettings.Screen.scaleRatio
            )
        }
        
        static func player() -> CGPoint {
            return CGPoint(
                x: 100 * GameSettings.Screen.scaleRatio,
                y: (GameSettings.Screen.height / 2) * GameSettings.Screen.scaleRatio
            )
        }
        
        static func enemy() -> CGPoint {
            return CGPoint(
                x: (GameSettings.Screen.width - 100) * GameSettings.Screen.scaleRatio,
                y: (GameSettings.Screen.height / 2) * GameSettings.Screen.scaleRatio
            )
        }
    }
}
