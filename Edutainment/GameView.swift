//
//  GameView.swift
//  Edutainment
//
//  Created by Saif on 01/11/19.
//  Copyright © 2019 LeftRightMind. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @Binding var numberOfQuestionsToBeAsked: Int
    var practiceForTable = 1
    @State private var multiplyBy = Int.random(in: 1...10)
    
    @State private var showingGameOverPopup = false
    
    @State private var userAnswer = "0"
    @State private var gameScore = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing:40) {
                HStack(spacing:40) {
                    VStack {
                        ForEach(1...practiceForTable,id:\.self) {
                            Image("\($0)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:50,height:50)
                        }
                    }
                    Image(systemName: "multiply")
                    VStack {
                        ForEach(1...multiplyBy,id:\.self) {
                            Image("\($0)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:50,height:50)
                        }
                    }
                    
                }
                HStack {
                    TextField("Your Answer: ",text:$userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.nextQuestion()
                    }) {
                        Text("Next Question")
                            .padding(.all, 12)
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(20)
            .alert(isPresented: $showingGameOverPopup) {
                Alert(title: Text("Game Over"), message: Text("Your score is \(gameScore)"), dismissButton: .default(Text("Ok")){
                    self.resetTheGame()
                    self.presentation.wrappedValue.dismiss()
                    })
            }
        .navigationBarTitle(Text("Start Playing..."))
        }
    }
    
    func resetTheGame() {
        showingGameOverPopup = false
        gameScore = 0
    }
    
    func nextQuestion() {
        
        if practiceForTable * multiplyBy == Int(userAnswer) {
            gameScore += 1
        }
        
        numberOfQuestionsToBeAsked -= 1
        if numberOfQuestionsToBeAsked > 0 {
            multiplyBy = Int.random(in: 1...10)
        }
        else{
            showingGameOverPopup = true
        }
    }
    
}




//Button("Done") {
//    self.presentation.wrappedValue.dismiss()
//}
