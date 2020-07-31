//
//  BinMask.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 6/3/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

open class BinMask: NSObject {
    open var exclusionPattern: String!
    open var installmentsPattern: String!
    open var pattern: String!

    public override init() {
        super.init()
    }

    open class func fromJSON(_ json: NSDictionary) -> BinMask {
        let binMask: BinMask = BinMask()
        if let exclusionPattern = JSONHandler.attemptParseToString(json["exclusion_pattern"]) {
            binMask.exclusionPattern = exclusionPattern
        }
        if let installmentsPattern = JSONHandler.attemptParseToString(json["installments_pattern"]) {
            binMask.installmentsPattern = installmentsPattern
        }
        if let pattern = JSONHandler.attemptParseToString(json["pattern"]) {
            binMask.pattern = pattern
        }
        return binMask
    }

    open func toJSON() -> [String:Any] {
        let exclusionPattern : Any = String.isNullOrEmpty(self.exclusionPattern) ?  JSONHandler.null : self.exclusionPattern!
        let installmentsPattern : Any = self.installmentsPattern == nil ?  JSONHandler.null : self.installmentsPattern
        let pattern : Any = self.pattern == nil ? JSONHandler.null : self.pattern

        let obj: [String:Any] = [
            "pattern": pattern,
            "installments_pattern": installmentsPattern,
            "exclusion_pattern": exclusionPattern
            ]
        return obj
    }

    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
}

public func ==(obj1: BinMask, obj2: BinMask) -> Bool {
    var areEqual: Bool
    if (obj1.exclusionPattern == nil) || (obj2.exclusionPattern == nil) {
        areEqual  =
            obj1.installmentsPattern == obj2.installmentsPattern &&
            obj1.pattern == obj2.pattern

    } else {
       areEqual =
        obj1.exclusionPattern == obj2.exclusionPattern &&
        obj1.installmentsPattern == obj2.installmentsPattern &&
        obj1.pattern == obj2.pattern

    }

    return areEqual
}
