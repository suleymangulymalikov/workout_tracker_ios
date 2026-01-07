import SwiftUI

struct WorkoutExercise: Identifiable, Codable, Hashable {
    let id: UUID
    let exercise: ExerciseItem
    let sets: Int
    let reps: Int

    init(
        exercise: ExerciseItem,
        sets: Int,
        reps: Int
    ) {
        self.id = UUID()
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
    }
}

