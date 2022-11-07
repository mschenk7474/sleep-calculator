//
//  CalculatedView.swift
//  Sleep Calculator
//
//  Created by Mason Schenk on 11/1/22.
//

import Foundation
import SwiftUI

struct CalculatedView: View {
 // variables brought over from other view
    @Binding var hours: String
    @Binding var mins: String
    @Binding var timeperiod: String
    @Binding var totalTime: String
    @Binding var cycles: [(String)]
    
    func cyclecal(time: String) -> [(String)]{
     /* calculates all of the cycle times and 
     returns it to display to the user*/
        var intHours = Int(self.hours) ?? 0
        let intMins = Int(self.mins) ?? 0
        var cycleList = [String]()
        var cyclesConList = [String]()
        
        // covers extra hours if it is pm
        if (self.timeperiod == "P.M."){
            if (intHours != 12){
                intHours += 12
            }
        }
        
        // gets all the time in minutes
        let hoursConvert = intHours * 60
        let tTime = hoursConvert + intMins
        
        
        /* want to add 90 7 times*/
        cycleList = doCycles(tTime: tTime)
        
        /* Convert cycle times back into normal times*/
        cyclesConList = convertCycles(cycleList: cycleList)
        
        /* Return cycles list to be outputted to the user*/
        return cyclesConList
        
    }
    
    func doCycles(tTime: Int) -> [(String)]{
        /* Do a loop and do all the math for 7 90 cycles and add to a list to be returned*/
        var cyclesDone = [String]()
        var time = tTime
        for _ in 1...7{
            time += 90
            // add if greater than 1439, subtract that from the time
            if (time > 1439){
                time -= 1440
            }
            cyclesDone.append(String(time))
        }
        return cyclesDone
    }
    
    func convertCycles(cycleList:[(String)]) -> [(String)]{
        /* Convert each minute time from cycleList to a normal time
            Bounds:
                - From 11:59 A.M. - 12:00 P.M = 719 - 720
                - From 11:59 P.M. - 12:00 A.M = 1439 - 0
         */
        var cyclesConverted = [String]()
        var count = 0
        for cycle in cycleList{
            // check to see if it is A.M or P.M.
            if (Int(cycle) ?? 0 < 720){
                self.timeperiod = "A.M."
            }
            else if (Int(cycle) ?? 0 > 720){
                self.timeperiod = "P.M."
            }
            self.hours = String((Int(cycle) ?? 0) / 60)
            self.mins = String((Int(cycle) ?? 0) - ((Int(self.hours) ?? 0) * 60))
            var hours = Int(self.hours)
            // hour check, if greater than 12 and less than 24, minus 12 off hours
            if (Int(self.hours) ?? 0 > 12 && Int(self.hours) ?? 0 < 24){
                hours! -= 12
                
            }
            self.hours = String(hours ?? 0)
            
            // if mins = 0, add another 0
            if (self.mins == "0"){
                self.mins = "00"
            }
            
            // needed to add 0 for every single digit
            else if (self.mins == "1"){
                self.mins = "01"
            }
            
            else if (self.mins == "2"){
                self.mins = "02"
            }
            
            else if (self.mins == "3"){
                self.mins = "03"
            }
            
            else if (self.mins == "4"){
                self.mins = "04"
            }
            
            else if (self.mins == "5"){
                self.mins = "05"
            }
            
            else if (self.mins == "6"){
                self.mins = "06"
            }
            
            else if (self.mins == "7"){
                self.mins = "07"
            }
            
            else if (self.mins == "8"){
                self.mins = "08"
            }
            
            else if (self.mins == "9"){
                self.mins = "09"
            }
            
            // gives the 12 back in the am situation
            if (Int(cycle) ?? 0 < 60){
                self.hours = "12"
            }
            
            
            // gets the cycle count on there as well
            count += 1
            let time = String(count) + ". " + self.hours + ":" + self.mins + " " + self.timeperiod
            cyclesConverted.append(time)
        }
        return cyclesConverted
    }
    var body: some View {
        VStack{
            // gets the time from the user in the format we need to pass it to cyclecal
            let time = self.hours + ":" + self.mins + " " + self.timeperiod
            Text("Welcome to the Calculations page!").fontWeight(.bold)
            
            Text("These times below are based on 90 minute REM cycles, which is when your body is in deep sleep. We want to wake up in between these cycles, so we get the best quality of sleep possible.").font(.system(size: 15))
            Text(" ")
            
            Text("The recommeneded hours of sleep differ for each age group, but with most ages, you are going to want to be looking to get between 7-9 hours of sleep a night. For that 7-9 hour range, you will want to look at cycles 5 and 6 on the list below. However, you may need to adjust what cycle you choose for your own situation").font(.system(size: 15))
            Text(" ")
            
            Text("Also, give yourself 15 minutes before you go to bed to make sure you are in bed at the time inputted on the screen previous, as it takes most people anywhere from 5-15 minutes to fall asleep on any given night.").font(.system(size: 15))
            
            Button(action:{
                self.cycles = cyclecal(time: time)
            },  label: {
                Text("Calculate Results")
            })
            
            
            
            /* Make a for each loop to display each time*/
            List(self.cycles, id: \.self) { cycle in
                Text(cycle.description)

            }
        }
    }
}
