//
//  ButtonLayout.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct MenuButtonConfig {
    static let size: CGSize = CGSize(width: 200, height: 60)
    static let spacing: CGFloat = 100
    
    struct Position {
        static let titleY: CGFloat = -100       // from top
        static let firstButtonY: CGFloat = 100  // from middle
    }
    
    struct Style {
        static let fillColor: SKColor = .gray
        static let strokeColor: SKColor = .white
        static let fontSize: CGFloat = 20
    }
    
    struct Text {
        static let title = "Sample Game"
        static let stages = ["Stage 1", "Stage 2", "Stage 3"]
    }
}

/* 아직 고쳐야 함 */
struct SystemButtonConfig {
    struct Pause {
        static let size: CGSize = CGSize(width: 40, height: 40)
        static let padding: CGFloat = 20
        static let text: String = "||"
    }
}
