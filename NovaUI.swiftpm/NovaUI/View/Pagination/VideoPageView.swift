//
//  VideoPageView.swift
//  
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

import Foundation
import SwiftUI

public struct VideoPageView: View {
        
    let videos: [Video]
    
    @State
    var selection: Video.ID
    
    public init(
        videos: [Video]
    ) {
        assert(videos.isEmpty == false)
        self.videos = videos
        self._selection = .init(initialValue: videos[0].id)
    }
    
    public var body: some View {
        VStack {
            PageView(selection: $selection, indexBackgroundDisplayMode: .never) {
                ForEach(videos) { video in
                    VideoView(video: video)
                        .tag(video.id)
                }
            }
        }
    }
}

// MARK: - Supporting Types

internal extension VideoPageView {
    
    struct VideoView: View {
        
        let video: Video
        
        var body: some View {
            GeometryReader { geometry in
                
                ZStack {
                    // Preview Image
                    VStack {
                        CachedAsyncImage(
                            url: video.previewImageURL,
                            content: { content in
                                switch content {
                                case .empty:
                                    Color.gray
                                case let .success(image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipped()
                                case let .failure(error):
                                    VStack {
                                        Spacer()
                                        Text(verbatim: error.localizedDescription)
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.yellow)
                                        Spacer()
                                    }
                                @unknown default:
                                    Color.gray
                                }
                            }
                        )
                    }
                    // Text Box
                    VStack {
                        Spacer()
                        VStack(spacing: 20) {
                            Text(verbatim: video.title)
                                .font(.title)
                                .bold()
                            Text(verbatim: video.description)
                                .lineLimit(nil)
                        }
                        .padding()
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

// MARK: Model

public extension VideoPageView {
    
    struct Video: Equatable, Hashable, Codable, Identifiable {
        
        public let id: String
        
        public let title: String
        
        public let description: String
        
        public let previewImageURL: URL
        
        public let previewVideoURL: URL?
    }
}

// MARK: - Preview

public extension VideoPageView {
    
    struct Preview: View {
        
        let videos: [VideoPageView.Video]
        
        init() {
            self.videos = [
                VideoPageView.Video(
                    id: "movies/fountain-of-youth",
                    title: "Fountain of Youth",
                    description: "It’s only a legend until you discover it. Let the treasure hunt begin.",
                    previewImageURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/fe/87/a5/fe87a540-71b6-c0f6-9f43-69de8176b968/13fff648-6aeb-46ac-9e2e-78e828e495be.png/2400x1350sr.webp")!,
                    previewVideoURL: nil
                ),
                VideoPageView.Video(
                    id: "series/stick",
                    title: "Stick",
                    description: "Owen Wilson is hilarious as a pro golfer mentoring a teen.",
                    previewImageURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/1f/2c/9e/1f2c9ec5-ae2d-1020-1d00-f072db175361/efcd594f-6a04-4b1d-b723-59405e8049f8.png/2400x1350sr.webp")!,
                    previewVideoURL: nil
                ),
                VideoPageView.Video(
                    id: "series/your-friends-and-neighbors",
                    title: "Your Friends and Neighbors",
                    description: "An irresistible tale of affairs, money, and murder.",
                    previewImageURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/48/44/ae/4844ae85-f08a-cf29-75db-3e3bd2878f9b/b522a1ab-09f5-4ef2-ab56-d22d80e0d4b4.png/2400x1350sr.webp")!,
                    previewVideoURL: nil
                ),
                VideoPageView.Video(
                    id: "series/long-way-home",
                    title: "Long Way Home",
                    description: "Two best friends. Two vintage bikes. One epic road trip across 17 European countries.",
                    previewImageURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/66/77/61/6677612c-b0f3-7a0f-9a77-cb4e3a2af662/d6f6e6c8-7302-4061-b458-70a66f27c6ab.png/2400x1350sr.webp")!,
                    previewVideoURL: nil
                )
            ]
        }
        
        public var body: some View {
            VideoPageView(videos: videos)
                .navigationTitle("Video Page View")
        }
    }
}

#Preview {
    NavigationView {
        VideoPageView.Preview()
    }
}
