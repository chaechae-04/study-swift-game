//
//  GameScene.swift
//  game-sample
//
//  Created by 이영수 on 1/4/25.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        // Menu Scene Start
        let menuScene = SceneManager.loadScene(.menu, size: self.size)
        view.presentScene(menuScene)
    }
}
