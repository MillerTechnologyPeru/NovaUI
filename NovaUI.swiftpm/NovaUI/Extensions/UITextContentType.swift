//
//  UITextContentType.swift
//  
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

#if canImport(UIKit)
import Foundation
import UIKit

internal extension UITextContentType {
    
    static var birthdateMonthContent: UITextContentType {
        if #available(iOS 17.0, *) {
            .birthdateMonth
        } else {
            .dateTime
        }
    }
    
    static var birthdateDayContent: UITextContentType {
        if #available(iOS 17.0, *) {
            .birthdateDay
        } else {
            .dateTime
        }
    }
}

#endif
