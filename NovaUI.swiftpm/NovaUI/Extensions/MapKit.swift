//
//  MapKit.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(MapKit)
import Foundation
import MapKit
import CoreLocation

extension MKCoordinateRegion {
    
    static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center == rhs.center
            && lhs.span == rhs.span
    }
    
    static func != (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        (lhs == rhs) == false
    }
}

extension MKCoordinateSpan {
    
    static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta
            && rhs.longitudeDelta == rhs.longitudeDelta
    }
}
#endif
