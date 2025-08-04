//
//  View+Extensions.swift
//  tic-tac-toe
//
//  Created by Lauren Ducay on 8/1/25.
//

import Foundation
import SwiftUI

extension View {
    func navigationStyle(title: String, trailingText: String?, trailingAction: @escaping (() -> Void)) -> some View {
        if let trailingText {
            return AnyView(self
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline))
        }
        
        return AnyView(self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline))
    }
}
