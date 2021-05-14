//
//  ContentView.swift
//  iQuiz
//
//  Created by stlp on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = Model()
    @State var settings: Bool = false
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                List {
                    ForEach(model.quizzes, id:\.self){ quiz in
                        HStack {
                            NavigationLink(destination: Questions(numRight: 0, counter: 0, quiz: quiz, current: quiz.quizContent[0])) {
                                Image(quiz.photoURL).resizable().scaledToFit()
                                VStack {
                                    Text(quiz.name).font(.title3).fontWeight(.heavy)
                                    Text(quiz.desc)
                                }
                            }
                        }
                        
                    }
                }.navigationTitle("iQuiz")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Settings") {
                            self.settings.toggle()
                        }
                    }
                }.alert(isPresented: $settings, content: {Alert(title: Text("Settings"), message: Text("Settings go here"), dismissButton: .default(Text("OK")))})
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}


class Quiz: NSObject {
    var name: String
    var photoURL: String
    var desc: String
    var id: Int
    var quizContent: [QContent]
    init(name: String, photoURL: String, desc: String, id: Int, quizContent: [QContent]) {
        self.id = id
        self.name = name
        self.photoURL = photoURL
        self.desc = desc
        self.quizContent = quizContent
    }
}

class QContent: NSObject {
    var question: String
    var answers: [String]
    var answer: String
    init(question: String, answers: [String], answer: String) {
        self.question = question
        self.answer = answer
        self.answers = answers
    }
    
}

class Model: ObservableObject {
    @Published var quizzes: [Quiz] = []
    init() {
        quizzes = [
            Quiz(name: "Mathematics", photoURL: "math", desc: "Take a quiz to test your mathematics knowledge!", id: 1, quizContent: [QContent(question:"What is 2+2", answers: ["4","5","6","7"], answer: "4"), QContent(question:"What is 5+2", answers: ["4","5","6","7"], answer: "7"),QContent(question:"What is 2+3", answers: ["4","5","6","7"], answer: "5")]),
            Quiz(name: "Marvel Super Heroes", photoURL: "supers", desc: "Take a quiz to test your super heroe knowledge!", id: 2,quizContent: [QContent(question:"Who is Batmans sidekick?", answers: ["Robin", "Tom", "John", "Eric"], answer: "Robin"), QContent(question:"Who plays Deadpool?", answers: ["Steven Smith","Samuel Todd","Ryan Reynolds","Ryan Gosling"], answer: "Ryan Reynolds"),QContent(question:"How many Marvel movies are there", answers: ["50","23","54","23"], answer: "23")]),
            Quiz(name: "Science", photoURL: "science", desc: "Take a quiz to test your science knowledge!", id: 3,quizContent: [QContent(question:"What is the powerhouse of the cell", answers: ["Nitrogen", "Mitochondria", "Retina", "RMB"], answer: "Mitochondria"), QContent(question:"How many Law of Motion are there?", answers: ["2", "3", "4", "4"], answer: "3"),QContent(question:"What is gravity?", answers: ["-9.8m/s","-11m/s","9.8m/h","2m/s"], answer: "-9.8m/s")])
        ]
    }
}

