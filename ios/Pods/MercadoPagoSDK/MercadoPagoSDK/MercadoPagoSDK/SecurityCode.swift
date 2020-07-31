//
//  SecurityCode.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

open class SecurityCode: NSObject {
    open var length: Int = 0
    open var cardLocation: String!
    open var mode: String!

    public override init() {
        super.init()
    }

    open class func fromJSON(_ json: NSDictionary) -> SecurityCode {
        let securityCode: SecurityCode = SecurityCode()
        if let length = JSONHandler.attemptParseToInt(json["length"]) {
            securityCode.length = length
        }
        if let cardLocation = JSONHandler.attemptParseToString(json["card_location"]) {
            securityCode.cardLocation = cardLocation
        }
        if let mode = JSONHandler.attemptParseToString(json["mode"]) {
            securityCode.mode = mode
        }
        return securityCode
    }

    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(toJSON())
    }

    open func toJSON() -> [String:Any] {
        let obj: [String:Any] = [
            "length": self.length,
            "card_location": self.cardLocation == nil ? "" : self.cardLocation!,
            "mode": self.mode == nil ? "" : self.mode!
        ]

        return obj
    }

}

public func ==(obj1: SecurityCode, obj2: SecurityCode) -> Bool {

    let areEqual =
    obj1.length == obj2.length &&
    obj1.cardLocation == obj2.cardLocation &&
    obj1.mode == obj2.mode

    return areEqual
}
