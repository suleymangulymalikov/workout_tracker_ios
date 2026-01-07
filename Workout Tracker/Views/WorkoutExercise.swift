import SwiftUI

struct WorkoutExercise: Identifiable, Codable, Hashable {
    let id: UUID
    let exercise: ExerciseItem
    var sets: Int
    var repsOrTime: Int

    init(exercise: ExerciseItem, sets: Int, repsOrTime: Int) {
        self.id = UUID()
        self.exercise = exercise
        self.sets = sets
        self.repsOrTime = repsOrTime
    }
}

