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
                    
                        ForEach(model.quizzes, id:\.self){ subject in
                            
                            HStack {
                                Image(subject.photoURL).resizable().scaledToFit()
                                VStack {
                                    Text(subject.name).font(.title3).fontWeight(.heavy)
                                    Text(subject.desc)

                                }
                            }
                        
                    }
                }                    .navigationTitle("iQuiz")
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



class Subject: NSObject {
    var name: String
    var photoURL: String
    var desc: String
    init(name: String, photoURL: String, desc: String) {
        self.name = name
        self.photoURL = photoURL
        self.desc = desc
    }
}

class Model: ObservableObject {
    @Published var quizzes: [Subject] = []
    init() {
        quizzes = [
            Subject(name: "Mathematics", photoURL: "math", desc: "Take a quiz to test your mathematics knowledge!"),
            Subject(name: "Marvel Super Heroes", photoURL: "supers", desc: "Take a quiz to test your super heroe knowledge!"),
            Subject(name: "Science", photoURL: "science", desc: "Take a quiz to test your science knowledge!")
        ]
    }
}
