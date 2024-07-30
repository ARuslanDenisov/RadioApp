//
//  Shapes.swift
//  RadioApp
//
//  Created by Руслан on 30.07.2024.
//

import Foundation
import SwiftUI

struct TriangleShape: Shape {
    let width = CGFloat(40)
    let heightA = CGFloat(40)
        
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            let point1 = CGPoint(x: -20, y: 20)
                let point2 = CGPoint(x: -20, y: -20)
                let point3 = CGPoint(x: 20, y: 0)
            path.move(to: CGPoint(x: -2, y: 11))
            path.addArc(tangent1End: point1, tangent2End: point2, radius: 8)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: 8)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: 8)
            path.closeSubpath()
            
        }
    }
}


