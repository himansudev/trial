//
//  Http Requests.swift
//  MapModuleFinal
//
//  Created by VIDUSHI DUHAN on 06/02/20.
//  Copyright © 2020 Osos Private Limited. All rights reserved.
//

import UIKit

extension JsonTestViewController {
    
    typealias Parameters = [String : Any]
    
    func SubmitButtonHttpRequest()
    {
        
        //Have to include "username" and "profilepic" under "uservisibility" in the future
        
        let parameters = ["featureName": "Feature3", "content": "Hi I am textView",  //content:textview.text
                          
                          "uservisibility[chat]": true,
                          "uservisibility[gender]": false,
                          "uservisibility[location]": false,
                          
                          "options[0][id]" : "0",
                          "options[0][title]" : "Lonely/Isolated Place",  // [UserVisibility].self
                          "options[0][visible]" : true,
        
                          "options[1][id]" : "1",
                          "options[1][title]" : "Unsafe crowd",
                          "options[1][visible]" : false,
        
                          "options[2][id]" : "2",
                          "options[2][title]" : "Unmanaged traffic",
                          "options[2][visible]" : false,
        
                          "options[3][id]" : "3",
                          "options[3][title]" : "Animal Attack",
                          "options[3][visible]" : false,
            
                          "options[4][id]" : "4",
                          "options[4][title]" : "Eve-teasing",
                          "options[4][visible]" : false,
            
                          "options[5][id]" : "5",
                          "options[5][title]" : "Others",
                          "options[5][visible]" : false,

                          "actions[0][id]" : "0",
                          "actions[0][title]" : "Siren",
                          "actions[0][visible]" : false,

                          "actions[1][id]" : "1",
                          "actions[1][title]" : "Red Alert",
                          "actions[1][visible]" : true,

                          "actions[2][id]" : "2",
                          "actions[2][title]" : "Alert Around",
                          "actions[2][visible]" : false,

                          "actions[3][id]" : "3",
                          "actions[3][title]" : "SMS Family",
                          "actions[3][visible]" : true,

                          "id" : "5e26ea82dcef130017295cd9",

                          "locationStatic[coordinates][0]" : 72.123,
                          "locationStatic[coordinates][1]" : 17.123,
                          "locationStatic[type]" : "Point"
        ] as [String : Any]
        
        guard let collectionViewMedia = Media(withImage: #imageLiteral(resourceName: "userImage1"), forKey: "photo") else { return }
        
        guard let url = URL(string: "https://osos-testing.herokuapp.com/api/post") else { return } // https://osos-testing.herokuapp.com/api/post     http://mcroons.com/api/post
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let dataBody = createDataBody(withParameters: parameters, media: [collectionViewMedia], boundary: boundary) //createDataBodyParameters(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: Parameters?, media : [Media]?, boundary : String ) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value)\r\n")
            }
        }
        
        if let media = media {
            for pic in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(pic.key)\"; filename =\"\(pic.filename)\"\(lineBreak)")
                body.append("Content-type: \(pic.mimetype + lineBreak + lineBreak)")
                body.append(pic.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}

extension Data {
    mutating func append(_ string : String) {   // mutating because data will always be changing
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

