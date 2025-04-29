//
//  NotificationCentre.swift
//  ToDoApp
//
//  Created by Sushant Dhakal on 2025-04-29.
//

import Foundation
import UserNotifications

class NotificationCentre: ObservableObject {
    
    static let shared = NotificationCentre()

    
    //Request for Authorization
    func notificationAuthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success{
                print("Notification Authorized")
            }else{
                print("Notification not Authorized")
            }
        }
    }
    
    
    //Schedule Notification
    func scheduleNotification(taskTitle: String,taskDate: Date){
        let content = UNMutableNotificationContent()
        content.title = "ToDo App"
        content.body = "You have a task to complete"
        content.sound = .default
        content.badge = 1
        
        //holds the date before actual task
        guard let notifyDate = Calendar.current.date(byAdding: .day, value : -1 , to: taskDate) else {return}
        
        //convert notifyDate into dateComponents objects, need to trigger UNCalendarNotificationTrigger
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notifyDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        
    }
}
