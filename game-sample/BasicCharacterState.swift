//
//  BasicCharacterState.swift
//  game-sample
//
//  Created by 이영수 on 1/7/25.
//

import SpriteKit

struct BasicCharacterState {
    static let stats = CharacterState(
        hp: 10,
        mp: 100,
        attackDamage: 5,
        attackSpeed: 1.0,
        attackRange: 50,
        moveSpeed: 200,
        jumpForce: 300,
        backStepForce: 350,
        backDashCoolTime: 2.0
    )
}
