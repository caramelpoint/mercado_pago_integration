//
//  UILabel+Additions.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 29/10/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

extension UILabel {

    open func requiredHeight(numberOfLines: Int = 0) -> CGFloat {

        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font

        label.text = self.text

        label.sizeToFit()

        return label.frame.height
    }

    open static func getHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {

        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font

        label.text = text

        label.sizeToFit()

        return label.frame.height
    }

    open func clearAttributedText() {
        self.attributedText = NSAttributedString(string : "")
    }
}

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.height
    }

    public func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.width
    }
}
