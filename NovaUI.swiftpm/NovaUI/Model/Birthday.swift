//
//  Birthday.swift
//  NovaUI
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

import Foundation
#if canImport(SwiftUI)
import struct SwiftUI.LocalizedStringKey
#endif

/// User Birthday, not including the year.
public struct Birthday: Equatable, Hashable, Codable, Sendable {
    
    public var day: Day
    
    public var month: Month
    
    public init(
        day: Day = 1,
        month: Month = .january
    ) {
        self.day = day
        self.month = month
    }
}

// MARK: - Month

public extension Birthday {
    
    /// Represents the months of the Gregorian calendar year.
    enum Month: UInt, Codable, Sendable, CaseIterable {
        
        /// January (1)
        case january = 1
        
        /// February (2)
        case february = 2
        
        /// March (3)
        case march = 3
        
        /// April (4)
        case april = 4
        
        /// May (5)
        case may = 5
        
        /// June (6)
        case june = 6
        
        /// July (7)
        case july = 7
        
        /// August (8)
        case august = 8
        
        /// September (9)
        case september = 9
        
        /// October (10)
        case october = 10
        
        /// November (11)
        case november = 11
        
        /// December (12)
        case december = 12
    }
}

#if canImport(SwiftUI)
public extension Birthday.Month {
    
    /// The full name of the month.
    var localizedKey: LocalizedStringKey {
        switch self {
        case .january: return "January"
        case .february: return "February"
        case .march: return "March"
        case .april: return "April"
        case .may: return "May"
        case .june: return "June"
        case .july: return "July"
        case .august: return "August"
        case .september: return "September"
        case .october: return "October"
        case .november: return "November"
        case .december: return "December"
        }
    }
}
#endif

// MARK: - Day

public extension Birthday {
    
    struct Day: RawRepresentable, Equatable, Hashable, Codable, Sendable {
        
        public let rawValue: UInt
        
        public init?(rawValue: UInt) {
            guard Self.validate(rawValue) else {
                return nil
            }
            self.rawValue = rawValue
        }
        
        private init(_ unsafe: UInt) {
            assert(Self.validate(unsafe), "Invalid day \(unsafe)")
            self.rawValue = unsafe
        }
    }
}

extension Birthday.Day: CaseIterable {
    
    static public var allCases: [Self] {
        (Self.min.rawValue ... Self.max.rawValue).map { Self($0) }
    }
}

internal extension Birthday.Day {
    
    static func validate(_ rawValue: UInt) -> Bool {
        rawValue >= 1 && rawValue <= 31
    }
}

public extension Birthday.Day {
    
    static var min: Self { 1 }
    
    static var max: Self { 31 }
}

extension Birthday.Day: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

extension Birthday.Day: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        rawValue.description
    }
}
