//
//  JsonTestViewController.swift
//  MapModuleFinal
//
//  Created by VIDUSHI DUHAN on 06/02/20.
//  Copyright © 2020 Osos Private Limited. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class JsonTestViewController: UIViewController, UNUserNotificationCenterDelegate{

    var center = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //var location = CLRegion()
//        center = UNUserNotificationCenter.current()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            
        })
        
        var content1 = UNMutableNotificationContent()
                content1.title = "Notification"
                content1.subtitle = "from Osos"
                content1.body = "Hello this is a notification"
                content1.sound = UNNotificationSound.default
                content1.badge = 1
                content1.categoryIdentifier = "My identifier"
                
        //        var imageName1 = "UserImage1"
        //        guard let imageUrl = Bundle.main.url(forResource: imageName1, withExtension: ".jpeg") else { return }
        //        var attatchment = try! UNNotificationAttachment(identifier: imageName1, url: imageUrl, options: .none)
        //        content1.attachments = [attatchment]
                
        //        let date = Date().addingTimeInterval(15)
        //        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                
                var trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 70, repeats: false)
                var identifier1 = "Main Identifier"
                var request1 = UNNotificationRequest(identifier: identifier1, content: content1, trigger: trigger1)
                
                UNUserNotificationCenter.current().add(request1, withCompletionHandler: { (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        print("Completed")
                    }
                })
        
    }
    
   
   
    @IBAction func submitFormTapped(_ sender: Any) {
        SubmitButtonHttpRequest()  //Multi-part Form Request, working perfectly
    }
    @IBAction func getNotificationTapped(_ sender: Any) {
//        func scheduleNotification(notificationType : String) {
//
//           }
        
    }
    
}
