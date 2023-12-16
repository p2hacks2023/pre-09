//
//  AnimationPlus.swift
//  FanReacter
//
//  Created by 古賀耀 on 2023/12/12.
//

import struct SwiftUI.Animation

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
