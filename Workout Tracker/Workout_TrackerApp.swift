	//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by stud on 27/10/2025.
//

import SwiftUI
import SwiftData

@main
struct Workout_TrackerApp: App {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(workoutViewModel)
        }
    }
}
