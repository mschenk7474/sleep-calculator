//
//  HomeView.swift
//  Sleep Calculator
//
//  Created by Mason Schenk on 11/1/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State var hours: String = ""
    @State var mins: String = ""
    @State var selection = 1
    @State var timeperiod: String = " "
    @State var totalTime: String = " "
    @State var cycles: [(String)] = [" "]
    func timecalc(selection: Int){
        if (selection == 2){
            self.timeperiod = "A.M."
        }
        
        else if (selection == 3){
            self.timeperiod = "P.M."
        }
        
    }
    var body: some View {
        NavigationView{
            VStack{
                VStack {
                    Image(systemName: "powersleep")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello,").fontWeight(.bold)
                    
                    Text("Welcome to the Sleep Calculator!").fontWeight(.bold)
                    
                    Text(" ")
                    
                    Text("Input a time you want to go to bed, and we will tell you what times would be the best to wake up at.")
                }
                .padding()
                HStack{
                    TextField(
                        "Hours", text: $hours
                    )
                    .keyboardType(.decimalPad)
                    TextField(
                        "Minutes", text: $mins
                    )
                    .keyboardType(.decimalPad)
                    VStack {
                        Picker(selection: $selection, label: Text("AM or PM")) {
                            Text(" ").tag(1)
                            Text("A.M.").tag(2)
                            Text("P.M.").tag(3)
                        }.onDisappear{
                            timecalc(selection: selection)
                        }
                    }
                }
                    .padding()
                NavigationLink(destination: CalculatedView(hours: $hours, mins: $mins, timeperiod: $timeperiod, totalTime: $totalTime, cycles: $cycles)){
                        Text("Submit Time")
                    }
                }
            }
        }
    }
