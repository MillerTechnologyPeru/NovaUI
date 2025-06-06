//
//  WebView.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(WebKit)
import Foundation
import WebKit
import SwiftUI

/// SwiftUI Web View
public struct WebView {
    
    let request: URLRequest
    
    public init(request: URLRequest) {
        self.request = request
    }
    
    public init(url: URL) {
        let request = URLRequest(url: url)
        self.init(request: request)
    }
}

#if canImport(UIKit)
import UIKit

extension WebView: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(request)
    }
}

#elseif canImport(AppKit)
import AppKit

#endif

#Preview {
    WebView(url: URL(string: "https://google.com")!)
        .edgesIgnoringSafeArea(.all)
}
#endif
