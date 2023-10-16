//
//  JournalNavigationStyle.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import SwiftUI

struct JournalNavigationStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.large)
            .background(Color(UIColor.secondarySystemBackground))
            .background(Color.red)
    }
}
