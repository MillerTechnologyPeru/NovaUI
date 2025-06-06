//
//  CoreLocation.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(CoreLocation)
import Foundation
import CoreLocation

internal extension CLLocationCoordinate2D {
    
    /// Returns the distance (measured in meters) from the current object’s location to the specified location.
    func distance(
        to there: CLLocationCoordinate2D
    ) -> Double {
        let point1 = CLLocation(latitude: latitude, longitude: longitude)
        let point2 = CLLocation(latitude: there.latitude, longitude: there.longitude)
        return point1.distance(from: point2)
    }
}

internal extension CLLocationCoordinate2D {
    
    static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
    }
}
#endif
