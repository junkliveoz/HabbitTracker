//
//  HabitData.swift
//  HabbitTracker
//
//  Created by Adam Sayer on 5/8/2024.
//

import SwiftUI

class Habit: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var name: String
    @Published var description: String
    @Published var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, count
    }
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        count = try container.decode(Int.self, forKey: .count)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(count, forKey: .count)
    }
}

extension Habit: Hashable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class HabitStore: ObservableObject {
    @Published var habits: Set<Habit> = []
    
    init() {
        loadHabits()
    }
    
    func addHabit(name: String, description: String) {
        let newHabit = Habit(name: name, description: description)
        habits.insert(newHabit)
        saveHabits()
    }
    
    func removeHabit(_ habit: Habit) {
        habits.remove(habit)
        saveHabits()
    }
    
    func incrementCount(for habit: Habit) {
        if let index = habits.firstIndex(of: habit) {
            let updatedHabit = habit
            updatedHabit.count += 1
            habits.remove(at: index)
            habits.insert(updatedHabit)
            saveHabits()
        }
    }
    
    func updateHabitName(habit: Habit, newName: String, newDescription: String) {
        if let index = habits.firstIndex(of: habit) {
            habits.remove(at: index)
            let updatedHabit = Habit(name: newName, description: newDescription)
            updatedHabit.count = habit.count
            updatedHabit.id = habit.id
            habits.insert(updatedHabit)
            saveHabits()
        }
    }
    
    private func saveHabits() {
            do {
                let data = try JSONEncoder().encode(Array(habits))
                UserDefaults.standard.set(data, forKey: "habits")
            } catch {
                print("Failed to save habits: \(error.localizedDescription)")
            }
        }
        
        private func loadHabits() {
            guard let data = UserDefaults.standard.data(forKey: "habits") else { return }
            do {
                let decodedHabits = try JSONDecoder().decode([Habit].self, from: data)
                habits = Set(decodedHabits)
            } catch {
                print("Failed to load habits: \(error.localizedDescription)")
            }
        }
}
