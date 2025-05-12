//
//  LottieAnim.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-05-02.
//

import SwiftUI
import SpriteKit

struct BackGroundView: View {
    var emitterFile: String
    var backgroundView: UIColor?
    
    var body: some View {
        SpriteView(scene: {
            let scene = WeatherScene()
            scene.emitterFile = emitterFile 
            scene.scaleMode = .resizeFill
            scene.backgroundColor = backgroundView ?? .backGround1
            return scene
        }(), options: [.allowsTransparency])
        .ignoresSafeArea()
    }
}



#Preview {
    BackGroundView(emitterFile: "Sun.sks")
}
