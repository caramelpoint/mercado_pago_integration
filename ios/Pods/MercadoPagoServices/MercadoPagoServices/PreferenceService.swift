//
//  PreferenceService.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 4/5/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class PreferenceService: MercadoPagoService {

    internal func getPreference(publicKey: String, preferenceId: String, success : @escaping (PXCheckoutPreference) -> Void, failure : @escaping ((_ apiException: PXError) -> Void)) {
        let params = "public_key=" + publicKey + "&api_version=" + PXServicesURLConfigs.API_VERSION
        self.request(uri: PXServicesURLConfigs.MP_PREFERENCE_URI + preferenceId, params: params, body: nil, method: "GET", success: { (data: Data) in
              let jsonResult = try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments)
            if let preferenceDic = jsonResult as? NSDictionary {
                if preferenceDic["error"] != nil {
                    let apiException = try! PXApiException.fromJSON(data: data)
                    failure(PXError(domain: "mercadopago.sdk.PreferenceService.getPreference", code: ErrorTypes.API_EXCEPTION_ERROR, userInfo: [NSLocalizedDescriptionKey: "Hubo un error", NSLocalizedFailureReasonErrorKey: "No se ha podido obtener la preferencia"], apiException: apiException))
                } else {
                    if preferenceDic.allKeys.count > 0 {
                        let checkoutPreference = try! PXCheckoutPreference.fromJSON(data: data)
                        success(checkoutPreference)
                    } else {
                        failure(PXError(domain: "mercadopago.sdk.PreferenceService.getPreference", code: ErrorTypes.API_UNKNOWN_ERROR, userInfo: [NSLocalizedDescriptionKey: "Hubo un error", NSLocalizedFailureReasonErrorKey: "No se ha podido obtener la preferencia"]))
                    }
                }
            }
            }, failure : { (error) in
                failure(PXError(domain: "mercadopago.sdk.PreferenceService.getPreference", code: ErrorTypes.NO_INTERNET_ERROR, userInfo: [NSLocalizedDescriptionKey: "Hubo un error", NSLocalizedFailureReasonErrorKey: "Verifique su conexión a internet e intente nuevamente"]))
        })
    }

}
