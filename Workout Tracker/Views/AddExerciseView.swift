import SwiftUI


struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss

    // Example exercise list
    let exercises: [ExerciseItem] = [
        ExerciseItem(name: "Push-Ups", image: "pushups"),
        ExerciseItem(name: "Pull-Ups", image: "pullups"),
        ExerciseItem(name: "Crunches", image: "crunches"),
        ExerciseItem(name: "Plank", image: "plank"),
        ExerciseItem(name: "Jogging", image: "jogging"),
        ExerciseItem(name: "Sit-Ups", image: "situps"),
        ExerciseItem(name: "Squat", image: "squat")
        
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
                    ForEach(exercises, id: \.name) { exercise in
                        Button(action: {
                            print("Added: \(exercise.name)")
                            dismiss()
                        }) {
                            HStack(spacing: 16) {	

                                Image(exercise.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 6	))

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

struct ExerciseItem {
    let name: String
    let image: String
}

#Preview {
    AddExerciseView()
}
