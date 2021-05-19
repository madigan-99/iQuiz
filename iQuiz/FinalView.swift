//
//  FinalView.swift
//  iQuiz
//
//  Created by stlp on 5/13/21.
//

import Foundation
import SwiftUI


struct Final: View {
    @State var numRight: Int
    @State var total: Int
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Text("Quiz is over!")
                Spacer()
            }
            HStack {
                Spacer()
                Text("You got: ")
                Text(String(numRight))
                Text("/")
                Text(String(total))
                Spacer()
                
            }
            if (Double(Int(numRight) / Int(total)) > 0.7  && Double(Int(numRight) / Int(total)) < 1) {
                Text("Almost!")
            }
            if (Double(Int(numRight) / Int(total)) == 1) {
                Text("Perfect!")
            }
            if (Double(Int(numRight) / Int(total)) < 0.7  ) {
                Text("Next Time!")
            }
        }
    }
}

