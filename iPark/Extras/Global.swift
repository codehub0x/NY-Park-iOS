//
//  Global.swift
//  iPark
//
//  Created by King on 2019/11/19.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import MapKit
import MaterialComponents.MaterialContainerScheme

struct Global {
    static var isLoggedIn = false
    static var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.71, longitude: -74.01)
    static var defaultRegionRadius: CLLocationDistance = 10000
    static var searchRegionRadius: CLLocationDistance = 100000
    
    static func outlinedYellowButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iYellow
        scheme.typographyScheme.button = LatoFont.bold(with: 17)
        
        return scheme
    }
    
    static func defaultButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iYellow
        scheme.colorScheme.onPrimaryColor = .iDarkBlue
        scheme.typographyScheme.button = LatoFont.black(with: 18)
        
        return scheme
    }
    
    static func secondaryButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iDarkBlue
        scheme.colorScheme.onPrimaryColor = .white
        scheme.typographyScheme.button = LatoFont.black(with: 18)
        
        return scheme
    }
    
    static func outlinedButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iBlack90
        scheme.typographyScheme.button = LatoFont.bold(with: 17)
        
        return scheme
    }
    
    static func mediumButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iYellow
        scheme.colorScheme.onPrimaryColor = .iDarkBlue
        scheme.typographyScheme.button = LatoFont.medium(with: 14)
        
        return scheme
    }
    
    static func smallOutlinedButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iDarkBlue
        scheme.typographyScheme.button = LatoFont.regular(with: 12)
        
        return scheme
    }
    
    static func tinyButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iYellow
        scheme.colorScheme.onPrimaryColor = .iDarkBlue
        scheme.typographyScheme.button = LatoFont.bold(with: 9)
        
        return scheme
    }
    
    static func tinySecondaryButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iDarkBlue
        scheme.colorScheme.onPrimaryColor = .white
        scheme.typographyScheme.button = LatoFont.bold(with: 9)
        
        return scheme
    }
    
    static func tinyOutlinedButtonScheme() -> MDCContainerScheme {
        let scheme = MDCContainerScheme()
        scheme.colorScheme.primaryColor = .iBlack90
        scheme.typographyScheme.button = LatoFont.bold(with: 9)
        
        return scheme
    }
}
