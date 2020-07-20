//
//  MapService.swift
//  OnTheMap
//
//  Created by Renan Maganha on 22/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import Foundation
import MapKit

protocol MapService {
    //MARK: - Properties
    //Defines wich of the app scenes will be displayed to the user
    var currentScene: AppScenes { get }
    var alertMessage: String { get }
    var showAlert: Bool { get }
    
    //Stores the user session informations
    var registered: Bool? { get }
    var key: String? { get }
    var id: String? { get }
    var expiration: String? { get }

    //Stores account information
    var firstName: String { get }
    var lastName: String { get }
    var nickname: String { get }
    
    var isAlreadyPosted: Bool { get }
    var objectId: String { get }
    
    //MARK: - Functions
    
    //General app methods
    func dismissAlert()
    
    //Map service methods
    func fetchStudentLocation() -> [StudentLocation]
    func searchForLocationByUniqueKey()
    
    //Session methods
    func handlePostSession(username: String, password: String)
    func handleDeleteSession()
    
    //Map methods
    func handlePostStudentLocation(mapString: String, latitude: CLLocationDegrees, Longitude: CLLocationDegrees, mediaURL: String)
    func handlePutStudentLocation(mapString: String, latitude: CLLocationDegrees, Longitude: CLLocationDegrees, mediaURL: String)
}
