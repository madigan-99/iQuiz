//
//  ContentView.swift
//  iQuiz
//
//  Created by stlp on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    @State var settings: Bool = false
    @State var fetch = [Quiz]()
    @State var dataURL = "https://tednewardsandbox.site44.com/questions.json"
    @State var isInvalid: Bool = false
    
    var body: some View {
        
        GeometryReader { metrics in
            
            NavigationView {
                
                List (fetch) { quiz in
                    
                    HStack {
                        
                        NavigationLink(destination: Questions(numRight: 0, counter: 0, quiz: quiz, current: quiz.questions[0])) {
                            Image(quiz.photoURL).resizable().scaledToFit()
                            VStack {
                                Text(quiz.title).font(.title3).fontWeight(.heavy)
                                Text(quiz.desc)
                                
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
                }.popover(isPresented: $settings) {
                    VStack {
                        Spacer()
                        Text("Enter the URL of the Data Source Below:")
                        TextField("What's the URL?", text: $dataURL).frame(width: metrics.size.width * 0.9, height: metrics.size.height * 0.1).border(Color.black).padding(2)
                        Spacer()
                        
                        
                        
                        Button("Check Now") {
                            self.loadData()
                            settings = false
                        }
                    }
                }
            }.onAppear(perform: firstLoad).onAppear(perform: loadData).alert(isPresented: $isInvalid, content: {Alert(title: Text("Error Fetching Data"), message: Text("Data is invalid or you're offline, please try again!"), dismissButton: .default(Text("OK")))})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// https://www.hackingwithswift.com/forums/swiftui/decoding-json-data/3024
// https://www.ioscreator.com/tutorials/swiftui-json-list-tutorial
// https://www.kaleidosblog.com/swiftui-how-to-download-and-parse-json-data-and-display-in-a-list-using-the-swift-ui-previewprovider
//https://www.hackingwithswift.com/forums/swiftui/decoding-json-data/3024
extension ContentView {
    func loadData() {
        guard let url = URL(string: dataURL) else {
            print("error!")
            self.isInvalid = true
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let quizData = data {
                    let decodedData = try JSONDecoder().decode([Quiz].self, from: quizData)
                    DispatchQueue.main.async {
                        self.fetch = decodedData
                        self.isInvalid = false
                    }
                } else {
                    self.isInvalid = true
                }
                
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }.resume()
    }
    func firstLoad(){
        self.fetch = [
            Quiz(title: "Science!", desc: "Because SCIENCE!",
                 questions:
                    [QContent(text:"What is fire?", answer: "1",
                              answers: [ "One of the four classical elements",
                                         "A magical reaction given to us by God",
                                         "A band that hasn't yet been discovered",
                                         "Fire! Fire! Fire! heh-heh"])], photoURL: "science"),
            Quiz(title: "Marvel Super Heroes", desc: "Avengers, Assemble!",
                 questions: [QContent(text: "Who is Iron Man?", answer: "1", answers: ["Tony Stark",
                                                                                       "Obadiah Stane",
                                                                                       "A rock hit by Megadeth",
                                                                                       "Nobody knows"]),
                             QContent(text: "Who founded the X-Men?", answer: "2", answers: [ "Tony Stark",
                                                                                              "Professor X",
                                                                                              "The X-Institute",
                                                                                              "Erik Lensherr"]),
                             QContent(text: "How did Spider-Man get his powers?", answer: "1", answers: ["He was bitten by a radioactive spider",
                                                                                                         "He ate a radioactive spider",
                                                                                                         "He is a radioactive spider",
                                                                                                         "He looked at a radioactive spider"])], photoURL: "supers"),
            Quiz(title: "Mathematics", desc: "Did you pass the third grade?", questions: [QContent(text: "What is 2+2?", answer: "1", answers: ["4",
                                                                                                                                                "22",
                                                                                                                                                "An irrational number",
                                                                                                                                                "Nobody knows"])], photoURL: "math")]
    }
}

struct Quiz: Identifiable, Decodable  {
    var id: String { title }
    var title: String
    var desc: String
    var questions: [QContent]
    var photoURL: String = "trivia"
    private enum CodingKeys: String, CodingKey {
        case title, desc, questions
    }
    
}

struct QContent: Identifiable, Decodable {
    var id: String { text }
    var text: String
    var answer: String
    var answers: [String]
}



