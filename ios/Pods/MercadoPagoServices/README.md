# Mercado Pago Services SDK - iOS (Swift 4.0)

This library makes it easy to consume Mercado Pago API from your application. By creating tokens, Mercado Pago handles the bulk of PCI compliance by preventing sensitive card data from hitting your server. 

## Installation
Simply add the following line to your Podfile:

```ruby
use_frameworks!
platform :ios, '8.0'
pod 'MercadoPagoServices', '1.0.2'
```

Then the first step is to create an instance of **_MercadoPagoServices_** class:

``` swift
let mercadoPagoServices = MercadoPagoServices(merchantPublicKey: "publicKey")
```

## Charging cards

Get the necessary data to charge cards.

In order to charge your users, you need to get information about the card that will be used.

You need to find out your customer’s credit card type and brand to correctly validate details and, as we will see later on, to know if it is necessary to request additional information or define the number of installments available for payment.

Display available payment methods with the getPaymentMethods function of the **_MercadoPagoServices_** class:

``` swift
  mercadoPagoServices.getPaymentMethods(callback: { (pxPaymentMethods) in
      //Show paymentMethods for selection
  }) { (error) in
      //TODO: Manage API Failure
  }
```

### Collecting credit card information
Now you must get your customer’s credit card data in a secure way.

It is very important that the credit card information is sent directly from your customer’s device to MercadoPago, and not your servers. If you do this, you won’t have to worry about complying with PCI regulations. We provide you with the SDKs for you to be able to do this simply and securely.

Create a form for you customer to enter his credit card information, for example:


![Card form](https://secure.mlstatic.com/developers/site/cloud/assets/Uploads/new-card2-screenshot.png "Sample card form")

Depending on the country from which you are requesting the payment, you have to ask your customer for his identification type and number. To do this, you can consult the **_getIdentificationTypes_** method from the **_MercadoPagoServices_** class which, provided with your _public key_ returns valid identification types from the country in question.

``` swift
  mercadoPagoServices.getIdentificationTypes(callback: { (pxIdentificationTypes) in
      // Done, show the identification types to your users.
  }) { (error) in
      //TODO: Manage API Failure
  }
```

### Validate the information

Before creating a token for credit card information, it would be advisable for you to validate the information entered by the user. Many of these validations are very simple, including verifying that the types of data entered are correct or that mandatory fields have been filled out.

In the case of the credit card number and the security code, additional validations are carried out according to the selected payment method. For example, if it’s a Visa, it checks that it starts with a 4 and that the security code is a three-digit number. Don’t worry, MercadoPago’s SDK helps you out so that you don’t have to deal with these details.

##### Example:

``` swift
private func validateCardToken(cardToken: PXCardToken , paymentMethod: PXPaymentMethod) -> Bool {

    /* Set errors within this function
     *  Request focus on the first wrong filled field recommended */

    var result = true;

    /* Validate card number and security code
     *  according the payment method’s particularities */

    if  !cardToken.validateCardNumber(paymentMethod){
        result = false
    }

    if !cardToken.validateSecurityCode(paymentMethod){
        result = false
    }

    if !cardToken.validateExpiryDate(12, year: 23) {
        result = false
    }

    if !cardToken.validateCardholderName() {
        result = false
    }

    /* If an identification type was selected,
     *  validate it’s configurations */
    if getIdentificationType() != nil &&
        !cardToken.validateIdentificationNumber(getIdentificationType()) {
        result = false
    }
    return result
}
```

### Create a single use token

The following code shows you how you can exchange the credit card details for a secure token, directly from MercadoPago.

```swift
  mercadoPagoServices.createToken(pxCardToken, callback: { (pxToken) in
   //DONE! 
  }) { (error) in
      //TODO: Manage API Failure
  }
```

**Done!** Now you can create a payment in your servers!

Along with the token you have just created, you will also need to send the payment method, number of installments and bank selected by the user. You will also need to identify the item or service that is being purchased and the customer who is using your application.

```swift
  mercadoPagoServices.createPayment(YOUR_BASE_URL, YOUR_PAYMENTS_URI, body, queryParams, callback: {(pxPayment) in
  //DONE!
  }) { (error) in
    //TODO: Manage API Failure
  }
```

The BODY of the request must contain:
```json
{
        "transaction_amount": 100,
        "token": "ff8080814c11e237014c1ff593b57b4d",
        "description": "Title of what you are paying for",
        "installments": 1,
        "payment_method_id": "visa",
        "payer": {
                "email": "test_user_19653727@testuser.com"
        }
}
```

## Charging cards in installments

### Display installment plans

Using the **_MercadoPagoServices_** class, you can get available installment plans by indicating the first six digits of the credit card (bin), the amount of the transaction, the bank’s identifier if required (see next section) and the payment method. The amount is optional but allows you to get a description of installments, which we recommend, and which can be very practical to display available installment plans by writing very few lines of code.

We will see later on that when the bin is not enough to identify the card’s issuing bank, we need to indicate it explicitly to get appropriate costs.

```swift
  mercadoPagoServices.getInstallments(bin, amount, issuerId, paymentMethodId, callback: {(pxInstallments) in
    let payerCosts = pxInstallments[0].payerCosts
    // Show payerCosts list for selection
  }) { (error) in
    //TODO: Manage API Failure
  }
```

### Let the user select a bank, if needed

In some cases, MercadoPago needs to know the card’s issuing bank to find promotions offered by it or to know how to process the payment.

To know if you need to request this information from the user, you can use the _isIssuerRequired()_ method from the **_PaymentMethod_** class.

```swift
  mercadoPagoServices.getIssuers(paymentMethodId, bin, callback: { (pxIssuers) in
    //Show issuers for selection
  }) { (error) in
    //TODO: Manage API Failure
  }
```

Create the payment with the issuer data.

The BODY of the request must contain:

```json
{
    "transaction_amount": 100,
    "token": "ff8080814c11e237014c1ff593b57b4d",
    "description": "Title of what you are paying for",
    "payer": {
            "email": "test_user_19653727@testuser.com"
    },
    "installments": 3,
    "payment_method_id": "master",
    "issuer_id": 338
}
```
