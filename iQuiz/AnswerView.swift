//
//  AnswerView.swift
//  iQuiz
//
//  Created by stlp on 5/13/21.
//

import Foundation
import SwiftUI



struct Answer: View {
    @State var selection: String
    @State var IndivQuiz: Quiz
    @Binding var counter: Int
    @Binding var numRight: Int
    @State var current: QContent
    var body: some View {
        GeometryReader { m in
            Spacer()
            VStack {
                Spacer()
            
                    Text("Question: " + current.text).font(.title)
                
                
                Text("Answer: " + current.answers[Int(current.answer)! - 1]).font(.title2)
                
                Text("Your Choice: " + selection).font(.title2)
                
                
                
                Text("Your answer is " + (((current.answers[Int(current.answer)! - 1]) == selection) ? " right!" : " incorrect :(")).font(.title2)
                
                Spacer()
                HStack {
                    Spacer()
                    if (counter < IndivQuiz.questions.count) {
                        NavigationLink(destination:  Questions( numRight: numRight, counter: counter, quiz: IndivQuiz, current: IndivQuiz.questions[counter]).navigationBarHidden(true)) {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.init(red: 0.66, green: 0.99, blue: 0.66)).frame(width: m.size.width / 1.2, height: m.size.height / 8, alignment: .center)
                                Text("Next").font(.title).foregroundColor(.black)
                            }
                            Spacer()
                            
                        }
                    }
                    else {
                        NavigationLink(destination: Final(numRight: numRight, total: IndivQuiz.questions.count).navigationBarHidden(true)) {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 5).fill(Color.init(red: 0.66, green: 0.99, blue: 0.66)).frame(width: m.size.width / 1.2, height: m.size.height / 8, alignment: .center)
                                Text("Finish").font(.title).foregroundColor(.black)
                            }
                        
                            
                        }
                    }
                    Spacer()
                }
               
             
            }.frame(width: m.size.width, height: m.size.height).navigationTitle("Back")
        }.navigationBarHidden(true).navigationBarBackButtonHidden(true).navigationTitle("Back")
    }
}

