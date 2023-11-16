import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var tapNumber = 0
    @State private var tapNumberString = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue, .yellow], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text ("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.title2.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            calcQuestion()
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text ("Your score is \(userScore)")
                }
                .alert(tapNumberString, isPresented: $showingAlert) {
                    Button("Start", action: reset)
                } message: {
                    Text ("Game over. Your score is \(userScore)")
                }
                Spacer()
                Spacer()
                Group {
                    Text ("Question: \(tapNumber)")
                    Text ("Score: \(userScore)")
                }
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Exellent. You are right"
            tapNumber += 1
            userScore += 1
        } else {
            scoreTitle = "Incorrect! It's flag of \(countries[number])"
            tapNumber += 1
        }
        showingScore = true
    }
    
    func reset() {
        tapNumber = 0
        userScore = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func calcQuestion () {
        guard tapNumber != 3 else {
            tapNumberString = "That's all"
            return showingAlert = true
        }
    }
}

#Preview {
    ContentView()
}
