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

internal extension WebView {
    
    func createView() -> WKWebView {
        WKWebView()
    }
    
    func updateView(_ webView: WKWebView) {
        webView.load(request)
    }
}

#if canImport(UIKit)
import UIKit

extension WebView: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> WKWebView {
        createView()
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        updateView(webView)
    }
}

#elseif canImport(AppKit)
import AppKit

extension WebView: NSViewRepresentable {
    
    public func makeNSView(context: Context) -> WKWebView {
        createView()
    }
    
    public func updateNSView(_ webView: WKWebView, context: Context) {
        updateView(webView)
    }
}

#endif

#Preview {
    WebView(url: URL(string: "https://google.com")!)
}
#endif
