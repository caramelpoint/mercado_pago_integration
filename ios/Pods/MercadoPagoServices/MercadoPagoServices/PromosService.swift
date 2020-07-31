//
//  PromosService.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 22/5/15.
//  Copyright (c) 2015 MercadoPago. All rights reserved.
//

import Foundation

open class PromosService: MercadoPagoService {

	open func getPromos(_ url: String = PXServicesURLConfigs.MP_PROMOS_URI, method: String = "GET", public_key: String, success: @escaping (_ data: Data?) -> Void, failure: ((_ error: PXError) -> Void)?) {
        self.request(uri: url, params: "public_key=" + public_key, body: nil, method: method, success: success, failure : { (error) in
            failure?(PXError(domain: "mercadopago.sdk.PreferenceService.getBankDeals", code: ErrorTypes.NO_INTERNET_ERROR, userInfo: [NSLocalizedDescriptionKey: "Hubo un error", NSLocalizedFailureReasonErrorKey: "Verifique su conexión a internet e intente nuevamente"]))
        })
	}

}
