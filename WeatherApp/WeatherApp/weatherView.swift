//
//  LottieAnim.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-05-02.
//

import SwiftUI
import SpriteKit

struct WeatherView: View {
    var emitterFile: String
    
    var body: some View {
        SpriteView(scene: {
            let scene = WeatherScene()
            scene.emitterFile = emitterFile 
            scene.scaleMode = .resizeFill
            scene.backgroundColor = .rainBackGround
            return scene
        }(), options: [.allowsTransparency])
        .ignoresSafeArea()
    }
}



#Preview {
    WeatherView(emitterFile: "Smoke.sks")
}
