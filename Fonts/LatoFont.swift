//
//  LatoFont.swift
//  iPark
//
//  Created by King on 2019/11/15.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

public struct LatoFont: FontType {
    
    /// Size of font.
    public static var pointSize: CGFloat {
        return Font.pointSize
    }

    /// Thin font.
    public static var thin: UIFont {
        return thin(with: Font.pointSize)
    }

    /// Light font.
    public static var light: UIFont {
        return light(with: Font.pointSize)
    }

    /// Regular font.
    public static var regular: UIFont {
        return regular(with: Font.pointSize)
    }

    /// Medium font.
    public static var medium: UIFont {
        return medium(with: Font.pointSize)
    }

    /// Bold font.
    public static var bold: UIFont {
        return bold(with: Font.pointSize)
    }
    
    /// Black font.
    public static var black: UIFont {
        return black(with: Font.pointSize)
    }

    /**
    Thin with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func thin(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Thin", size: size) {
            return f
        }

        return Font.systemFont(ofSize: size)
    }

    /**
    Light with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func light(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Light", size: size) {
            return f
        }

        return Font.systemFont(ofSize: size)
    }

    /**
    Regular with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func regular(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Regular", size: size) {
            return f
        }

        return Font.systemFont(ofSize: size)
    }

    /**
    Medium with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func medium(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Medium", size: size) {
            return f
        }

        return Font.boldSystemFont(ofSize: size)
    }

    /**
    Bold with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func bold(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Bold", size: size) {
            return f
        }

        return Font.boldSystemFont(ofSize: size)
    }
    
    /**
    Black with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    public static func black(with size: CGFloat) -> UIFont {
        if let f = UIFont(name: "Lato-Black", size: size) {
            return f
        }

        return Font.boldSystemFont(ofSize: size)
    }
    
}

