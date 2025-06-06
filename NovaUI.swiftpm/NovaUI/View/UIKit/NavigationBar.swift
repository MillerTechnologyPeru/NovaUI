//
//  NavigationBar.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(UIKit)
import Foundation
import UIKit
import SwiftUI

public struct NavigationBar: UIViewRepresentable {
    
    let barStyle: UIBarStyle
    
    let isTranslucent: Bool
    
    let prefersLargeTitles: Bool
    
    let items: [UINavigationItem]
    
    public init(
        barStyle: UIBarStyle = .default,
        isTranslucent: Bool,
        prefersLargeTitles: Bool = false,
        items: [UINavigationItem] = []
    ) {
        self.barStyle = barStyle
        self.isTranslucent = isTranslucent
        self.prefersLargeTitles = prefersLargeTitles
        self.items = items
    }
    
    public func makeUIView(context: Context) -> UINavigationBar {
        let view = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        configureView(view)
        return view
    }
    
    public func updateUIView(_ view: UINavigationBar, context: Context) {
        configureView(view)
    }
    
    private func configureView(_ view: UINavigationBar) {
        view.barStyle = self.barStyle
        view.isTranslucent = self.isTranslucent
        view.prefersLargeTitles = self.prefersLargeTitles
        view.items = self.items
    }
}

#endif
