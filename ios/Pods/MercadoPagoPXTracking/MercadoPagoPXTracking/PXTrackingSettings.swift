//
//  PXTrackingSettings.swift
//  MercadoPagoPXTracking
//
//  Created by Eden Torres on 11/8/17.
//  Copyright © 2017 Mercado Pago. All rights reserved.
//

import Foundation
open class PXTrackingSettings: NSObject {

    static let eventsTrackingVersion = "1"

    open class func enableBetaServices() {
        PXTrackingURLConfigs.MP_SELECTED_ENV = PXTrackingURLConfigs.MP_TEST_ENV
    }
}
