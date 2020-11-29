//
//  CardModifier.swift
//  barky
//
//  Created by Derrick Lee on 11/12/20.
//

import Foundation
import SwiftUI
import UIKit

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
    }
}
