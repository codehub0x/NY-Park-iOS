//
//  Font.swift
//  iPark
//
//  Created by King on 2019/11/15.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

public protocol FontType {
    /**
    Regular with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    static func regular(with size: CGFloat) -> UIFont
  
    /**
    Medium with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    static func medium(with size: CGFloat) -> UIFont

    /**
    Bold with size font.
    - Parameter with size: A CGFLoat for the font size.
    - Returns: A UIFont.
    */
    static func bold(with size: CGFloat) -> UIFont
    
    /**
     Black with size font.
     - Parameter with size: A CGFLoat for the font size.
     - Returns: A UIFont.
     */
    static func black(with size: CGFloat) -> UIFont
    
    /**
     Light with size font.
     - Parameter with size: A CGFLoat for the font size.
     - Returns: A UIFont.
     */
    static func light(with size: CGFloat) -> UIFont
}

public struct Font {
    /// Size of font.
    public static let pointSize: CGFloat = 16

    /**
    Retrieves the system font with a specified size.
    - Parameter ofSize size: A CGFloat.
    */
    public static func systemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    /**
    Retrieves the bold system font with a specified size..
    - Parameter ofSize size: A CGFloat.
    */
    public static func boldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

    /**
    Retrieves the italic system font with a specified size.
    - Parameter ofSize size: A CGFloat.
    */
    public static func italicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size)
    }

    /**
    Loads a given font if needed.
    - Parameter name: A String font name.
    */
    public static func loadFontIfNeeded(name: String) {
        FontLoader.loadFontIfNeeded(name: name)
    }
}

/// Loads fonts packaged with Material.
private class FontLoader {
  /// A Dictionary of the fonts already loaded.
  static var loadedFonts: Dictionary<String, String> = Dictionary<String, String>()
  
  /**
   Loads a given font if needed.
   - Parameter fontName: A String font name.
   */
  static func loadFontIfNeeded(name: String) {
    let loadedFont: String? = FontLoader.loadedFonts[name]
    
    if nil == loadedFont && nil == UIFont(name: name, size: 1) {
      FontLoader.loadedFonts[name] = name
      
      let bundle = Bundle(for: FontLoader.self)
      let fontURL = bundle.url(forResource: name, withExtension: "ttf", subdirectory: "fonts")
      
      if let v = fontURL {
        let data = NSData(contentsOf: v as URL)!
        let provider = CGDataProvider(data: data)!
        let font = CGFont(provider)
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font!, &error) {
          let errorDescription = CFErrorCopyDescription(error!.takeUnretainedValue())
          let nsError = error!.takeUnretainedValue() as Any as! Error
          NSException(name: .internalInconsistencyException, reason: errorDescription as String?, userInfo: [NSUnderlyingErrorKey: nsError as Any]).raise()
        }
      }
    }
  }
}
