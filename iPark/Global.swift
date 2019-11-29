//
//  Global.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import MapKit

struct Global {
    static var isLoggedIn = false
    static var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.71, longitude: -74.01)
    static var defaultRegionRadius: CLLocationDistance = 10000
    static var searchRegionRadius: CLLocationDistance = 100000
}
