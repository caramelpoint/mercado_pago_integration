//
//  PromoTyCDetailTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 22/5/15.
//  Copyright (c) 2015 MercadoPago. All rights reserved.
//

import UIKit

open class PromoTyCDetailTableViewCell: UITableViewCell {

	@IBOutlet weak fileprivate var tycLabel: MPLabel!

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	open func setLabelWithIssuerName(_ issuer: String, legals: String?) {
		let s = NSMutableAttributedString(string: "\(issuer): \(legals != nil ? legals! : "No hay condiciones.")")
		let atts: [String : AnyObject] = [NSFontAttributeName: Utils.getFont(size: 15)]
		s.addAttributes(atts, range: NSMakeRange(0, issuer.characters.count))
		self.tycLabel.attributedText = s
	}

}
