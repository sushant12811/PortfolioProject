//
//  LottieAnim.swift
//  WeatherApp
//
//  Created by Sushant Dhakal on 2025-05-02.
//

import SwiftUI
import Lottie

struct LottieAnim: View {
    var body: some View {
        VStack{
            LottieView(animation: .named("drizzle.json"))
                .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
        }

        .frame(maxWidth: .infinity, minHeight: .infinity)
        .background(.blue)

            
        
    }
        
}

#Preview {
    LottieAnim()
}
