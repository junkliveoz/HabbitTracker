//
//  HomeListView.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

struct HomeListView: View {
    
    @ObservedObject var habitStore: HabitStore
    @Binding var habitToDelete: Habit?
    
    var body: some View {
            List {
                ForEach(Array(habitStore.habits), id: \.id) { habit in
                    NavigationLink(destination: HabitDetail(habit: habit, habitStore: habitStore)) {
                        HStack {
                            Text(habit.name)
                                .font(.headline)
                                .foregroundStyle(.deepOrange)
                            Spacer()
                            Text("Times practised: ")
                                .foregroundStyle(.lightGray)
                                .font(.caption)
                            Text("\(habit.count)")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                    }
                    .listRowBackground(Color.darkGray)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                habitToDelete = habit
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                
            }
            .listStyle(.plain)
        
    }
}

#Preview {
    @State var habitToDelete: Habit? = nil
    return NavigationStack {
        HomeListView(habitStore: HabitStore(), habitToDelete: $habitToDelete)
    }
}
