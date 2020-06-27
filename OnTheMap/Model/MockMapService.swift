//
//  MockMapService.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import SwiftUI

class MockMapService: MapService {
    var currentScene: AppScenes = .login

    //Executes the get task and return the results of JSON data
    func getStudentLocation(completion: @escaping (StudentResults?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }

            let decoder = JSONDecoder()

            do {
                let objectResponse = try decoder.decode(StudentResults.self, from: data)
                completion(objectResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    //Fetch the results, saves it to an array an return to the variable that store the students location
    func fetchStudentLocation() -> [StudentLocation] {
        var studentLocation = [StudentLocation]()
        let task = DispatchGroup()

        task.enter()
        getStudentLocation { (response, error) in
            if let response = response {
                studentLocation = response.results
                task.leave()
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()

        return studentLocation
    }
    
    //Change the current scene of the application
    func changeScene(scene: AppScenes) {
        currentScene = scene
    }
    
    
    
    
    
    
    
    
    var registered: Bool? = false
    var key: String? = ""
    var id: String? = ""
    var expiration: String? = ""
    
    func postSession(username: String, password: String, completion: @escaping (PostSessionResponse?, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.postSession.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = PostSession(udacity: PostSession.Udacity(username: username, password: password))
        request.httpBody = try! JSONEncoder().encode(body)
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range)
                print(String(data: newData, encoding: .utf8)!)
                let responseObject = try decoder.decode(PostSessionResponse.self, from: newData)
                
                self.registered = responseObject.account.registered
                self.key        = responseObject.account.key
                self.id         = responseObject.session.id
                self.expiration = responseObject.session.expiration

                completion(responseObject, nil)
                
            } catch {

                completion(nil, error)
                
                //{"status":403,"error":"Account not found or invalid credentials."}
                //{"status":400,"error":"Did not specify exactly one credential."}
            }
        }
        
        task.resume()
    }
    
    func handlePostSession(username: String, password: String) {
        let task = DispatchGroup()
        task.enter()
        postSession(username: username, password: password) { (response, error) in
            if response != nil {
                self.currentScene = .mapService
                task.leave()
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()
    }
    
    func deleteSession() {
        var request = URLRequest(url: Endpoints.postSession.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range)
                let objectResponse = try decoder.decode(DeleteSessionResponse.self, from: newData)
                self.currentScene = .login
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
