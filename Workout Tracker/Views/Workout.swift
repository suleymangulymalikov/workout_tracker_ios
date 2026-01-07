import SwiftUI

struct Workout: Identifiable, Codable {
    let id: UUID
    var name: String
    var exercises: [WorkoutExercise]

    init(name: String, exercises: [WorkoutExercise]) {
        self.id = UUID()
        self.name = name
        self.exercises = exercises
    }
}


