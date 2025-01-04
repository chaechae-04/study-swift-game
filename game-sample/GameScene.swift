//
//  GameScene.swift
//  game-sample
//
//  Created by 이영수 on 1/4/25.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var player: SKSpriteNode!
    private var ground: SKSpriteNode!
    private var walls: [CGRect]!
    private var leftButton: SKSpriteNode!
    private var rightButton: SKSpriteNode!
    private var jumpButton: SKSpriteNode!
    private var dashButton: SKSpriteNode!
    
    private var touchStartButton: SKNode?
    
    private var isMovingLeft: Bool = false
    private var isMovingRight: Bool = false
    private var isJumping: Bool = false
    private var isDashing: Bool = false
    
    private var lastDirection: String = "right"
    
    private var moveForce: CGFloat = 200
    private var jumpForce: CGFloat = 500
    private var dashForce: CGFloat = 350
    
    private var dashDuration: Double = 0.2
    
    private var canDash: Bool = true
    private var dashCoolTime: Double = 0.5
    private var isGrounded: Bool = true
    
    // 충돌 카테고리
    let playerCategory: UInt32 = 0x1 << 0
    let groundCategory: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        setupGame()
        
    }
    
    /* SET UP */
    
    func setupGame() {
        setupPlayer()
        setupButton()
        setupGround()
        setupWall()
        setupCollision()
    }
    
    func setupPlayer() {
        player = SKSpriteNode(
            color: .red,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        player.position = CGPoint(x: frame.midX, y: frame.midY)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.mass = 0.5
        player.physicsBody?.linearDamping = 0.5
        player.physicsBody?.restitution = 0
        player.physicsBody?.categoryBitMask = playerCategory
        addChild(player)
    }
    
    func setupButton() {
        leftButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        leftButton.position = CGPoint(x: 50, y: 100)
        leftButton.name = "leftButton"
        leftButton.alpha = 0.7
        addChild(leftButton)
        
        rightButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        rightButton.position = CGPoint(x: 120, y: 100)
        rightButton.name = "rightButton"
        rightButton.alpha = 0.7
        addChild(rightButton)
        
        dashButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        dashButton.position = CGPoint(x: frame.width - 70, y: 100)
        dashButton.name = "dashButton"
        dashButton.alpha = 0.7
        addChild(dashButton)
        
        jumpButton = SKSpriteNode(
            color: .gray,
            size: CGSize(
                width: 50,
                height: 50
            )
        )
        jumpButton.position = CGPoint(x: frame.width - 130, y: 100)
        jumpButton.name = "jumpButton"
        jumpButton.alpha = 0.7
        addChild(jumpButton)
    }
    
    func setupGround() {
        ground = SKSpriteNode(
            color: .green,
            size: CGSize(
                width: frame.width,
                height: 20
            )
        )
        ground.position = CGPoint(x: frame.midX, y: 20)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        addChild(ground)
    }
    
    func setupWall() {
        walls = [
            // left wall
            CGRect(
                x: 0,
                y: 0,
                width: 1,
                height: frame.height
            ),
            // right wall
            CGRect(
                x: frame.width - 1,
                y: 0,
                width: 1,
                height: frame.height
            )
        ]
        for wall in walls {
            let barrier = SKSpriteNode(
                color: .clear,
                size: wall.size
            )
            barrier.position = CGPoint(
                x: wall.minX,
                y: wall.midY
            )
            barrier.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
            barrier.physicsBody?.isDynamic = false
            barrier.alpha = 0
            addChild(barrier)
        }
    }
    
    func setupCollision() {
        player.physicsBody?.contactTestBitMask = groundCategory
    }
    
    /* ACTION */
    
    func performJume() {
        if !isJumping {
            isJumping = true
            player.physicsBody?.applyImpulse(CGVector(
                dx: 0,
                dy: jumpForce
            )
            )
        }
    }
    
    func performDash() {
        guard canDash && !isDashing else { return }
        
        isDashing = true
        canDash = false
        
        let dashDirection: CGFloat = lastDirection == "right" ? 1 : -1
        let initialDasdhForce: CGFloat = dashForce * 0.9
        let finalDashForce: CGFloat = dashForce * 0.1
        
        let isAirborne = !isGrounded
        
        if !isAirborne {
            player.physicsBody?.velocity = .zero
        }
        
        player.physicsBody?.applyImpulse(
            CGVector(
                dx: initialDasdhForce * dashDirection,
                dy: 0
            )
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (dashDuration * 0.9)) {
            self.player.physicsBody?.applyImpulse(
                CGVector(
                    dx: finalDashForce * dashDirection,
                    dy: 0
                )
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.dashDuration * 0.1)) {
                self.isDashing = false
                
                if !isAirborne {
                    self.player.physicsBody?.velocity.dx = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.dashCoolTime) {
                    self.canDash = true
                }
            }
        }
    }
    
    func checkGrounded() {
        let rayLength: CGFloat = 2.0
        
        guard player.physicsBody != nil else { return }
        
        
        let rayStart = CGPoint(
            x: player.position.x,
            y: player.position.y - player.size.height / 2
        )
        let rayEnd = CGPoint(
            x: rayStart.x,
            y: rayStart.y - rayLength
        )
        
        scene?.physicsWorld.enumerateBodies(alongRayStart: rayStart, end: rayEnd) { body, point, normal, stop in
            if body.node?.name == "ground" {
                self.isGrounded = true
                stop.pointee = true
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        guard !isDashing else { return }
        
        let wasGrounded = isGrounded
        isGrounded = false
        
        checkGrounded()
        
        // 상태가 바뀔 때만 처리
        if wasGrounded != isGrounded {
            if isGrounded {
                // 착지 시 실행
            }
        }
        
        if isMovingLeft {
            player.physicsBody?.velocity = CGVector(
                dx: -moveForce,
                dy: player.physicsBody?.velocity.dy ?? 0
            )
        } else if isMovingRight {
            player.physicsBody?.velocity = CGVector(
                dx: moveForce,
                dy: player.physicsBody?.velocity.dy ?? 0
            )
        } else {
            player.physicsBody?.velocity = CGVector(
                dx: 0,
                dy: player.physicsBody?.velocity.dy ?? 0
            )
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let node = nodes(at: location).first {
                
                touchStartButton = node
                
                switch node.name {
                    
                case "leftButton":
                    isMovingLeft = true
                    lastDirection = "left"
                    
                case "rightButton":
                    isMovingRight = true
                    lastDirection = "right"
                    
                case "jumpButton":
                    performJume()
                    
                case "dashButton":
                    performDash()
                    
                default:
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            let node = nodes(at: location).first
            
            if node?.name == "leftButton" {
                isMovingLeft = false
            } else if node?.name == "rightButton" {
                isMovingRight = false
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if let startButton = touchStartButton {
                if !startButton.contains(location) {
                    switch startButton.name {
                    case "leftButton":
                        isMovingLeft = false
                    case "rightButton":
                        isMovingRight = false
                    default:
                        break
                    }
                }
            }
            
            if let node = nodes(at: location).first {
                if node.name == "leftButton" {
                    isMovingLeft = true
                    isMovingRight = false
                } else if node.name == "rightButton" {
                    isMovingLeft = false
                    isMovingRight = true
                }
            }
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == groundCategory ||
            contact.bodyB.categoryBitMask == groundCategory {
            isJumping = false
        }
    }
}
