//
//  InformationPostingView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 24/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

struct InformationPostingView: View {
    var store: Store<AppState, AppAction>
    @Binding var showInformationPostingView: Bool
    @State var location = ""
    @State var link = ""
    @State var newAnnotation: [StudentLocation] = []
    @State var locationWasFound = false
    @State var showAlert = false
    @State var showOverwriteAlert = false
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Image("earth")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                        .padding(.top, 30)
                        .padding(.bottom, 70)
                        .foregroundColor(Color("GlobeColor"))
                    
                    TextField("Location", text: $location)
                        .frame(width: 300)
                    
                    Rectangle()
                        .frame(width: 300, height: 1.2)
                        .foregroundColor(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
                        .padding(.top, -10)
                    
                    TextField("Link", text: $link)
                        .frame(width: 300)
                    
                    Rectangle()
                        .frame(width: 300, height: 1.2)
                        .foregroundColor(Color(#colorLiteral(red: 0.3111993667, green: 0.6907969998, blue: 1, alpha: 1)))
                        .padding(.top, -10)
                    
                    Button(action: {
                        self.isAnimating = true
                        self.findLocation(addressString: self.location) { (response, error) in
                            if error != nil {
                                print(error!)
                            }
                            if let response = response {
                                self.newAnnotation.append(StudentLocation(firstName: self.store.state.firstName, lastName: self.store.state.lastName, longitude: response.longitude, latitude: response.latitude, mapString: self.location, mediaURL: self.link, uniqueKey: self.store.state.key, objectId: "", createdAt: "", updatedAt: ""))
                                self.isAnimating = false
                                self.locationWasFound.toggle()
                            } else {
                                self.isAnimating = false
                                self.showAlert.toggle()
                            }
                        }
                    }, label: {
                        Text("FIND LOCATION")
                            .modifier(LoginButtonModifier())
                    })
                        .padding(.top, 25)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("Location could not be found"), dismissButton: .default(Text("Ok")))
                    }
                    
                    NavigationLink(destination: AddLocationView(store: store, annotationSource: newAnnotation, showInformationPostingView: $showInformationPostingView), isActive: $locationWasFound) {
                        EmptyView()
                    }
                    Spacer()
                    
                }
                .navigationBarTitle("Add Location", displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.showInformationPostingView.toggle()
                    }, label: {
                        Text("CANCEL")
                    })
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                if self.store.state.isAlreadyPosted {
                    self.showOverwriteAlert.toggle()
                }
            }
            .alert(isPresented: $showOverwriteAlert) {
                Alert(title: Text("Atention"), message: Text("You have already posted a student location. Would you like to overwrite your current location?"), primaryButton: .default(Text("Overwrite"), action: {}), secondaryButton: .cancel(Text("Cancel"), action: {
                    self.showInformationPostingView.toggle()
                }))
            }
            
            if isAnimating {
                LoadingView()
            }
        }
    }
    
    func findLocation(addressString: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    print("\(location.coordinate)")
                    completion(location.coordinate, nil)
                    return
                }
                completion(kCLLocationCoordinate2DInvalid, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}

struct AddLocationView: View {
    var store: Store<AppState, AppAction>
    var annotationSource: [StudentLocation]
    @Binding var showInformationPostingView: Bool
    
    var body: some View {
        ZStack {
            MapView(annotationsSource: .constant(annotationSource), newAnnotation: true)
            
            Button(action: {
                self.handleWithPostedLocations()
            }, label: {
                Text("FINISH")
                    .modifier(LoginButtonModifier())
            })
                .padding(.bottom, 35)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    func handleWithPostedLocations() {
        if store.state.objectId != "" {
            print("updating")
            self.store.send(.parseAPIActions(.putStudentLocation(self.annotationSource[0].mapString, self.annotationSource[0].latitude, self.annotationSource[0].longitude, self.annotationSource[0].mediaURL)))
        } else {
            print("creating")
            self.store.send(.parseAPIActions(.postStudentLocation(self.annotationSource[0].mapString, self.annotationSource[0].latitude, self.annotationSource[0].longitude, self.annotationSource[0].mediaURL)))
        }
        self.showInformationPostingView.toggle()
    }
}
