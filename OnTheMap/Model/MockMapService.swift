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
    //MARK: - Properties
    //Defines wich of the app scenes will be displayed to the user
    var currentScene: AppScenes = .login
    var alertMessage: String = ""
    var showAlert: Bool = false
    
    //Stores the user session informations
    var registered: Bool? = false
    var key: String? = ""
    var id: String? = ""
    var expiration: String? = ""
    
    //MARK: - Task Methods
    ///Get task
    @discardableResult func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, fromNewData: Bool, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range)
                let responseObject = try decoder.decode(ResponseType.self, from: fromNewData ? newData : data)
                completion(responseObject, nil)
            } catch {
                
            }
        }
        task.resume()
        
        return task
    }
    
    ///Post task
    func taskForPostRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, fromNewData: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: fromNewData ? newData : data)
                completion(responseObject, nil)
            } catch {
                do {
                    let errorResponse = try decoder.decode(UdacityAPIResponse.self, from: fromNewData ? newData : data) as Error
                    completion(nil, errorResponse)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    //MARK: - Map Services Methods
    ///Fetch the students locations and return the results to an array
    func fetchStudentLocation() -> [StudentLocation] {
        var results = [StudentLocation]()
        let task = DispatchGroup()
        task.enter()
        taskForGetRequest(url: Endpoints.getStudentLocation.url, responseType: StudentResults.self, fromNewData: false) { (response, error) in
            if let response = response {
                results = response.results
                task.leave()
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()
        print("Total of \(results.count) results")
        return results
    }
    
    func handlePostSession(username: String, password: String) {
        //Resets the value of showAlert
        self.showAlert = false
        
        let body = PostSession(udacity: PostSession.Udacity(username: username, password: password))
        let task = DispatchGroup()
        
        task.enter()
        taskForPostRequest(url: Endpoints.postSession.url, responseType: PostSessionResponse.self, body: body, fromNewData: true) { (response, error) in
            if let response = response {
                self.registered = response.account.registered
                self.key        = response.account.key
                self.id         = response.session.id
                self.expiration = response.session.expiration
                
                self.currentScene = .mapService
                task.leave()
            } else {
                //Pass the error to the Alert message and toggles the alert
                self.alertMessage = "\(error?.localizedDescription ?? "")"
                self.showAlert = true
                task.leave()
            }
        }
        task.wait()
    }
    
    func deleteSession(completion: @escaping (DeleteSessionResponse?, Error?) -> Void) {
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
                completion(objectResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func handleDeleteSession() {
        let task = DispatchGroup()
        task.enter()
        deleteSession { (response, error) in
            if let response = response {
                self.id = response.session.id
                self.expiration = response.session.expiration
                self.currentScene = .login
                task.leave()
            } else {
                print(error!)
                task.leave()
            }
        }
        task.wait()
    }
    
    func dismissAlert() {
        self.showAlert = false
    }
}
