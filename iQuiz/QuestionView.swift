//
//  QuestionView.swift
//  iQuiz
//
//  Created by stlp on 5/13/21.
//

import Foundation
import SwiftUI


struct Questions: View {
    @State var numRight: Int
    @State var chosen: String = ""
    @State var counter: Int
    @State var quiz: Quiz
    @State var current: QContent
    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                VStack{
                    Text(current.question).font(.title)
                    Spacer()
                    VStack{
                        
                        ForEach(current.answers, id:\.self) {
                            answer in
                            Spacer()
                            HStack {
                                Button(action: {
                                    chosen = answer
                                }
                                ){
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5).fill(Color.init(red: 0.66, green: 0.66, blue: 0.99)).frame(width: metrics.size.width / 1.2, height: metrics.size.height / 8, alignment: .center).border(answer == chosen ? Color.black : Color.init(red: 0.66, green: 0.66, blue: 0.99))
                                        Text(answer).font(.title).foregroundColor(.black)
                                    }
                                }
                            }
                            Spacer()
                        }
                        HStack {
                            NavigationLink(destination: Answer(selection: chosen,IndivQuiz: quiz, counter: $counter, numRight: $numRight, current: current ).onAppear(perform: add)
                            ) {
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5).fill(Color.init(red: 0.66, green: 0.99, blue: 0.66)).frame(width: metrics.size.width / 1.2, height: metrics.size.height / 8, alignment: .center)
                                    
                                    Text("Submit").font(.title).foregroundColor(.black)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }.navigationBarHidden(true)
            }
            Spacer()
        }
        
    }
    func add() {
        counter = counter + 1
        if (chosen == quiz.quizContent[counter - 1].answer) {
            numRight = numRight + 1
        }
    }
}
