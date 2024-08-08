//
//  ContentView.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject private var habitStore = HabitStore()
    @State private var isAddingNewHabit = false
    
    @State private var habitToDelete: Habit?
    
    var body: some View {
        ZStack {
            NavigationStack {
                HomeListView(habitStore: habitStore, habitToDelete: $habitToDelete)
                    .padding()
                    .navigationTitle("Habit Tracker")
                    .toolbar {
                        Button {
                            isAddingNewHabit = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        .foregroundColor(.deepOrange)
                    }
                    .darkModeStyle()
            }
            .sheet(isPresented: $isAddingNewHabit) {
                NavigationStack {
                    NewHabit(habitStore: habitStore)
                }
            }
            .accentColor(.deepOrange)
            .darkModeStyle()
            
            if let habitToDelete = habitToDelete {
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                CustomAlertView(
                    title: "Confirm Delete",
                    message: "Are you sure you want to delete \(habitToDelete.name)?",
                    onCancel: {
                        self.habitToDelete = nil
                    },
                    onConfirm: {
                        habitStore.removeHabit(habitToDelete)
                        self.habitToDelete = nil
                    }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
