//
//  Rain.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-05-02.
//

import SpriteKit

    class WeatherScene: SKScene {
        var emitterFile: String = "Rain.sks"
        
        override func didMove(to view: SKView) {
            setupEmitter()
        }
        
        private func setupEmitter() {
            removeAllChildren()
            
            guard let emitter = SKEmitterNode(fileNamed: emitterFile) else {
                return
            }
            
            emitter.position = CGPoint(x: size.width/2, y: size.height)
            emitter.particlePositionRange = CGVector(dx: size.width, dy: size.width)
            addChild(emitter)
        }
        
        override func didChangeSize(_ oldSize: CGSize) {
            setupEmitter()
        }
    }
    
    
    
