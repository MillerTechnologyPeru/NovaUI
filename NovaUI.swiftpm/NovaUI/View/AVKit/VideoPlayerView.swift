//
//  VideoPlayerView.swift
//  
//
//  Created by Alsey Coleman Miller on 6/17/25.
//

import SwiftUI
import AVKit

/// AVKit Video Player View
public struct VideoPlayerView {
    
    let player: AVPlayer
    
    var modalPresentationStyle: UIModalPresentationStyle
    
    var showsPlaybackControls: Bool
    
    public init(
        player: AVPlayer,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        showsPlaybackControls: Bool = true
    ) {
        self.player = player
        self.modalPresentationStyle = modalPresentationStyle
        self.showsPlaybackControls = showsPlaybackControls
    }
}

// MARK: - UIViewControllerRepresentable

extension VideoPlayerView: UIViewControllerRepresentable {
    
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.modalPresentationStyle = modalPresentationStyle
        controller.showsPlaybackControls = showsPlaybackControls
        return controller
    }

    public func updateUIViewController(_ controller: AVPlayerViewController, context: Context) {
        controller.modalPresentationStyle = modalPresentationStyle
        controller.showsPlaybackControls = showsPlaybackControls
    }
}
