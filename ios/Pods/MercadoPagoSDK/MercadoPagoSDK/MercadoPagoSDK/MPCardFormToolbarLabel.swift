//
//  MPCardFormToolbarLabel.swift
//  MercadoPagoSDK
//
//  Created by Angie Arlanti on 8/24/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

open class MPCardFormToolbarLabel: MPLabel {

    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
