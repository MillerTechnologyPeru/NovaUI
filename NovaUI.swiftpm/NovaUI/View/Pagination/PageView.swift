//
//  PageView.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

import Foundation
import SwiftUI

/// SwiftUI Page View
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
public struct PageView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    
    @Binding var selection: SelectionValue
    let indexDisplayMode: PageTabViewStyle.IndexDisplayMode
    let indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode
    let content: () -> Content
    
    public init(
        selection: Binding<SelectionValue>,
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }
    
    public var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: indexBackgroundDisplayMode))
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
public extension PageView where SelectionValue == Int {
    
    init(
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = .constant(0)
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }
}

// MARK: - Preview

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
struct PageViewPreview: View {
    
    @State var selection = 0

    var body: some View {
        VStack {
            Text("Selection: \(selection + 1)")
            PageView(selection: $selection, indexBackgroundDisplayMode: .always) {
                ForEach(0 ..< 3, id: \.self) {
                    Text("Page \($0 + 1)")
                        .tag($0)
                }
            }
        }
    }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
#Preview {
    NavigationView {
        PageViewPreview()
    }
}
