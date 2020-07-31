//
//  InstructionsService.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 16/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class InstructionsService: MercadoPagoService {

    let merchantPublicKey: String!
    let payerAccessToken: String?

    init (baseURL: String, merchantPublicKey: String, payerAccessToken: String? = nil) {
        self.merchantPublicKey = merchantPublicKey
        self.payerAccessToken = payerAccessToken
        super.init(baseURL: baseURL)
    }

    @available(*, deprecated: 2.2.4, message: "Use getInstructions(_ paymentId : String, ...) instead. PaymentId can be greater than Int and might fail")
    open func getInstructions(_ paymentId: Int, paymentTypeId: String? = "", success : @escaping (_ instructionsInfo: PXInstructions) -> Void, failure: ((_ error: NSError) -> Void)?) {
        let paymentId = Int64(paymentId)
        self.getInstructions(for: paymentId, paymentTypeId: paymentTypeId, language: "es", success: success, failure: failure)
    }

    open func getInstructions(for paymentId: Int64, paymentTypeId: String? = "", language: String, success : @escaping (_ instructionsInfo: PXInstructions) -> Void, failure: ((_ error: PXError) -> Void)?) {

        var params: String = MercadoPagoServices.getParamsPublicKeyAndAcessToken(merchantPublicKey, payerAccessToken)
        params.paramsAppend(key: ApiParams.PAYMENT_TYPE, value: paymentTypeId)
        params.paramsAppend(key: ApiParams.API_VERSION, value : PXServicesURLConfigs.API_VERSION)

        let headers = ["Accept-Language": language]

        self.request(uri: PXServicesURLConfigs.MP_INSTRUCTIONS_URI.replacingOccurrences(of: "${payment_id}", with: String(paymentId)), params: params, body: nil, method: "GET", headers: headers, cache: false, success: { (data: Data) -> Void in

            let jsonResult = try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary

            let error = jsonResult["error"] as? String
            if error != nil && error!.characters.count > 0 {
                let apiException = try! PXApiException.fromJSON(data: data)
                let e : PXError = PXError(domain: "com.mercadopago.sdk.getInstructions", code: ErrorTypes.API_EXCEPTION_ERROR, userInfo: [NSLocalizedDescriptionKey: "No se ha podido obtener las intrucciones correspondientes al pago", NSLocalizedFailureReasonErrorKey: jsonResult["error"] as! String], apiException: apiException)
                failure!(e)
            } else {
                success(try! PXInstructions.fromJSON(data: data))
            }
        }, failure: { (error) in
            failure?(PXError(domain: "com.mercadopago.sdk.getInstructions", code: ErrorTypes.NO_INTERNET_ERROR, userInfo: [NSLocalizedDescriptionKey: "Hubo un error", NSLocalizedFailureReasonErrorKey: "Verifique su conexión a internet e intente nuevamente"]))
            })
    }
}
