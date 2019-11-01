//
//  ContentView.swift
//  Edutainment
//
//  Created by Saif on 01/11/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var practiceTableFor = 1
    @State private var selectedCountOfQuestions = 0
    @State private var questionsCount = ["5","10","20","All"]
    @State private var numberOfQuestions = 5
    @State private var startTheGame = false
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                Section(header:Text("Table").fontWeight(.heavy)) {
                        Stepper("Practice the table of:   \(practiceTableFor)", value: $practiceTableFor, in: 1...12)
                    }
                    Section(header:Text("Number of Questions?").fontWeight(.heavy)) {
                        Picker(selection: $selectedCountOfQuestions, label: Text("")) {
                            ForEach(0 ..< self.questionsCount.count) { index in
                                Text("\(self.questionsCount[index])").tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                Button(action: {
                    self.calculateNumberOfQuestions()
                    print(self.numberOfQuestions)
                    self.startTheGame = true
                }) {
                    Text("Let's Go")
                        .padding(.all, 12)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $startTheGame) {
                    GameView(numberOfQuestionsToBeAsked: self.$numberOfQuestions, practiceForTable: self.practiceTableFor)
                }
                Spacer()
            }
        .padding()
            .navigationBarTitle(Text("Edutainment"))
        }
    }
    
    func calculateNumberOfQuestions() {
        switch selectedCountOfQuestions {
        case 0 :
            numberOfQuestions = Int(self.questionsCount[0]) ?? 5
        case 1 :
            numberOfQuestions = Int(self.questionsCount[1]) ?? 5
        case 2 :
            numberOfQuestions = Int(self.questionsCount[2]) ?? 5
        case 3 :
            numberOfQuestions = 100
        default:
            numberOfQuestions = 5
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
