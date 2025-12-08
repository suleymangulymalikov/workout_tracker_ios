import SwiftUI
import AVKit


struct AddExerciseView: View {
//    @Environment(\.dismiss) var dismiss
    @Environment(\.dismiss) var dismiss

    // Example exercise list
    let exercises: [ExerciseItem] = [
        ExerciseItem(id: "pushups", name: "Push-Ups", image: "pushups", description: "A classic upper-body exercise that targets chest, shoulders, and triceps.", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")),
        ExerciseItem(id: "pullups", name: "Pull-Ups", image: "pullups", description: "Great for building back and biceps strength.", videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")),
        ExerciseItem(id: "crunches", name: "Crunches", image: "crunches", description: "Targets the abdominal muscles for core strength.", videoURL: nil),
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
            
            Text("Select an exercise to add")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(exercises) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
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
                            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                            .foregroundColor(.orange)
                        }
                    }
                }
                .padding(.top)
            }
            
            Spacer()
        }
    }
}

struct ExerciseItem: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let description: String
    let videoURL: URL?
}

#Preview {
    MainTabView()
}

struct ExerciseDetailView: View {
    let exercise: ExerciseItem

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
                    .font(.body)
                    .foregroundColor(.secondary)

                if let url = exercise.videoURL {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("No sample video available")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Exercise Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

