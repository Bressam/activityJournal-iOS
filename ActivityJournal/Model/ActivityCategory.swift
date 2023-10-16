//
//  ActivityCategory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation
import SwiftUI

enum ActivityCategory: Codable, CaseIterable {
    case none, sport, finacesSaving, study
    
    var name: String {
        switch self {
        case .none: return "Not defined"
        case .sport: return "Sports"
        case .finacesSaving: return "Finances Savings"
        case .study: return "Study"
        }
    }
    
    var emoji: String {
        switch self {
        case .none: return "🫥"
        case .sport: return "🏋️‍♀️"
        case .finacesSaving: return "💰"
        case .study: return "📚"
        }
    }
    
    var chartDataColor: Color {
        switch self {
        case .none: return .indigo
        case .sport: return .yellow
        case .finacesSaving: return .green
        case .study: return .purple
        }
    }
    
    var chartGoalMarkerColor: Color {
        switch self {
        case .none: return .blue
        case .sport: return .red
        case .finacesSaving: return .yellow
        case .study: return .yellow
        }
    }
    
    var description: String {
        switch self {
        case .none: return "General activities"
        case .sport: return "Sport"
        case .finacesSaving: return "Finances Savings"
        case .study: return "Study"
        }
    }
}
