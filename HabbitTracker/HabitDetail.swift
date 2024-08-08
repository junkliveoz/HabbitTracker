//
//  HabitDetail.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

struct HabitDetail: View {
    
    @ObservedObject var habit: Habit
    @ObservedObject var habitStore: HabitStore
    @State private var isEditing = false
    @State private var editedName: String
    @State private var editedDescription: String
    @State private var addNewPractise = false
    
    init(habit: Habit, habitStore: HabitStore) {
        self.habit = habit
        self.habitStore = habitStore
        _editedName = State(initialValue: habit.name)
        _editedDescription = State(initialValue: habit.description)
    }
    
    var body: some View {
        ZStack {
            Color.darkGray.edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    Section(header: Text("\(habit.name) Details")) {
                        if isEditing {
                            TextField("Habit Name", text: $editedName)
                            TextField("Habit Description", text:$editedDescription)
                        } else {
                            Text(habit.name)
                            if habit.description.isEmpty == false {
                                Text(habit.description)
                            }
                        }
                        
                        
                        HStack {
                            Text("Times practiced:")
                            Spacer()
                            Text("\(habit.count)")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        addNewPractise.toggle()
                        //habitStore.incrementCount(for: habit)
                    }) {
                        Text("Add another practice")
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity)
                    .background(.deepOrange)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
            }
            .navigationTitle("Habit Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    if isEditing {
                        habitStore.updateHabitName(habit: habit, newName: editedName, newDescription: editedDescription)
                    }
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Save" : "Edit Name")
                }
            }
            .darkModeStyle()
            
            if addNewPractise {
                CustomAlertView(
                    title: "Confirm Practice",
                    message: "Are you sure you want to add another practice for \(habit.name)?",
                    onCancel: {
                        addNewPractise = false
                    },
                    onConfirm: {
                        habitStore.incrementCount(for: habit)
                        addNewPractise = false
                    }
                )
            }
        }
    }
}

#Preview {
    HabitDetail(habit: Habit(name: "Sample Habit", description: "Sample Description"), habitStore: HabitStore())
}
