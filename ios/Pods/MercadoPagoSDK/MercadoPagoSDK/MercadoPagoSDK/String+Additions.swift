//
//  String+Additions.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 29/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

extension String {

    static let NON_BREAKING_LINE_SPACE = "\u{00a0}"

	var localized: String {
		var bundle: Bundle? = MercadoPago.getBundle()
		if bundle == nil {
			bundle = Bundle.main
		}
        let languageBundle = Bundle(path : MercadoPagoContext.getLocalizedPath())
        return languageBundle!.localizedString(forKey: self, value : "", table : nil)

	}

    public func existsLocalized() -> Bool {
        let localizedString = self.localized
        return localizedString != self
    }

    static public func isDigitsOnly(_ a: String) -> Bool {
		if Regex.init("^[0-9]*$").test(a) {
			return true
		} else {
			return false
		}
    }

    public func startsWith(_ prefix: String) -> Bool {
        if prefix == self {
            return true
        }
        let startIndex = self.range(of: prefix)
        if startIndex == nil  || self.startIndex != startIndex?.lowerBound {
            return false
        }
        return true
    }

    subscript (i: Int) -> String {

        if self.characters.count > i {
            return String(self[self.characters.index(self.startIndex, offsetBy: i)])
        }

        return ""
    }

    public func lastCharacters(number: Int) -> String {
        let trimmedString: String = (self as NSString).substring(from: max(self.characters.count - number, 0))
        return trimmedString
    }

    public func indexAt(_ theInt: Int)->String.Index {

        return self.characters.index(self.characters.startIndex, offsetBy: theInt)
    }

    public func trimSpaces() -> String {

        var stringTrimmed = self.replacingOccurrences(of: " ", with: "")
        stringTrimmed = stringTrimmed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return stringTrimmed
    }

    mutating func paramsAppend(key: String, value: String?) {
        if !key.isEmpty && !String.isNullOrEmpty(value) {
            if self.isEmpty {
                self = key + "=" + value!
            } else {
                self = self + "&" + key + "=" + value!
            }
        }
    }
}
