//
//  SceneConfig.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct SceneConfig {
    static func getScreenSize() -> CGSize {
        let scene = UIScreen.main.bounds
        return CGSize(
            width: scene.width,
            height: scene.height
        )
    }
    
    static func adjustToScreen(_ size: CGSize) -> CGSize {
        let screenSize = getScreenSize()
        let aspectRatio = screenSize.width / screenSize.height
        let newWidth = size.width * aspectRatio
        let newHeight = size.height * aspectRatio
        
        return CGSize(width: newWidth, height: newHeight)
    }
}
