//
//  IdentificationViewController.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 5/3/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class IdentificationViewController: MercadoPagoUIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var tipoDeDocumentoLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var numberDocLabel: UILabel!
    @IBOutlet weak var numberTextField: HoshiTextField!

    var callback : (( Identification) -> Void)?
    var errorExitCallback: (() -> Void)?
    var identificationTypes: [IdentificationType]!
    var identificationType: IdentificationType?

    //identification Masks
    var identificationMask = TextMaskFormater(mask: "XXXXXXXXXXXXX", completeEmptySpaces: false, leftToRight: false)

    var defaultInitialMask = TextMaskFormater(mask: "XXX.XXX.XXX.XXX", completeEmptySpaces: true, leftToRight: false)
    var defaultMask = TextMaskFormater(mask: "XXX.XXX.XXX.XXX.XXX.XXX.XXX.XXX.XXX", completeEmptySpaces: false, leftToRight: false)
    var defaultEditTextMask = TextMaskFormater(mask: "XXXXXXXXXXXXXXXXXXXX", completeEmptySpaces: false, leftToRight: false)

    var toolbar: UIToolbar?

    var identificationView: UIView!
    var identificationCard: IdentificationCardView?

    //@IBOutlet var typePicker: UIPickerView! = UIPickerView()

    override open var screenName: String { get { return "IDENTIFICATION_NUMBER" } }

    public init(identificationTypes: [IdentificationType], callback : @escaping (( _ identification: Identification) -> Void), errorExitCallback: (() -> Void)?) {
        super.init(nibName: "IdentificationViewController", bundle: MercadoPago.getBundle())
        self.callback = callback
        self.identificationTypes = identificationTypes
        self.errorExitCallback = errorExitCallback
    }

    override func loadMPStyles() {
        var titleDict: NSDictionary = [:]
        if self.navigationController != nil {
            let font = Utils.getFont(size: 18)
            titleDict = [NSForegroundColorAttributeName: UIColor.systemFontColor(), NSFontAttributeName: font]

            if self.navigationController != nil {
                self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
                self.navigationItem.hidesBackButton = true
                self.navigationController!.interactivePopGestureRecognizer?.delegate = self
                self.navigationController?.navigationBar.tintColor = UIColor.px_white()
                self.navigationController?.navigationBar.barTintColor = UIColor.primaryColor()
                self.navigationController?.navigationBar.removeBottomLine()
                self.navigationController?.navigationBar.isTranslucent = false
                displayBackButton()
            }
        }
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 216))
        pickerView.backgroundColor = UIColor.px_white()
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = UIColor.px_white()
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "OK".localized, style: .plain, target: self, action: #selector(IdentificationViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)

        let font = Utils.getFont(size: 14)
        doneButton.setTitleTextAttributes([NSFontAttributeName: font], for: UIControlState())

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar

    }

    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string.characters.count < 1 {
            return true
        }
        guard let identificationType = identificationType else {
            return false
        }
        if textField.text?.characters.count == identificationType.maxLength {
            return false
        }
        return true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.remask()
    }

    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.numberDocLabel.resignFirstResponder()
        return true
    }

    open func editingChanged(_ textField: UITextField) {
        hideErrorMessage()
        self.remask()
        textField.text = defaultEditTextMask.textMasked(textField.text, remasked: true)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func donePicker() {
        textField.resignFirstResponder()
        numberTextField.becomeFirstResponder()
    }

    @IBOutlet weak var keyboardHeightConstraint: NSLayoutConstraint!
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeightConstraint.constant = keyboardSize.height + 61 // Keyboard + Vista, dejo el mismo nombre de variable para tener consistencia entre clases, pero esta constante no representa la altura real del teclado, sino una altura que varia dependiendo de la altura del teclado
            self.view.layoutIfNeeded()
            self.view.setNeedsUpdateConstraints()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        identificationCard = IdentificationCardView()

        self.identificationView = UIView()

        let IDcardHeight = getCardHeight()
        let IDcardWidht = getCardWidth()
        let xMargin = (UIScreen.main.bounds.size.width  - IDcardWidht) / 2
        let yMargin = (UIScreen.main.bounds.size.height - 384 - IDcardHeight ) / 2

        let rectBackground = CGRect(x: xMargin, y: yMargin, width: IDcardWidht, height: IDcardHeight)
        let rect = CGRect(x: 0, y: 0, width: IDcardWidht, height: IDcardHeight)
        self.identificationView.frame = rectBackground
        identificationCard?.frame = rect
        self.identificationView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.identificationView.layer.cornerRadius = 11
        self.identificationView.layer.masksToBounds = true
        self.view.addSubview(identificationView)
        identificationView.addSubview(identificationCard!)

        tipoDeDocumentoLabel = identificationCard?.tipoDeDocumentoLabel
        numberDocLabel = identificationCard?.numberDocLabel

        self.tipoDeDocumentoLabel.text =  "DOCUMENTO DEL TITULAR DE LA TARJETA".localized
        self.tipoDeDocumentoLabel.font = Utils.getIdentificationFont(size: 10)
        self.numberTextField.placeholder = "Número".localized
        self.textField.placeholder = "Tipo".localized
        self.view.backgroundColor = UIColor.primaryColor()
        numberTextField.autocorrectionType = UITextAutocorrectionType.no
        numberTextField.keyboardType = UIKeyboardType.numberPad
        numberTextField.addTarget(self, action: #selector(IdentificationViewController.editingChanged(_:)), for: UIControlEvents.editingChanged)
        self.setupInputAccessoryView()
        identificationType =  self.identificationTypes[0]
        textField.text = self.identificationTypes[0].name
        self.numberTextField.text = ""
        self.remask()
    }

    func getCardWidth() -> CGFloat {
        let widthTotal = UIScreen.main.bounds.size.width * 0.70
        if widthTotal < 512 {
            if (0.63 * widthTotal) < (UIScreen.main.bounds.size.height - 394) {
                return widthTotal
            } else {
                return (UIScreen.main.bounds.size.height - 394) / 0.63
            }

        } else {
            return 512
        }

    }

    func getCardHeight() -> CGFloat {
        return ( getCardWidth() * 0.63 )
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.leftBarButtonItem!.action = #selector(invokeCallbackCancelShowingNavBar)
        self.numberTextField.becomeFirstResponder()
    }

    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   open

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.identificationTypes == nil {
            return 0
        }

        return self.identificationTypes.count
    }

    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.identificationTypes[row].name
    }

    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        identificationType =  self.identificationTypes[row]
        textField.text = self.identificationTypes[row].name
        self.numberTextField.text = ""
        self.remask()

    }

    @IBAction func setType(_ sender: AnyObject) {
        numberTextField.resignFirstResponder()
    }

    var navItem: UINavigationItem?
    var doneNext: UIBarButtonItem?
    var donePrev: UIBarButtonItem?

    func setupInputAccessoryView() {

        if self.toolbar == nil {
            let frame =  CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)

            let toolbar = UIToolbar(frame: frame)

            toolbar.barStyle = UIBarStyle.default
            toolbar.backgroundColor = UIColor.mpLightGray()
            toolbar.alpha = 1
            toolbar.isUserInteractionEnabled = true

            let buttonNext = UIBarButtonItem(title: "Continuar".localized, style: .done, target: self, action: #selector(CardFormViewController.rightArrowKeyTapped))
            let buttonPrev = UIBarButtonItem(title: "Anterior".localized, style: .plain, target: self, action: #selector(CardFormViewController.leftArrowKeyTapped))

            let font = Utils.getFont(size: 14)
            buttonNext.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
            buttonPrev.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)

            buttonNext.setTitlePositionAdjustment(UIOffset(horizontal: UIScreen.main.bounds.size.width / 8, vertical: 0), for: UIBarMetrics.default)
            buttonPrev.setTitlePositionAdjustment(UIOffset(horizontal: -UIScreen.main.bounds.size.width / 8, vertical: 0), for: UIBarMetrics.default)

            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

            toolbar.items = [flexibleSpace, buttonPrev, flexibleSpace, buttonNext, flexibleSpace]

            numberTextField.delegate = self
            self.toolbar = toolbar
        }
        numberTextField.inputAccessoryView = self.toolbar

    }

    func rightArrowKeyTapped() {
        let idnt = Identification(type: self.identificationType?._id, number: defaultEditTextMask.textUnmasked(numberTextField.text))

        let cardToken = CardToken(cardNumber: "", expirationMonth: 10, expirationYear: 10, securityCode: "", cardholderName: "", docType: (self.identificationType?.type)!, docNumber:  defaultEditTextMask.textUnmasked(numberTextField.text))

        if (cardToken.validateIdentificationNumber(self.identificationType)) == nil {
            self.numberTextField.resignFirstResponder()
            self.callback!(idnt)
        } else {
            showErrorMessage((cardToken.validateIdentificationNumber(self.identificationType))!)
        }

    }

    var errorLabel: MPLabel?

    func showErrorMessage(_ errorMessage: String) {

        guard let toolbar = toolbar else {
            return
        }

        errorLabel = MPLabel(frame: toolbar.frame)
        self.errorLabel!.backgroundColor = UIColor.mpLightGray()
        self.errorLabel!.textColor = UIColor.mpRedErrorMessage()
        self.errorLabel!.text = errorMessage
        self.errorLabel!.textAlignment = .center
        self.errorLabel!.font = self.errorLabel!.font.withSize(12)
        numberTextField.borderInactiveColor = UIColor.red
        numberTextField.borderActiveColor = UIColor.red
        numberTextField.inputAccessoryView = errorLabel
        numberTextField.setNeedsDisplay()
        numberTextField.resignFirstResponder()
        numberTextField.becomeFirstResponder()

    }

    func hideErrorMessage() {
        self.numberTextField.borderInactiveColor = UIColor(netHex: 0x3F9FDA)
        self.numberTextField.borderActiveColor = UIColor(netHex: 0x3F9FDA)
        self.numberTextField.inputAccessoryView = self.toolbar
        self.numberTextField.setNeedsDisplay()
        self.numberTextField.resignFirstResponder()
        self.numberTextField.becomeFirstResponder()
    }

    func leftArrowKeyTapped() {
        self.navigationController?.popViewController(animated: false)
    }

    fileprivate func maskFinder(dictID: String, forKey: String) -> [TextMaskFormater]? {
        let path = MercadoPago.getBundle()!.path(forResource: "IdentificationTypes", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)

        if let IDtype = dictionary?.value(forKey: dictID) as? NSDictionary {
            if let mask = IDtype.value(forKey: forKey) as? String, mask != ""{
                let customInitialMask = TextMaskFormater(mask: mask, completeEmptySpaces: true, leftToRight: false)
                let customMask = TextMaskFormater(mask: mask, completeEmptySpaces: true, leftToRight: false, completeEmptySpacesWith: " ")
                return[customInitialMask, customMask]
            }
        }
        return nil
    }

    fileprivate func getIdMask(IDtype: IdentificationType?) -> [TextMaskFormater] {
        let site = MercadoPagoContext.getSite()

        if IDtype != nil {
            if let masks = maskFinder(dictID: site+"_"+(IDtype?._id)!, forKey: "identification_mask") {
                return masks
            } else if let masks = maskFinder(dictID: site, forKey: "identification_mask") {
                return masks
            } else {
                return [defaultInitialMask, defaultMask]
            }
        } else {
            return [defaultInitialMask, defaultMask]
        }
    }

    fileprivate func drawMask(masks: [TextMaskFormater]) {

        let charactersCount = numberTextField.text?.characters.count

        if charactersCount! >= 1 {
            let identificationMask = masks[1]
            numberTextField.text = defaultEditTextMask.textMasked(numberTextField.text, remasked: true)
            self.numberDocLabel.text = identificationMask.textMasked(defaultEditTextMask.textUnmasked(numberTextField.text))

        } else {
            let identificationMask = masks[0]
            numberTextField.text = defaultEditTextMask.textMasked(numberTextField.text, remasked: true)
            self.numberDocLabel.text = identificationMask.textMasked(defaultEditTextMask.textUnmasked(numberTextField.text))
        }
    }

    fileprivate func remask() {
        drawMask(masks: getIdMask(IDtype: identificationType))
    }
}
