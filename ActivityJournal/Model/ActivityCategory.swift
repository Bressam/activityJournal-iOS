//
//  ActivityCategory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation

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
}
