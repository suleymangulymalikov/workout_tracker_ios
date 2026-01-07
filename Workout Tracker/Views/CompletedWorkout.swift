import SwiftUI

struct CompletedWorkout: Identifiable, Codable {
    let id = UUID()
    let workoutName: String
    let dateCompleted: Date
    let exercisesCompleted: Int
}
