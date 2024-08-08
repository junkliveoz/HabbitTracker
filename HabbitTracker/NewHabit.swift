//
//  NewHabit.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

struct NewHabit: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habitStore: HabitStore
    @State private var newHabitName = ""
    @State private var newHabitDescription = ""
    
    var body: some View {
        Form {
            TextField("Habit Name", text: $newHabitName)
            TextField("Habit Description", text: $newHabitDescription)
        }
        .navigationTitle("Add New Habit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if !newHabitName.isEmpty {
                        habitStore.addHabit(name: newHabitName, description: newHabitDescription)
                        dismiss()
                        
                    }
                }
            }
        }
        .accentColor(.deepOrange)
        .darkModeStyle()
    }
}

#Preview {
    NewHabit(habitStore: HabitStore())
}
