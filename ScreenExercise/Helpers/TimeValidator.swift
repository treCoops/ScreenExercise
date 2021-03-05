//
//  TimeValidator.swift
//  ScreenExercise
//
//  Created by treCoops on 2021-02-13.
//

import Foundation

class TimeValidator {
    
    static var intvalTimeArray = [String]()
    static var endTimeArray = [String]()
    static var intervalSlots = [String]()
    
    static func getTimeDiff(time1Str: String, time2Str: String) -> Int{
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return 0 }


        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        
        return(Int(hour))
    }
    
    static func createdIntervals(diff: Int) -> [String]{
        
        var a : Int = 0
        intvalTimeArray.removeAll()
        
        if(diff == 1){
            
            while(a < 6){
                intvalTimeArray.append(DropdownArray.cmbInterval[a])
                a += 1
            }
            
            return intvalTimeArray
            
        } else if(diff > 1){
            
            if(diff > 6){
                
                while(a < 11 ){
                    self.intvalTimeArray.append(DropdownArray.cmbInterval[a])
                    a += 1
                }
                
                return intvalTimeArray
                
            } else if (diff <= 6){
                
                while(a < 6 + (diff - 1)){
                    self.intvalTimeArray.append(DropdownArray.cmbInterval[a])
                    a += 1
                }
                
                return intvalTimeArray
            }
            
        }
        
        return intvalTimeArray
    }
    
    
    static func getEndTimeArray(selectedText : String) -> [String]{
        
        endTimeArray.removeAll()
        
        if(DropdownArray.cmbTime.firstIndex(of: selectedText) == 0){
            for item in DropdownArray.cmbTime {
                if(item == selectedText){
                    continue
                }
                endTimeArray.append(item)
            }
            
            return endTimeArray
            
        }else{
            var a : Int = DropdownArray.cmbTime.firstIndex(of: selectedText)! + 1
            
            while(a <= 23){
                endTimeArray.append(DropdownArray.cmbTime[a])
                a += 1
            }
            
            let b : Int = DropdownArray.cmbTime.firstIndex(of: selectedText)!
            var c : Int = 0
            while(c < b){
                endTimeArray.append(DropdownArray.cmbTime[c])
               c += 1
            }
        }
        
        return endTimeArray
    }
    
    static func getTimeIntervaleSlots(startTime : String, endTime: String, interval: String) -> [String] {
        
        intervalSlots.removeAll()
        
        let splitted = interval.components(separatedBy: [" "]).filter({!$0.isEmpty})
        let IntSlots = Int(splitted[0])
        
        var mins : Int = IntSlots ?? 30
        
        if (IntSlots ?? 1 >= 1 && IntSlots ?? 1 <= 6 && mins != 5){
            mins = (IntSlots! * 60)
        }
        
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        let date1 = timeformatter.date(from: startTime)
        let date2 = timeformatter.date(from: endTime)
        
        var i = 1
        while true {
            let date = date1?.addingTimeInterval(TimeInterval(i*mins*60))
            let string = timeformatter.string(from: date!)

            if date! > date2! {
                break;
            }

            i += 1
            intervalSlots.append(string)
        }

        return intervalSlots
    }
}
