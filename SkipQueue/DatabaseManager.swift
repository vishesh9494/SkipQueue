//
//  DatabaseManager.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 21/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class DatabaseManager : NSObject{
    public func GetRequest(url:String,postString:String)->URLRequest{
        var request=URLRequest(url: URL(string:url)!)
        request.httpMethod="POST"
        request.httpBody = postString.data(using: .utf8)
        return request
    }
    public func GeneratePostString(dict:NSDictionary)->String{
        var str:String!
        let keys = dict.allKeys
        let values = dict.allValues
        for var i in 0 ... dict.count-2{
            str.append("\(keys[i])=\(values[i])&")
        }
        str.append("\(keys[dict.count-1])=\(values[dict.count-1])")
        return str
    }
    public func CreateTask(request:URLRequest,postString:String)->NSArray{
        
        var pjson:NSArray!
        let queue = DispatchQueue.global(qos: .userInteractive)
        // submit a task to the queue for background execution
        queue.async{
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                do{
                    let json=try JSONSerialization.jsonObject(with: data, options: .allowFragments ) as! NSArray
                    pjson=json
                }
                catch{
                    
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                    print("statusCode should be 200 but is \(httpStatus.statusCode)")
                    print("response=\(response)")
                }
                let responseString = String(data: data,encoding: .utf8)
                print("responseString=\(responseString)")
            }
            task.resume()
        }
        return pjson
    }
}
