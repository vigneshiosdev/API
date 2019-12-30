//
//  ViewController.swift
//  API
//
//  Created by Jeyakumar on 30/12/19.
//  Copyright © 2019 PG Softwares. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func API(){
        
        var parameters = [String: Any]()
        
        parameters["email"] = "self.txtEmailForgotPass.text"
        
        ViewController.callPost(url: URL.init(string: "mail.php")!, params: parameters) { (message, data) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print(json)
                
                DispatchQueue.main.async {
                    
                }
                
            } catch let error as NSError {
                print(error)
            }
            
        }
        
    }
    
    static func getPostString(params:[String:Any]) -> String{
        
        var data = [String]()
        
        for(key, value) in params
            
        {
            
            data.append(key + "=\(value)")
            
        }
        
        return data.map { String($0) }.joined(separator: "&")
        
    }
    static func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void) {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let postString = self.getPostString(params: params)
        
        request.httpBody = postString.data(using: .utf8)
        
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if(error != nil)
                
            {
                
                result.message = "Fail Error not null : \(error.debugDescription)"
                
            }
            else
                
            {
                result.message = "Success"
                
                result.data = data
                
            }
            
            
            finish(result)
            
        }
        
        task.resume()
        
    }
    
    
}


