//
//  ContentView.swift
//  calorie tracker
//
//  Created by Sara Gaya on 5/31/23.
//

import SwiftUI
import Foundation
import ConfettiSwiftUI

struct ContentView: View {
    let calorieIntakeGoal: Int = 1200
    @State private var calorieInput: Int = 0
    @State var caloriePercentage: CGFloat = 0
    @State var totalCalories: Int = 0
    @State private var updateBar = false
    @State private var triggerConfetti = 0
    @State private var showErrorAlert = false
    
    var body: some View {
        
            VStack {
                Text("Total Calories: \(totalCalories)")
                    .font(.title)
                
                ProgressBar(progressPercent: $caloriePercentage)
                    .animation(.spring(), value: updateBar)
                    .confettiCannon(counter: $triggerConfetti, num: 60, rainHeight: 700, repetitions: 1)
                
               Divider()
                
                HStack(alignment: .center) {
                    Text("Enter Calories: ")
                    
                    GeometryReader { geometry in
                        //input text field
                        TextField("Enter calories consumed", value: $calorieInput, format: .number)
                            .onSubmit {
                                setTotalCalories()
                                setCaloriePercentage()
                                updateBar.toggle()
                            }
                            .textFieldStyle(.roundedBorder)
                            .alert(isPresented: $showErrorAlert) {
                                Alert(
                                    title: Text("Input Error"),
                                    message: Text("Total calorie intake can't be negative.")
                                )
                            }
                    }
                    .frame(width: 80, height: 30)
                }
                .padding()
  
            }
           // .frame(minHeight: 500)
    }
    
    //add a log that shows cals consumed vs. burned based on input for that day!
    
    func setTotalCalories() {
        //if total calories is > 0, send error message
        if ((calorieInput + totalCalories) < 0) {
            print("if statement entered")
            showErrorAlert = true
            return
        }
        totalCalories += calorieInput
        //triggers confetti cannon if cals are >= 1000 (min daily intake)
        checkConfettiTrigger(calories: totalCalories)
    }
    
    func setCaloriePercentage() {
        caloriePercentage = CGFloat(totalCalories) / CGFloat(calorieIntakeGoal)
    }
    
    func checkConfettiTrigger(calories: Int) {
        if (calories >= 1000) {
            triggerConfetti += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(caloriePercentage: 0.5)
    }
}
