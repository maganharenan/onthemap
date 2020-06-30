//
//  InformationPostingView.swift
//  OnTheMap
//
//  Created by Renan Maganha on 24/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import MapKit

struct InformationPostingView: View {
    @State var location = ""
    @State var link = ""
    @State var newAnnotation: [StudentLocation] = []
    @State var confirm = false
    
    var body: some View {
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
                    self.test(addressString: self.location) { (response, error) in
                        if let response = response {
                            self.newAnnotation.append(StudentLocation(firstName: "Renan", lastName: "Maganha", longitude: response.longitude, latitude: response.latitude, mapString: "", mediaURL: "", uniqueKey: "12345", objectId: "12345", createdAt: "12345", updatedAt: "123456"))
                            
                            self.confirm.toggle()
                        } else {
                            print("Buuuhhhhhh")
                        }
                        
                    }
                }, label: {
                    Text("FIND LOCATION")
                        .modifier(LoginButtonModifier())
                })
                    .padding(.top, 25)
                    
                NavigationLink(destination: AddLocationView(annotationsSource: $newAnnotation), isActive: $confirm) {
                    EmptyView()
                }
                Spacer()
                
            }
            .navigationBarTitle("Add Location", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    
                }, label: {
                    Text("CANCEL")
                })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func test(addressString: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    print("\(location.coordinate)")
                    completion(location.coordinate, nil)
                    return
                }
            }
            completion(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

struct InformationPostingView_Previews: PreviewProvider {
    static var previews: some View {
        InformationPostingView()
    }
}

struct AddLocationView: View {
    @Binding var annotationsSource: [StudentLocation]
    
    var body: some View {
        MapView(annotationsSource: .constant(annotationsSource), newAnnotation: true)
    }
}
