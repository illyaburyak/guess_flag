//
//  ContentView.swift
//  GuessFlag
//
//  Created by Illya  on 9/18/21.
//

import SwiftUI

struct ContentView: View {
   
   @State private var countries = ["ARG", "BANG", "BRAZ", "CAN", "GER", "GREC", "RUS", "SWED", "UK", "USA"].shuffled()
   
   @State private var correctAnswer = Int.random(in: 0...2)
   @State private var score = 0
   @State private var showingScore = false
   @State private var scoreTitle = ""
   
   var body: some View {
      ZStack {
         LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
         VStack(spacing: 30) {
            VStack {
               Text("Chose Flag")
                  .foregroundColor(.white)
                  .font(.headline)
               Text("\(countries[correctAnswer])")
                  .foregroundColor(.white)
                  .font(.largeTitle)
                  .fontWeight(.black)
            }
            ForEach(0..<3) {number in
               Button(action: {
                  self.flagTapped(number)
                  self.showingScore = true
               }) {
                  Image(self.countries[number])
                     .renderingMode(.original)
                     .frame(width: 250, height: 125)
                     .clipShape(Capsule())
                     .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                     .shadow(color: .black, radius: 2)
               }
            }
            Text("Score: \(score)")
               .font(.largeTitle)
               .fontWeight(.black)
            Spacer()
         }
      } .alert(isPresented: $showingScore) {
         Alert(title: Text(scoreTitle), message: Text("Score: \(score)"), dismissButton: .default(Text("Continue")) {
            self.askQuestion()
         })
      }
   }
   func askQuestion() {
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
   }
   
   func flagTapped(_ number: Int) {
      if number == correctAnswer {
         scoreTitle = "Correct answer!!😀"
         score += 1
      } else {
         scoreTitle = "Incorrect! The right answer is: \(countries[number])"
         score -= 1
      }
   }
}











struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView()
   }
}
