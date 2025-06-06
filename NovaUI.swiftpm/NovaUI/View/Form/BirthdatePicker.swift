//
//  BirthdatePicker.swift
//
//
//  Created by Alsey Coleman Miller on 6/5/25.
//

import Foundation
import SwiftUI

/// Birthdate picker for month and day.
@available(macOS, unavailable)
public struct BirthdatePicker: View {
    
    @Binding
    public var selection: Selection
    
    let days = Selection.Day.allCases
    
    let months = Selection.Month.allCases
    
    public init(selection: Binding<Selection>) {
        self._selection = selection
    }
    
    public var body: some View {
        HStack {
            Picker(selection: $selection.month, content: {
                ForEach(months, id: \.self) {
                    Text($0.localizedKey)
                        .tag($0)
                }
            }, label: {
                EmptyView()
            })
            Picker(selection: $selection.day, content: {
                ForEach(days, id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }, label: {
                EmptyView()
            })
        }
        .pickerStyle(.wheel)
    }
}

@available(macOS, unavailable)
public extension BirthdatePicker {
    
    typealias Selection = Birthday
}

@available(macOS, unavailable)
extension BirthdatePicker {
    
    struct PreviewView: View {
        
        @State
        var date = BirthdatePicker.Selection(day: 1, month: .january)
        
        var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Text("Month")
                        Text(verbatim: "\(date.month)")
                    }
                    HStack {
                        Text("Day")
                        Text(verbatim: "\(date.day)")
                    }
                    BirthdatePicker(selection: $date)
                }
                .padding()
            }
            .navigationTitle("Date Picker")
        }
    }
}

@available(macOS, unavailable)
#Preview {
    NavigationView {
        BirthdatePicker.PreviewView()
    }
}
