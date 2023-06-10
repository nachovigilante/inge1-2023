!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'IV 6/8/2023 19:59:45'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'IV 6/10/2023 19:20:26'!
createCreditCard

	^ CreditCard of: 'Ignacio Vigilante' withNumber: '1234 1234 1234 1234' expiringAt: (August, 2026).! !

!CashierTest methodsFor: 'support' stamp: 'IV 6/8/2023 20:00:47'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CashierTest methodsFor: 'support' stamp: 'IV 6/8/2023 20:30:50'!
itemSellByTheStore
	
	^ 10@'validbook'! !


!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 19:55:01'!
createCashier

	^ Cashier with: (MockMerchantProcessorOK new).! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 19:54:37'!
test01CannotCheckoutEmptyCart

	| cart cashier creditCard |
	
	cart := self createCart.
	cashier := self createCashier.
	creditCard := self createCreditCard.
	
	self should: [cashier checkout: cart with: creditCard on: June / 6 / 2023] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Cashier emptyCartErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 19:54:37'!
test02CheckoutOfACartWithOneProductReturnsItsPrice

	| cart cashier creditCard |
	
	cart := self createCart.
	cart add: (10@'validbook').
	cashier := self createCashier.
	creditCard := self createCreditCard.
	
	self assert: 10 equals: (cashier checkout: cart with: creditCard on: June / 6 / 2023).! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 19:54:37'!
test03CheckoutOfACartWithMoreThanOneOcurrenciesOfAProductReturnTheSumOfTheirPrices

	| cart cashier creditCard |
	
	cart := self createCart.
	cart add: 5 of: (10@'validbook').
	cashier := self createCashier.
	creditCard := self createCreditCard.
	
	self assert: 50 equals: (cashier checkout: cart with: creditCard on: June / 6 / 2023).! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 20:10:11'!
test04CannotCheckoutWithExpiredCard

	| cart cashier creditCard |
	
	cart := self createCart.
	cart add: (10@'validbook').
	cashier := self createCashier.
	creditCard := CreditCard of: 'Ignacio Vigilante' withNumber: '1234 1234 1234 1234' expiringAt: August, 1900.
	
	self should: [ cashier checkout: cart with: creditCard on: June / 6 / 2023 ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Cashier expiredCreditCardErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 20:22:26'!
test05CannotCheckoutWithStolenCard

	| cart cashier creditCard |
	
	cart := self createCart.
	cart add: (10@'validbook').
	cashier := Cashier with: MockMerchantProcessorStolenCard new.
	creditCard := self createCreditCard.
	
	self should: [ cashier checkout: cart with: creditCard on: June / 6 / 2023 ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Cashier stolenCreditCardErrorDescription.! !

!CashierTest methodsFor: 'tests' stamp: 'IV 6/10/2023 20:22:29'!
test06CannotCheckoutWithInsufficientFunds

	| cart cashier creditCard |
	
	cart := self createCart.
	cart add: (10@'validbook').
	cashier := Cashier with: MockMerchantProcessorInsufficientFunds new.
	creditCard := self createCreditCard.
	
	self should: [ cashier checkout: cart with: creditCard on: June / 6 / 2023 ] 
		 raise: Error - MessageNotUnderstood 
		 withMessageText: Cashier insufficientFundsErrorDescription.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'IV 6/8/2023 20:49:13'!
totalPrice

	^items inject: 0 into: [:totalPrice :aProduct |
		totalPrice + aProduct x
	]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'IV 6/8/2023 20:34:44'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'mp'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'IV 6/10/2023 20:07:31'!
checkout: aCart with: aCreditCard on: aDate 

	| result |
	
	self assertCartIsNotEmpty: aCart.
	
	result := mp processWithAmountOf: aCart totalPrice chargingTo: aCreditCard on: aDate.
		
	(result first) = $1 ifTrue: [ self parseErrorResponse: result ].
	
	^ aCart totalPrice.
	! !

!Cashier methodsFor: 'checkout' stamp: 'IV 6/10/2023 20:05:57'!
ifErrorOf: anErrorResponse is: aForeignErrorDescription throw: anErrorDescription

	(anErrorResponse is: aForeignErrorDescription substringAt: 3) ifTrue: [
		self error: anErrorDescription.	
	].



! !

!Cashier methodsFor: 'checkout' stamp: 'IV 6/10/2023 20:21:43'!
parseErrorResponse: result

	self ifErrorOf: result is: MockMerchantProcessor expiredCreditCardErrorDescription throw: self class expiredCreditCardErrorDescription.
	self ifErrorOf: result is: MockMerchantProcessor stolenCreditCardErrorDescription throw: self class stolenCreditCardErrorDescription.
	self ifErrorOf: result is: MockMerchantProcessor insufficientFundsErrorDescription throw: self class insufficientFundsErrorDescription.! !


!Cashier methodsFor: 'assertions' stamp: 'IV 6/8/2023 20:13:27'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self class emptyCartErrorDescription]! !


!Cashier methodsFor: 'initialization' stamp: 'IV 6/10/2023 19:54:05'!
initializeWith: aMerchantProcessor

	mp := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'IV 6/8/2023 20:10:19'!
emptyCartErrorDescription

	^'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 20:10:06'!
expiredCreditCardErrorDescription

	^'Cannot checkout with an expirated credit card'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 20:21:57'!
insufficientFundsErrorDescription

	^'Cannot checkout because the credit card has insufficient funds'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 19:44:36'!
stolenCreditCardErrorDescription

	^'Cannot checkout because the credit card is stolen'! !


!Cashier class methodsFor: 'instance creation' stamp: 'IV 6/10/2023 19:53:47'!
with: aMerchantProcessor

	^self new initializeWith: aMerchantProcessor.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration securityCode owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'IV 6/10/2023 19:19:49'!
initializeOf: anOwnerName withNumber: aCardNumber expiringAt: anExpirationMonthOfYear

	number := aCardNumber.
	expiration := anExpirationMonthOfYear.
	owner := anOwnerName.
! !


!CreditCard methodsFor: 'accessing' stamp: 'IV 6/10/2023 19:18:16'!
expiration

	^expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'IV 6/10/2023 19:18:24'!
number

	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'IV 6/10/2023 19:18:34'!
owner

	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'IV 6/10/2023 19:20:26'!
of: anOwnerName withNumber: aCardNumber expiringAt: anExpirationDate

	^self new initializeOf: anOwnerName withNumber: aCardNumber expiringAt: anExpirationDate.! !


!classDefinition: #MockMerchantProcessor category: 'TusLibros'!
Object subclass: #MockMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessor methodsFor: 'process' stamp: 'IV 6/10/2023 19:52:10'!
processWithAmountOf: anAmount chargingTo: aCreditCard on: aDate

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: 'TusLibros'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 19:25:17'!
expiredCreditCardErrorDescription

	^'EXPIRED_CREDIT_CARD'.! !

!MockMerchantProcessor class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 20:15:33'!
insufficientFundsErrorDescription

	^'INSUFFICIENT_FUNDS'! !

!MockMerchantProcessor class methodsFor: 'error descriptions' stamp: 'IV 6/10/2023 19:44:55'!
stolenCreditCardErrorDescription

	^'STOLEN_CREDIT_CARD'.! !


!classDefinition: #MockMerchantProcessorInsufficientFunds category: 'TusLibros'!
MockMerchantProcessor subclass: #MockMerchantProcessorInsufficientFunds
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessorInsufficientFunds methodsFor: 'process' stamp: 'IV 6/10/2023 20:15:33'!
processWithAmountOf: anAmount chargingTo: aCreditCard on: aDate

	^'1|', self class insufficientFundsErrorDescription.! !


!classDefinition: #MockMerchantProcessorOK category: 'TusLibros'!
MockMerchantProcessor subclass: #MockMerchantProcessorOK
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessorOK methodsFor: 'process' stamp: 'IV 6/10/2023 19:55:48'!
processWithAmountOf: anAmount chargingTo: aCreditCard on: aDate

	(aCreditCard expiration firstDate < aDate) ifTrue: [ ^'1|', self class expiredCreditCardErrorDescription ].
	
	^'0|OK'.! !


!classDefinition: #MockMerchantProcessorStolenCard category: 'TusLibros'!
MockMerchantProcessor subclass: #MockMerchantProcessorStolenCard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessorStolenCard methodsFor: 'process' stamp: 'IV 6/10/2023 19:52:21'!
processWithAmountOf: anAmount chargingTo: aCreditCard on: aDate

	^'1|', self class stolenCreditCardErrorDescription.! !
