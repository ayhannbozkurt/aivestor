import SwiftUI
import ConfettiSwiftUI

struct Question: Identifiable {
    let id = UUID()
    let questionText: String
    let options: [String]
    let correctAnswer: String
}

struct EducationView: View {
    // Sorular
    let questions = [
        Question(
            questionText: "Borsa nedir?",
            options: [
                "Bir şirketin merkez ofisi",
                "Kamuya açık hisse senetlerinin alınıp satıldığı yer",
                "Hisse senetlerinin sadece yazıldığı yer",
                "Bankaların para biriktirdiği alan"
            ],
            correctAnswer: "Kamuya açık hisse senetlerinin alınıp satıldığı yer"
        ),
        Question(
            questionText: "Yatırım yaparken risk nedir?",
            options: [
                "Yatırımlarınızın zamanla değer kazanması",
                "Yatırımınızın değer kaybetme olasılığı",
                "Yatırım yapmanın garantisi",
                "Yatırım yapmadan önce para kazanma"
            ],
            correctAnswer: "Yatırımınızın değer kaybetme olasılığı"
        ),
        Question(
            questionText: "Borsa yatırımının temel amacı nedir?",
            options: [
                "Kısa vadede her zaman yüksek kar elde etmek",
                "Yatırımlarınızı güvenli bir şekilde artırmak",
                "Hisse senetlerini ve diğer finansal ürünleri izlemek",
                "Belirli bir hisse senedine sürekli yatırım yapmak"
            ],
            correctAnswer: "Yatırımlarınızı güvenli bir şekilde artırmak"
        )
    ]

    @State private var selectedOption: String? = nil
    @State private var showAnswer: Bool = false
    @State private var currentQuestionIndex: Int = 0
    @State private var correctCount: Int = 0
    @State private var wrongCount: Int = 0
    @State private var answeredCount: Int = 0
    @State private var showConfetti: Int = 0 // Konfeti göstermek için sayaç
    @State private var showDialog: Bool = false // Dialog box kontrolü
    @State private var navigateToTaskView: Bool = false // Navigation kontrolü

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    // Doğru ve yanlış sayacı
                    HStack {
                        Text("Doğru: \(correctCount)")
                            .foregroundColor(.black)
                        Spacer()
                        Text("Yanlış: \(wrongCount)")
                            .foregroundColor(.black)
                        Spacer()
                        Text("Toplam: \(answeredCount)/\(questions.count)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.4))
                    .cornerRadius(8)

                    // Kart (Soru ve Şıklar)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue).opacity(0.4)
                            .frame(width: 350, height: 500)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)

                        VStack(spacing: 10) {
                            // Soru metni
                            HStack(spacing: 8) {
                                Text("Soru \(currentQuestionIndex + 1):")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)

                                Text(questions[currentQuestionIndex].questionText)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                            }

                            // Şıklar
                            VStack(spacing: 15) {
                                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                                    Button(action: {
                                        if !showAnswer {
                                            selectedOption = option
                                            showAnswer = true
                                            answeredCount += 1
                                            if option == questions[currentQuestionIndex].correctAnswer {
                                                correctCount += 1
                                            } else {
                                                wrongCount += 1
                                            }

                                            // Eğer tüm sorular doğruysa ve cevaplar tamamlandıysa
                                            if answeredCount == questions.count && correctCount == questions.count {
                                                showConfetti += 1
                                                showDialog = true // Dialog göstermek için
                                            }
                                        }
                                    }) {
                                        Text(option)
                                            .padding()
                                            .frame(width: 320, height: 50, alignment: .center)
                                            .background(
                                                showAnswer
                                                    ? (option == questions[currentQuestionIndex].correctAnswer
                                                        ? Color.green.opacity(0.6)
                                                        : option == selectedOption
                                                        ? Color.red.opacity(0.8)
                                                        : Color.gray.opacity(0.2))
                                                    : Color.white
                                            )
                                            .foregroundColor(.black)
                                            .cornerRadius(8)
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.7)
                                            .lineLimit(nil)
                                    }
                                    .disabled(showAnswer)
                                }
                            }
                        }
                        .padding()
                    }

                    // Önceki / Sonraki Soru Navigasyonu
                    HStack {
                        Button(action: {
                            if currentQuestionIndex > 0 {
                                currentQuestionIndex -= 1
                                showAnswer = false
                                selectedOption = nil
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .disabled(currentQuestionIndex == 0)

                        Text("\(currentQuestionIndex + 1)/\(questions.count)")
                            .font(.title3)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)

                        Button(action: {
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                                showAnswer = false
                                selectedOption = nil
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .disabled(currentQuestionIndex == questions.count - 1)
                    }
                }
                .padding()

                // Konfeti Efekti
                ConfettiCannon(counter: $showConfetti, num: 50, radius: 300)

                // Navigation Link for TaskView
                NavigationLink(destination: TaskView(), isActive: $navigateToTaskView) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showDialog) {
                Alert(
                    title: Text("Tebrikler!"),
                    message: Text("Bir rozet kazandın🥳. Görmek için tıkla!🤩"),
                    dismissButton: .default(Text("Tamam"), action: {
                        navigateToTaskView = true
                    })
                )
            }
        }
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView()
    }
}
