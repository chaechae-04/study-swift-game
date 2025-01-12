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
                width: GameSettings.Screen.width,
                height: GameSettings.Screen.height
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
                width: GameSettings.Screen.width,
                height: GameSettings.Ground.height * GameSettings.Screen.scaleRatio
            )
        }
    }
    
    struct Position {
        static func ground() -> CGPoint {
            return CGPoint(
                x: GameSettings.Screen.width / 2,
                y: GameSettings.Ground.height * GameSettings.Screen.scaleRatio
            )
        }
        
        static func player() -> CGPoint {
            return CGPoint(
                x: GameStageConfig.Size.ground.width * 0.1,
                y: GameSettings.Screen.height / 2
            )
        }
        
        static func enemy() -> CGPoint {
            return CGPoint(
                x: GameStageConfig.Size.ground.width * 0.9,
                y: GameSettings.Screen.height / 2
            )
        }
    }
}
