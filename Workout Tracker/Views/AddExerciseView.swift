import SwiftUI
import AVKit
import Combine


struct AddExerciseView: View {
//    @Environment(\.dismiss) var dismiss
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WorkoutViewModel
    // Example exercise list
    let exercises: [ExerciseItem] = [
        ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "A classic upper-body exercise that targets chest, shoulders, and triceps.", videoURL: "pushups_vidoe"),
        ExerciseItem(id: "pullups", name: "Pull-Ups", image: "pullups", description: "Great for building back and biceps strength.", videoURL: "pullups_video"),
        ExerciseItem(id: "crunches", name: "Crunches", image: "crunches", description: "Targets the abdominal muscles for core strength.", videoURL: "crunches_video"),
        ExerciseItem(id: "plank", name: "Plank", image: "plank", description: "Isometric core exercise improving stability and posture.", videoURL: nil),
        ExerciseItem(id: "jogging",name: "Jogging", image: "jogging", description: "Light running to improve cardiovascular health.", videoURL: nil),
        ExerciseItem(id: "situps" ,name: "Sit-Ups", image: "situps", description: "Core movement engaging abs and hip flexors.", videoURL: nil),
        ExerciseItem(id: "squats", name: "Squat", image: "squats", description: "Compound lower-body movement targeting quads and glutes.", videoURL: nil),
        ExerciseItem(id: "lunge", name: "Lunge", image: "lunge", description: "Single-leg exercise building balance and leg strength.", videoURL: nil),
        ExerciseItem(id: "jumping_jacks", name: "Jumping Jacks", image: "jumping_jacks", description: "Full-body warm-up increasing heart rate.", videoURL: nil),
        ExerciseItem(id: "mountain-climbers", name: "Mountain Climbers", image: "mountain-climbers", description: "Dynamic core and cardio movement.", videoURL: nil),
        ExerciseItem(id: "superman", name: "Superman", image: "superman", description: "Back extension to strengthen lower back.", videoURL: nil)
    ]
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {

                Text("Add Exercise")
                    .font(.largeTitle)
                    .bold()

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(exercises) { exercise in
                            NavigationLink {
                                ExerciseDetailView(exercise: exercise)
                                    .environmentObject(viewModel)
                            } label: {
                                HStack(spacing: 16) {
                                    Image(exercise.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))

                                    Text(exercise.name)
                                        .font(.headline)

                                    Spacer()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.1), radius: 4)
                                .foregroundColor(.orange)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }

struct ExerciseItem: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let image: String
    let description: String
    let videoURL: String?
}

#Preview {
    MainTabView()
}


struct ExerciseDetailView: View {
    let exercise: ExerciseItem


    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss

    @State private var sets = 3
    @State private var reps = 10
    @State private var showSaveSheet = false

    @State private var player: AVPlayer?

    init(exercise: ExerciseItem) {
        self.exercise = exercise

        if let name = exercise.videoURL,
           let url = Bundle.main.url(forResource: name, withExtension: "mp4") {
            _player = State(initialValue: AVPlayer(url: url))
        } else {
            _player = State(initialValue: nil)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Image(exercise.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(exercise.name)
                    .font(.title)
                    .bold()

                Text(exercise.description)
                    .foregroundColor(.secondary)

                if let player = player {
                    VideoPlayer(player: player)
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onAppear{player.play()}
                } else {
                    Text("No sample video available")
                        .foregroundColor(.secondary)
                }
                Button {
                    showSaveSheet = true
                } label: {
                    Text("Save Exercise")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                
            }
            .padding()
        }
        .sheet(isPresented: $showSaveSheet) {
            saveSheet
        }
    }

    private var saveSheet: some View {
        VStack(spacing: 20) {
            Text("Exercise Details")
                .font(.title2)
                .bold()

            Stepper("Sets: \(sets)", value: $sets, in: 1...10)

            Stepper("Reps: \(reps)", value: $reps, in: 1...20)
            
            Button("Save") {
                viewModel.addExercise(
                    exercise: exercise,
                    sets: sets,
                    reps: reps
                )
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }
}


