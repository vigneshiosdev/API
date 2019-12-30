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


//upload
/*
func APIStep1() {
    
    let myUrl = NSURL(string: "\(demourl)educator_register_s1.php")
    
    let request = NSMutableURLRequest(url:myUrl! as URL)
    request.httpMethod = "POST"
    
    let param = [
        "name"  : self.txtName.text!,
        "gender" : self.strGender,
        "marital_status" : self.txtMartialStatus.text!,
        "dob" : self.txtDOB.text!,
        "race" : self.strRace,
        "citizenship" : self.strCitizenship,
        "address" : self.txtAddress.text!,
        "postal_code" : self.txtPostalCode.text!,
        "mobile" : self.txtMobile.text!,
        "high_edu_level" : self.txtEducationalLevel.text!,
        "email" : self.txtEmail.text!,
        "password" : self.txtPassword.text!,
        "experience" : self.txtExperience.text!,
        "description" : self.txtViewDescription.text!
    ]
    let boundary = generateBoundaryString()
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    
    let imageData = self.selImage!.jpegData(compressionQuality: 0.1)
    
    if(imageData==nil)  { return; }
    
    request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "profile_img", imageDataKey: imageData! as NSData, boundary: boundary) as Data
    
    
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in
        
        if error != nil {
            return
        }
        
        // You can print out response object
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("****** response data = \(responseString!)")
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            
            print(json!)
            
            DispatchQueue.main.async {
                let statusT = json!["status"] as! String
                let messageT = json!["message"] as! String
                self.view.makeToast(messageT)
                if(statusT == "1"){
                    let id = json!["id"] as! Int
                    
                    UserDefaults.standard.set(id, forKey: "TempLoginID")
                    UserDefaults.standard.synchronize()
                    
                    self.appdelegate.stepCompleted = 1
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let next = storyBoard.instantiateViewController(withIdentifier: "Register2VC") as! Register2VC
                    self.present(next , animated: false, completion: nil)
                    
                }else{
                    self.view.makeToast(messageT)
                }
            }
        }catch
        {
            print(error)
        }
        
    }
    
    task.resume()
}

func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
    }
    let mimetype = "image/jpeg"
    body.appendString(string: "--\(boundary)\r\n")
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"file.jpeg\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string: "\r\n")
    body.appendString(string: "--\(boundary)--\r\n")
    return body
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

*/
