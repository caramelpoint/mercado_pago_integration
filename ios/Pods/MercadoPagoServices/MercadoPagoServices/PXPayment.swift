//
//  PXPayment.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 10/20/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation
open class PXPayment: NSObject, Codable {
    open var binaryMode: Bool?
    open var callForAuthorizeId: String?
    open var captured: Bool?
    open var card: PXCard?
    open var collectorId: Int?
    open var couponAmount: Double?
    open var currencyId: String?
    open var dateApproved: Date?
    open var dateCreated: Date?
    open var dateLastUpdated: Date?
    open var _description: String?
    open var differentialPricingId: Int64?
    open var externalReference: String?
    open var feeDetails: [PXFeeDetail]?
    open var id: Int64!
    open var installments: Int?
    open var issuerId: String?
    open var liveMode: Bool?
    open var metadata: [String: String]?
    open var moneyReleaseDate: Date?
    open var notificationUrl: String?
    open var operationType: String?
    open var order: PXOrder?
    open var payer: PXPayer?
    open var paymentMethodId: String?
    open var paymentTypeId: String?
    open var refunds: [PXRefund]?
    open var statementDescriptor: String?
    open var status: String?
    open var statusDetail: String?
    open var transactionAmount: Double?
    open var transactionAmountRefunded: Double?
    open var transactionDetails: PXTransactionDetails?
    open var tokenId: String?

    public override init() {

    }

    public init(binaryMode: Bool?, callForAuthorizeId: String?, captured: Bool?, card: PXCard?, collectorId: Int?, couponAmount: Double?, currencyId: String?, dateApproved: Date?, dateCreated: Date?, dateLastUpdated: Date?, description: String?, differentialPricingId: Int64?, externalReference: String?, feeDetails: [PXFeeDetail]?, id: Int64, installments: Int?, issuerId: String?, liveMode: Bool?, metadata: [String: String]?, moneyReleaseDate: Date?, notificationUrl: String?, operationType: String?, order: PXOrder?, payer: PXPayer?, paymentMethodId: String?, paymentTypeId: String?, refunds: [PXRefund]?, statementDescriptor: String?, status: String?, statusDetail: String?, transactionAmount: Double?, transactionAmountRefunded: Double?, transactionDetails: PXTransactionDetails?, tokenId: String?) {

        self.binaryMode = binaryMode
        self.callForAuthorizeId = callForAuthorizeId
        self.captured = captured
        self.card = card
        self.collectorId = collectorId
        self.couponAmount = couponAmount
        self.currencyId = currencyId
        self.dateApproved = dateApproved
        self.dateCreated = dateCreated
        self.dateLastUpdated = dateLastUpdated
        self._description = description
        self.differentialPricingId = differentialPricingId
        self.externalReference = externalReference
        self.feeDetails = feeDetails
        self.id = id
        self.installments = installments
        self.issuerId = issuerId
        self.liveMode = liveMode
        self.metadata = metadata
        self.moneyReleaseDate = moneyReleaseDate
        self.notificationUrl = notificationUrl
        self.operationType = operationType
        self.order = order
        self.payer = payer
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        self.refunds = refunds
        self.statementDescriptor = statementDescriptor
        self.status = status
        self.statusDetail = statusDetail
        self.transactionAmount = transactionAmount
        self.transactionAmountRefunded = transactionAmountRefunded
        self.transactionDetails = transactionDetails
        self.tokenId = tokenId

    }

    public enum PXPaymentKeys: String, CodingKey {
        case binaryMode = "binary_mode"
        case callForAuthorizeId = "call_for_authorize_id"
        case captured
        case card
        case collectorId = "collector_id"
        case couponAmount = "coupon_amount"
        case currencyId = "currency_id"
        case dateApproved = "date_approved"
        case dateCreated = "date_created"
        case dateLastUpdated = "date_last_updated"
        case description = "description"
        case differentialPricingId = "differential_pricing_id"
        case externalReference = "external_reference"
        case feeDetails = "fee_details"
        case id = "id"
        case installments = "installments"
        case issuerId = "issuer_id"
        case liveMode = "live_mode"
        case metadata = "metadata"
        case moneyReleaseDate = "money_release_date"
        case notificationUrl = "notification_url"
        case operationType = "operation_type"
        case order
        case payer
        case paymentMethodId = "payment_method_id"
        case paymentTypeId = "payment_type_id"
        case refunds
        case statementDescriptor = "statement_descriptor"
        case status
        case statusDetail = "status_detail"
        case transactionAmount = "transaction_amount"
        case transactionAmountRefunded = "transaction_amount_refunded"
        case transactionDetails = "transaction_details"
        case tokenId = "token_id"
    }

    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PXPaymentKeys.self)
        let binaryMode: Bool? = try container.decodeIfPresent(Bool.self, forKey: .binaryMode)
        let callForAuthorizeId: String? = try container.decodeIfPresent(String.self, forKey: .callForAuthorizeId)
        let captured: Bool? = try container.decodeIfPresent(Bool.self, forKey: .captured)
        let card: PXCard? = try container.decodeIfPresent(PXCard.self, forKey: .card)
        let collectorId: Int? = try container.decodeIfPresent(Int.self, forKey: .collectorId)
        let couponAmount: Double? = try container.decodeIfPresent(Double.self, forKey: .couponAmount)
        let currencyId: String? = try container.decodeIfPresent(String.self, forKey: .currencyId)
        let dateApprovedString: String? = try container.decodeIfPresent(String.self, forKey: .dateApproved)
        let dateCreatedString: String? = try container.decodeIfPresent(String.self, forKey: .dateCreated)
        let dateLastUpdatedString: String? = try container.decodeIfPresent(String.self, forKey: .dateLastUpdated)
        let description: String? = try container.decodeIfPresent(String.self, forKey: .description)
        let differentialPricingId: Int64? = try container.decodeIfPresent(Int64.self, forKey: .differentialPricingId)
        let externalReference: String? = try container.decodeIfPresent(String.self, forKey: .externalReference)
        let feeDetails: [PXFeeDetail]? = try container.decodeIfPresent([PXFeeDetail].self, forKey: .feeDetails)
        let id: Int64 = try container.decode(Int64.self, forKey: .id)
        let installments: Int? = try container.decodeIfPresent(Int.self, forKey: .installments)
        let issuerId: String? = try container.decodeIfPresent(String.self, forKey: .issuerId)
        let liveMode: Bool? = try container.decodeIfPresent(Bool.self, forKey: .liveMode)
        let metadata: [String: String]? = try container.decodeIfPresent([String: String].self, forKey: .metadata)
        let moneyReleaseDateString: String? = try container.decodeIfPresent(String.self, forKey: .moneyReleaseDate)
        let notificationUrl: String? = try container.decodeIfPresent(String.self, forKey: .notificationUrl)
        let operationType: String? = try container.decodeIfPresent(String.self, forKey: .operationType)
        let order: PXOrder? = try container.decodeIfPresent(PXOrder.self, forKey: .order)
        let payer: PXPayer? = try container.decodeIfPresent(PXPayer.self, forKey: .payer)
        let paymentMethodId: String? = try container.decodeIfPresent(String.self, forKey: .paymentMethodId)
        let paymentTypeId: String? = try container.decodeIfPresent(String.self, forKey: .paymentTypeId)
        let refunds: [PXRefund]? = try container.decodeIfPresent([PXRefund].self, forKey: .refunds)
        let statementDescriptor: String? = try container.decodeIfPresent(String.self, forKey: .statementDescriptor)
        let status: String? = try container.decodeIfPresent(String.self, forKey: .status)
        let statusDetail: String? = try container.decodeIfPresent(String.self, forKey: .statusDetail)
        let transactionAmount: Double? = try container.decodeIfPresent(Double.self, forKey: .transactionAmount)
        let transactionAmountRefunded: Double? = try container.decodeIfPresent(Double.self, forKey: .transactionAmountRefunded)
        let transactionDetails: PXTransactionDetails? = try container.decodeIfPresent(PXTransactionDetails.self, forKey: .transactionDetails)
        let tokenId: String? = try container.decodeIfPresent(String.self, forKey: .tokenId)

        let dateApproved = String.getDate(dateApprovedString)
        let dateCreated = String.getDate(dateCreatedString)
        let dateLastUpdated = String.getDate(dateLastUpdatedString)
        let moneyReleaseDate = String.getDate(moneyReleaseDateString)

        self.init(binaryMode: binaryMode, callForAuthorizeId: callForAuthorizeId, captured: captured, card: card, collectorId: collectorId, couponAmount: couponAmount, currencyId: currencyId, dateApproved: dateApproved, dateCreated: dateCreated, dateLastUpdated: dateLastUpdated, description: description, differentialPricingId: differentialPricingId, externalReference: externalReference, feeDetails: feeDetails, id: id, installments: installments, issuerId: issuerId, liveMode: liveMode, metadata: metadata, moneyReleaseDate: moneyReleaseDate, notificationUrl: notificationUrl, operationType: operationType, order: order, payer: payer, paymentMethodId: paymentMethodId, paymentTypeId: paymentTypeId, refunds: refunds, statementDescriptor: statementDescriptor, status: status, statusDetail: statusDetail, transactionAmount: transactionAmount, transactionAmountRefunded: transactionAmountRefunded, transactionDetails: transactionDetails, tokenId: tokenId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PXPaymentKeys.self)
        try container.encodeIfPresent(self.binaryMode, forKey: .binaryMode)
        try container.encodeIfPresent(self.callForAuthorizeId, forKey: .callForAuthorizeId)
        try container.encodeIfPresent(self.captured, forKey: .captured)
        try container.encodeIfPresent(self.card, forKey: .card)
        try container.encodeIfPresent(self.collectorId, forKey: .collectorId)
        try container.encodeIfPresent(self.couponAmount, forKey: .couponAmount)
        try container.encodeIfPresent(self.currencyId, forKey: .currencyId)
        try container.encodeIfPresent(self.dateApproved, forKey: .dateApproved)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.dateLastUpdated, forKey: .dateLastUpdated)
        try container.encodeIfPresent(self._description, forKey: .description)
        try container.encodeIfPresent(self.differentialPricingId, forKey: .differentialPricingId)
        try container.encodeIfPresent(self.externalReference, forKey: .externalReference)
        try container.encodeIfPresent(self.feeDetails, forKey: .feeDetails)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.installments, forKey: .installments)
        try container.encodeIfPresent(self.issuerId, forKey: .issuerId)
        try container.encodeIfPresent(self.liveMode, forKey: .liveMode)
        try container.encodeIfPresent(self.metadata, forKey: .metadata)
        try container.encodeIfPresent(self.moneyReleaseDate, forKey: .moneyReleaseDate)
        try container.encodeIfPresent(self.notificationUrl, forKey: .notificationUrl)
        try container.encodeIfPresent(self.operationType, forKey: .operationType)
        try container.encodeIfPresent(self.order, forKey: .order)
        try container.encodeIfPresent(self.payer, forKey: .payer)
        try container.encodeIfPresent(self.paymentMethodId, forKey: .paymentMethodId)
        try container.encodeIfPresent(self.paymentTypeId, forKey: .paymentTypeId)
        try container.encodeIfPresent(self.refunds, forKey: .refunds)
        try container.encodeIfPresent(self.statementDescriptor, forKey: .statementDescriptor)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.statusDetail, forKey: .statusDetail)
        try container.encodeIfPresent(self.transactionAmount, forKey: .transactionAmount)
        try container.encodeIfPresent(self.transactionAmountRefunded, forKey: .transactionAmountRefunded)
        try container.encodeIfPresent(self.transactionDetails, forKey: .transactionDetails)
        try container.encodeIfPresent(self.tokenId, forKey: .tokenId)
    }

    open func getDateFromString(_ string: String?) -> Date? {
        if let dateString = string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            dateFormatter.locale = Locale(identifier: "en_US")
            let date = dateFormatter.date(from: dateString)
            return date
        } else {
            return nil
        }
    }

    open func toJSONString() throws -> String? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8)
    }

    open func toJSON() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }

    open class func fromJSON(data: Data) throws -> PXPayment {
        return try JSONDecoder().decode(PXPayment.self, from: data)
    }

    open func isCardPaymentType() -> Bool {
        return self.paymentTypeId == PXPaymentTypes.CREDIT_CARD || self.paymentTypeId == PXPaymentTypes.DEBIT_CARD || paymentTypeId == PXPaymentTypes.PREPAID_CARD
    }

}

extension PXPayment {

    open class Status: NSObject {
        public static let APPROVED = "approved"
        public static let IN_PROCESS = "in_process"
        public static let REJECTED = "rejected"
        public static let PENDING = "pending"
        public static let RECOVERY = "recovery"
    }

    open class StatusDetails: NSObject {
        public static let INVALID_ESC = "invalid_esc"
        public static let ACCREDITED = "accredited"
        public static let REJECTED_CALL_FOR_AUTHORIZE = "cc_rejected_call_for_authorize"
        public static let PENDING_CONTINGENCY = "pending_contingency"
        public static let PENDING_REVIEW_MANUAL = "pending_review_manual"
        public static let PENDING_WAITING_PAYMENT = "pending_waiting_payment"
        public static let REJECTED_OTHER_REASON = "cc_rejected_other_reason"
        public static let REJECTED_BAD_FILLED_OTHER = "cc_rejected_bad_filled_other"
        public static let REJECTED_BAD_FILLED_CARD_NUMBER = "cc_rejected_bad_filled_card_number"
        public static let REJECTED_BAD_FILLED_SECURITY_CODE = "cc_rejected_bad_filled_security_code"
        public static let REJECTED_BAD_FILLED_DATE = "cc_rejected_bad_filled_date"
        public static let REJECTED_HIGH_RISK = "rejected_high_risk"
        public static let REJECTED_INSUFFICIENT_AMOUNT = "cc_rejected_insufficient_amount"
        public static let REJECTED_MAX_ATTEMPTS = "cc_rejected_max_attempts"
        public static let REJECTED_DUPLICATED_PAYMENT = "cc_rejected_duplicated_payment"
        public static let REJECTED_CARD_DISABLED = "cc_rejected_card_disabled"
        public static let REJECTED_INSUFFICIENT_DATA = "rejected_insufficient_data"
        public static let REJECTED_BY_BANK = "rejected_by_bank"
    }
}
