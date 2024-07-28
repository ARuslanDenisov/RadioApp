//
//  ImageExtension.swift
//  RadioApp
//
//  Created by Руслан on 28.07.2024.
//

import SwiftUI

extension Image {
    func resizableToFit() -> some View {
        resizable()
            .scaledToFit()
    }

    func resizableToFill() -> some View {
        resizable()
            .scaledToFill()
    }
}

