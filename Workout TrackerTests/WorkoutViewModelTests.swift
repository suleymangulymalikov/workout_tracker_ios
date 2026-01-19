import XCTest
@testable import Workout_Tracker

final class WorkoutViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "saved_workouts")
        UserDefaults.standard.removeObject(forKey: "completed_workouts")
    }
// 1
    func testAddExercise_AddsExerciseToList() async {
        await MainActor.run {
            // Arrange
            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex = ExerciseItem(
                id: "pushups",
                name: "Push-Ups",
                image: "pushups",
                description: "Test exercise",
                videoURL: nil
            )

            // Act
            vm.addExercise(exercise: ex, sets: 3, reps: 10)

            // Assert
            XCTAssertEqual(vm.exercises.count, 1)
            XCTAssertEqual(vm.exercises.first?.exercise.name, "Push-Ups")
            XCTAssertEqual(vm.exercises.first?.sets, 3)
            XCTAssertEqual(vm.exercises.first?.reps, 10)
        }
    }
// 2
    func testSaveWorkout_DoesNotSaveWhenNameIsEmpty() async {
        await MainActor.run {
            // Arrange
            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex = ExerciseItem(
                id: "pushups",
                name: "Push-Ups",
                image: "pushups",
                description: "Test exercise",
                videoURL: nil
            )

            vm.workoutName = "" // empty on purpose
            vm.addExercise(exercise: ex, sets: 3, reps: 10)

            // Act
            vm.saveWorkout()

            // Assert
            XCTAssertEqual(vm.workouts.count, 0, "Workout should NOT be saved when name is empty")
        }
    }
// 3
    func testSaveWorkout_DoesNotSaveWhenExercisesEmpty() async {
        await MainActor.run {
            // Arrange
            let vm = WorkoutViewModel(loadFromStorage: false)

            vm.workoutName = "Morning Workout"
            // vm.exercises is empty on purpose

            // Act
            vm.saveWorkout()

            // Assert
            XCTAssertEqual(vm.workouts.count, 0, "Workout should NOT be saved when exercises are empty")
        }
    }
// 4
    func testSaveWorkout_SavesWorkoutAndResetsFields() async {
        await MainActor.run {
            // Arrange
            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex = ExerciseItem(
                id: "pushups",
                name: "Push-Ups",
                image: "pushups",
                description: "Test exercise",
                videoURL: nil
            )

            vm.workoutName = "Morning Workout"
            vm.addExercise(exercise: ex, sets: 3, reps: 10)

            // Act
            vm.saveWorkout()

            // Assert 1: workout saved
            XCTAssertEqual(vm.workouts.count, 1)
            XCTAssertEqual(vm.workouts.first?.name, "Morning Workout")
            XCTAssertEqual(vm.workouts.first?.exercises.count, 1)

            // Assert 2: builder reset
            XCTAssertEqual(vm.workoutName, "")
            XCTAssertTrue(vm.exercises.isEmpty)
        }
    }
// 5
    func testMarkWorkoutCompleted_AddsCompletedWorkout() async {
        await MainActor.run {
            // Arrange
            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex = ExerciseItem(
                id: "pushups",
                name: "Push-Ups",
                image: "pushups",
                description: "Test exercise",
                videoURL: nil
            )

            let workout = Workout(
                name: "Test Workout",
                exercises: [WorkoutExercise(exercise: ex, sets: 3, reps: 10)]
            )

            // Act
            vm.markWorkoutCompleted(workout: workout)

            // Assert
            XCTAssertEqual(vm.completedWorkouts.count, 1)
            XCTAssertEqual(vm.completedWorkouts.first?.workoutName, "Test Workout")
            XCTAssertEqual(vm.completedWorkouts.first?.exercisesCompleted, 1)

            // Optional: just check date exists (not exact)
            XCTAssertNotNil(vm.completedWorkouts.first?.dateCompleted)
        }
    }

// 6
    func testAddExercise_TwiceAddsTwoExercises() async {
        await MainActor.run {
            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex1 = ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "d", videoURL: nil)
            let ex2 = ExerciseItem(id: "squats", name: "Squats", image: "squats", description: "d", videoURL: nil)

            vm.addExercise(exercise: ex1, sets: 3, reps: 10)
            vm.addExercise(exercise: ex2, sets: 4, reps: 12)

            XCTAssertEqual(vm.exercises.count, 2)
            XCTAssertEqual(vm.exercises[0].exercise.name, "Push-Ups")
            XCTAssertEqual(vm.exercises[1].exercise.name, "Squats")
        }
    }

// 7
    func testSaveWorkout_WritesToUserDefaults() async {
        await MainActor.run {
//            UserDefaults.standard.removeObject(forKey: "saved_workouts")

            let vm = WorkoutViewModel(loadFromStorage: false)
            let ex = ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "d", videoURL: nil)

            vm.workoutName = "Persisted Workout"
            vm.addExercise(exercise: ex, sets: 3, reps: 10)
            vm.saveWorkout()

            let savedData = UserDefaults.standard.data(forKey: "saved_workouts")
            XCTAssertNotNil(savedData, "Expected saved_workouts to exist in UserDefaults after saving")
        }
    }

// 8
    func testInit_LoadFromStorage_LoadsSavedWorkouts() async {
        await MainActor.run {
            // Seed UserDefaults with one workout
            let ex = ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "d", videoURL: nil)
            let workout = Workout(name: "Seed Workout", exercises: [WorkoutExercise(exercise: ex, sets: 3, reps: 10)])

            let data = try? JSONEncoder().encode([workout])
            UserDefaults.standard.set(data, forKey: "saved_workouts")

            // Act: create VM that loads from storage
            let vm = WorkoutViewModel(loadFromStorage: true)

            // Assert
            XCTAssertEqual(vm.workouts.count, 1)
            XCTAssertEqual(vm.workouts.first?.name, "Seed Workout")
        }
    }

    func testMarkWorkoutCompleted_WritesCompletedToUserDefaults() async {
        await MainActor.run {
            UserDefaults.standard.removeObject(forKey: "completed_workouts")

            let vm = WorkoutViewModel(loadFromStorage: false)

            let ex = ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "d", videoURL: nil)
            let workout = Workout(name: "Done Workout", exercises: [WorkoutExercise(exercise: ex, sets: 3, reps: 10)])

            vm.markWorkoutCompleted(workout: workout)

            let savedData = UserDefaults.standard.data(forKey: "completed_workouts")
            XCTAssertNotNil(savedData, "Expected completed_workouts to exist in UserDefaults after marking completed")
        }
    }

// 10
    func testSaveWorkout_TwiceCreatesTwoWorkouts() async {
        await MainActor.run {
            let vm = WorkoutViewModel(loadFromStorage: false)
            let ex = ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "d", videoURL: nil)

            // Save first workout
            vm.workoutName = "Workout A"
            vm.addExercise(exercise: ex, sets: 3, reps: 10)
            vm.saveWorkout()

            // Save second workout
            vm.workoutName = "Workout B"
            vm.addExercise(exercise: ex, sets: 4, reps: 12)
            vm.saveWorkout()

            XCTAssertEqual(vm.workouts.count, 2)
            XCTAssertEqual(vm.workouts[0].name, "Workout A")
            XCTAssertEqual(vm.workouts[1].name, "Workout B")
        }
    }

}
