//
//  MapView.swift
//  
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(MapKit)
import Foundation
import MapKit
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// `MKMapView`
@MainActor
public struct MapView <Annotation> where Annotation: MKAnnotation, Annotation: Hashable {
    
    let mapType: MKMapType
    
    @Binding
    var region: MKCoordinateRegion
    
    @Binding
    var userTrackingMode: MKUserTrackingMode
    
    let annotationItems: [Annotation]
    
    let configureAnnotationView: (MKMapView, Annotation) -> (MKAnnotationView)
    
    let calloutAccessoryControlTapped: ((Annotation) -> ())?
    
    public init(
        mapType: MKMapType,
        region: Binding<MKCoordinateRegion>,
        userTrackingMode: Binding<MKUserTrackingMode>,
        annotationItems: [Annotation],
        configureAnnotationView: @escaping ((MKMapView, Annotation) -> MKAnnotationView),
        calloutAccessoryControlTapped: ((Annotation) -> Void)? = nil
    ) {
        self.mapType = mapType
        self._region = region
        self._userTrackingMode = userTrackingMode
        self.annotationItems = annotationItems
        self.configureAnnotationView = configureAnnotationView
        self.calloutAccessoryControlTapped = calloutAccessoryControlTapped
    }
}

internal extension MapView {
    
    func setupView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        configureView(view, animated: false, context: context)
    }
    
    func configureView(_ view: MKMapView, animated: Bool, context: Context) {
        view.mapType = self.mapType
        if view.region != self.region {
            view.setRegion(self.region, animated: animated)
        }
        if view.userTrackingMode != self.userTrackingMode {
            view.setUserTrackingMode(self.userTrackingMode, animated: animated)
        }
        // add annotations
        if view.annotations.isEmpty {
            // TODO: handle changing annotations
            view.addAnnotations(self.annotationItems)
        }
    }
}

// MARK: - MKMapViewDelegate

public extension MapView {
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        
        var view: MapView
        
        var task: Task<Void, Never>?
                
        init(_ view: MapView) {
            self.view = view
        }
        
        public func mapView(
            _ mapView: MKMapView,
            regionWillChangeAnimated animated: Bool
        ) {
            
        }
        
        public func mapView(
            _ mapView: MKMapView,
            regionDidChangeAnimated animated: Bool
        ) {
            if view.region != mapView.region {
                let oldTask = task
                task = Task {
                    await oldTask?.value
                    try? await Task.sleep(timeInterval: 0.5)
                    await MainActor.run {
                        view.region = mapView.region
                    }
                }
            }
        }
        
        public func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
            view.userTrackingMode = mapView.userTrackingMode
        }
        
        public func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
            view.userTrackingMode = mapView.userTrackingMode
        }
        
        public func mapView(
            _ mapView: MKMapView,
            didChange mode: MKUserTrackingMode,
            animated: Bool
        ) {
            view.userTrackingMode = mode
        }
                
        public func mapView(
            _ mapView: MKMapView,
            viewFor annotation: MKAnnotation
        ) -> MKAnnotationView? {
            guard mapView.userLocation !== annotation  else {
                return nil
            }
            // configure view
            guard let annotation = annotation as? Annotation else {
                return nil
            }
            return view.configureAnnotationView(mapView, annotation)
        }
        
        #if canImport(UIKit)
        public func mapView(
            _ mapView: MKMapView,
            annotationView view: MKAnnotationView,
            calloutAccessoryControlTapped control: UIControl
        ) {
            guard let annotation = view.annotation as? Annotation,
                  let callback = self.view.calloutAccessoryControlTapped else {
                return
            }
            callback(annotation)
        }
        #endif
    }
}

// MARK: - UIViewRepresentable

#if canImport(UIKit)

extension MapView: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        setupView(view, context: context)
        return view
    }
    
    public func updateUIView(_ view: MKMapView, context: Context) {
        configureView(view, animated: true, context: context)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

#endif

// MARK: - NSViewRepresentable

#if canImport(AppKit)
extension MapView: NSViewRepresentable {
    
    public func makeNSView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        setupView(view, context: context)
        return view
    }
    
    public func updateNSView(_ view: MKMapView, context: Context) {
        configureView(view, animated: true)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
#endif

// MARK: - Preview

#if DEBUG
#Preview {
    NavigationView {
        MapPreviewView()
    }
}
#endif

struct MapPreviewView: View {
    
    let mapType: MKMapType
    
    let annotations: [TestAnnotation]
    
    @State
    var shownItems = [TestAnnotation]()
    
    let pinImage: MKAnnotationView.Image
    
    @State
    var showsUserLocation = false
    
    @State
    var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 34.454439,
            longitude: -81.928657
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 16,
            longitudeDelta: 16
        )
    )
    
    @State
    private var userTrackingMode: MKUserTrackingMode = .none
    
    @State
    private var didRegisterView = false
    
    var body: some View {
        MapView(
            mapType: mapType,
            region: $region,
            userTrackingMode: $userTrackingMode,
            annotationItems: annotations,
            configureAnnotationView: configureAnnotationView,
            calloutAccessoryControlTapped: calloutAccessoryControlTapped
        )
        .edgesIgnoringSafeArea(.all)
    }
}

internal extension MapPreviewView {
    
    init() {
        self.init(
            mapType: .standard,
            annotations: [
                TestAnnotation(
                    coordinate: .init(
                        latitude: 34.454439,
                        longitude: -81.928657
                    ),
                    title: "Home",
                    subtitle: "240 Fishers Cove Rd"
                ),
                TestAnnotation(
                    coordinate: .init(
                        latitude: 28.454439,
                        longitude: -80.928657
                    ),
                    title: "Work",
                    subtitle: "106 Via Duomo"
                )
            ],
            pinImage: .init(systemName: "mappin")!
        )
    }
    
    func configureAnnotationView(mapView: MKMapView, annotation: TestAnnotation) -> MKAnnotationView {
        print("Will configure annotation \(annotation.title ?? "")")
        let reuseIdentifier = NSStringFromClass(TestAnnotation.self)
        // register view if needed
        if didRegisterView == false {
            mapView.register(TestAnnotation.self, forAnnotationViewWithReuseIdentifier: reuseIdentifier)
            didRegisterView = true
        }
        let view = /* mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) ?? */ MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        view.image = pinImage
        view.canShowCallout = true
        return view
    }
    
    func calloutAccessoryControlTapped(annotation: TestAnnotation) {
        print("Selected site \(annotation.title ?? "")")
    }
}

internal extension MKAnnotationView {
    
    typealias Image = UIImage
}

@objc(NovaUITestAnnotation)
internal final class TestAnnotation: NSObject, MKAnnotation {
    
    @objc
    var coordinate: CLLocationCoordinate2D
    
    @objc
    var title: String?
    
    @objc
    var subtitle: String?
            
    init(
        coordinate: CLLocationCoordinate2D,
        title: String? = nil,
        subtitle: String? = nil
    ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

#endif
