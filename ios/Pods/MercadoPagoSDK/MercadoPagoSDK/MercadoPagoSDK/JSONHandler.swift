//
//  JSONHandler.swift
//  MPTracker
//
//  Created by Demian Tejo on 9/26/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//

import UIKit

class JSONHandler: NSObject {

    class func jsonCoding(_ jsonDictionary: [String:Any]) -> String {
        var result: String = ""
        do {
            let dict = NSMutableDictionary()
            for (key, value) in jsonDictionary {
                if let value = value as? AnyObject {
                    dict.setValue(value, forKey: key)
                }
            }
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            result = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)  as! String
        } catch {
            print("ERROR CONVERTING ARRAY TO JSON, ERROR = \(error)")
        }
        return result

    }

    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    class func parseToJSON(_ data: Data) -> Any {
        var result : Any = []
        do {
            result = try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            print("ERROR PARSIBNG JSON, ERROR = \(error)")
        }
        return result
    }

    class func attemptParseToString(_ anyobject: Any?, defaultReturn: String? = nil) -> String? {

        guard let _ = anyobject, let string = (anyobject! as AnyObject).description else {
            return defaultReturn
        }
        if  string != "<null>" {
            return string
        } else {
            return defaultReturn
        }
    }

    class func attemptParseToBool(_ anyobject: Any?) -> Bool? {
        if anyobject is Bool {
            return anyobject as! Bool?
        }
        guard let string = attemptParseToString(anyobject) else {
            return nil
        }
        return string.toBool()
    }

    class func attemptParseToDouble(_ anyobject: Any?, defaultReturn: Double? = nil) -> Double? {

        guard let string = attemptParseToString(anyobject) else {
            return defaultReturn
        }
        return Double(string) ?? defaultReturn
    }
    class func attemptParseToInt(_ anyobject: Any?, defaultReturn: Int? = nil) -> Int? {

        guard let string = attemptParseToString(anyobject) else {
            return defaultReturn
        }
        return Int(string) ?? defaultReturn
    }

    class func getValue<T>(of type: T.Type, key: String, from json: NSDictionary) -> T {
        guard let value = json[key] as? T else {
            let errorPlace: String = "Error in class: \(#file) , function:  \(#function), line: \(#line)"
            fatalError("Could not get value for key: \(key). " + errorPlace )
        }
        return value
    }

    internal class var null: NSNull { return NSNull() }
 }

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "YES", "yes", "1":
            return true
        case "False", "false", "NO", "no", "0":
            return false
        default:
            return nil
        }
    }
}

extension String {

    var numberValue: NSNumber? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self)
    }
}
