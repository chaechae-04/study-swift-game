//
//  SceneManager.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

enum SceneType {
    case menu
    case stage(number: Int)
}

class SceneManager {
    static func loadScene(_ type: SceneType, size: CGSize) -> SKScene {
        switch type {
        case .menu:
            return MenuScene(size: size)
        case .stage(let number):
            return StageScene(size: size, stageNumber: number)
        }
    }
}
