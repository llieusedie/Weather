//
//  OSBackground.swift
//  Clima
//
//  Created by Paul Kirnoz on 26.06.2022.
//

import SwiftUI

struct OSBackground: View {
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                Image("try")
                    .resizable()
                    .opacity(0.8)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                Image("OSTexture")
                    .resizable()
                    .opacity(0.9)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OSBackground_Previews: PreviewProvider {
    static var previews: some View {
        OSBackground()
    }
}
