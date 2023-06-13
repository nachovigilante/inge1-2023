!classDefinition: #CartTest category: 'TusLibros-it3'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:27:50'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: cart invalidItemErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:28:31'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: cart invalidQuantityErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:28:44'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: cart invalidItemErrorMessage equals: anError messageText.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:29:05'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: 2 equals: (cart occurrencesOf: testObjectsFactory itemSellByTheStore)! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-it3'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:52:37'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: Cashier cartCanNotBeEmptyErrorMessage equals: anError messageText.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:52:52'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: testObjectsFactory itemSellByTheStorePrice * 2 equals: cashier checkOut.! !

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:53:10'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: Cashier canNotChargeAnExpiredCreditCardErrorMessage equals: anError messageText.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:53:30'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: 1 equals: salesBook size.
	self assert: total equals: salesBook first.! !

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:53:51'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard equals: creditCard.
	self assert: debitedAmout equals: total.! !

!CashierTest methodsFor: 'tests' stamp: 'JT 6/13/2023 10:54:07'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: self creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: self creditCardHasNoCreditErrorMessage equals: anError messageText.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'ARM 6/11/2023 14:09:42'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros-it3'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!RestInterfaceTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/13/2023 11:50:27'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	now := DateAndTime now.! !


!RestInterfaceTest methodsFor: 'cart operations' stamp: 'JT 6/13/2023 13:24:37'!
createCartFor: aRestInterface

	^ aRestInterface createCartFor: (testObjectsFactory validUser) authenticatedWith: (testObjectsFactory validPassword)! !


!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:09:03'!
test01CanCreateCartWithValidUserAndPassword

	| interface cartID |
	interface := self createDefaultInterface.
	cartID := self createCartFor: interface.
	
	self assert: (interface listCartIdentifiedAs: cartID) isEmpty! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:39:23'!
test02CanNotCreateCartWithInvalidUser

	| interface |
	interface := self createDefaultInterface.

	self should: [
		interface createCartFor: testObjectsFactory invalidUser
				  authenticatedWith: testObjectsFactory validPassword ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface invalidUserAndOrPasswordErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:39:33'!
test03CanNotCreateCartWithInvalidPassword

	| interface |
	interface := self createDefaultInterface.

	self should: [
		interface createCartFor: testObjectsFactory validUser
				  authenticatedWith: testObjectsFactory invalidPassword ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface invalidUserAndOrPasswordErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:13:47'!
test04CanAddItemsToACreatedCart

	| interface cartId |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	self shouldnt: [
		interface add: testObjectsFactory itemSellByTheStore
				  quantity: 1
				  toCartIdentifiedAs: cartId ]
		 raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:13:41'!
test05CanNotAddItemToNotCreatedCart

	| interface |
	interface := self createDefaultInterface.

	self should: [
		interface add: testObjectsFactory itemSellByTheStore
				  quantity: 1
				  toCartIdentifiedAs: testObjectsFactory invalidCartId ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface invalidCartIdErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:13:28'!
test06CanNotAddItemNotSellByTheStore

	| interface cartId |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	self should: [
		interface add: testObjectsFactory itemNotSellByTheStore
				  quantity: 1
				  toCartIdentifiedAs: cartId ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: interface invalidItemErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:13:36'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| interface cartId |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	self assert: (interface listCartIdentifiedAs: cartId) isEmpty 
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:14:24'!
test08CanNotListCartOfInvalidCartId

	| interface |
	interface := self createDefaultInterface.

	self 
		should: [ interface listCartIdentifiedAs: testObjectsFactory invalidCartId ] 
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface invalidCartIdErrorDescription! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:15:28'!
test09ListCartReturnsTheRightNumberOfItems

	| interface cartId cartContent |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	interface add: testObjectsFactory itemSellByTheStore
			  quantity: 1
			  toCartIdentifiedAs: cartId;
			  add: testObjectsFactory anotherItemSellByTheStore
			  quantity: 2
			  toCartIdentifiedAs: cartId.
			
	cartContent := interface listCartIdentifiedAs: cartId.
	
	self assert: 1
		 equals: (cartContent occurrencesOf: testObjectsFactory itemSellByTheStore). 
	self assert: 2
		 equals: (cartContent occurrencesOf: testObjectsFactory anotherItemSellByTheStore)
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:15:49'!
test10CanCheckoutACart

	| interface cartId  |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	interface add: testObjectsFactory itemSellByTheStore
			  quantity: 1
			  toCartIdentifiedAs: cartId.
	self shouldnt: [
		interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:16:36'!
test11CanNotCheckoutANotCreatedCart

	| interface |
	interface := self createDefaultInterface.

	self should: [
		interface 
			checkOutCartIdentifiedAs: testObjectsFactory invalidCartId
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface invalidCartIdErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:16:32'!
test12CanNotCheckoutAnEmptyCart

	| interface cartId |
	interface := self createDefaultInterface.
	cartId := self createCartFor: interface.
	
	self should: [
		interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: interface cartCanNotBeEmptyErrorMessage.
		
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:39:59'!
test13CanNotListCartItemsAfterTimeoutSinceCreation

	| interface cartId |
	interface := self createDefaultInterfaceWithTimeTravel.
	cartId := self createCartFor: interface.

	self increaseTimeBy: testObjectsFactory overTimeoutDuration.
	
	self should: [ interface listCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface cartCanNotBeUsedAfterTimeoutErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:40:04'!
test14CanNotAddItemsToCartAfterTimeoutSinceCreation

	| interface cartId |
	interface := self createDefaultInterfaceWithTimeTravel.
	cartId := self createCartFor: interface.

	self increaseTimeBy: testObjectsFactory overTimeoutDuration.
	
	self should: [
		interface add: testObjectsFactory itemSellByTheStore
				  quantity: 1
				  toCartIdentifiedAs: cartId. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface cartCanNotBeUsedAfterTimeoutErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:40:10'!
test15CanNotCheckoutCartAfterTimeoutSinceCreation

	| interface cartId |
	interface := self createDefaultInterfaceWithTimeTravel.
	cartId := self createCartFor: interface.

	self increaseTimeBy: testObjectsFactory overTimeoutDuration.
	
	self should: [
		interface
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: '1111222233334444'
			ownedBy: 'Juan Perez'
			expiringOn: testObjectsFactory notExpiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestInterface cartCanNotBeUsedAfterTimeoutErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 14:40:16'!
test16CanNotOperateOnCartAfterTimeoutSinceLastUsage

	| interface cartId |
	interface := self createDefaultInterfaceWithTimeTravel.
	cartId := self createCartFor: interface.
	
	interface add: testObjectsFactory itemSellByTheStore
			  quantity: 1
			  toCartIdentifiedAs: cartId.
	
	self increaseTimeBy: testObjectsFactory overTimeoutDuration.
	
	self should: [
		interface listCartIdentifiedAs: cartId.
		self increaseTimeBy: testObjectsFactory underTimeoutDuration. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: RestInterface cartCanNotBeUsedAfterTimeoutErrorDescription.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'JT 6/13/2023 13:28:22'!
test17CanOperateOnCartMultipleTimesIfDurationBetweenOperationsIsLessThanTimeout

	| interface cartId |
	interface := self createDefaultInterfaceWithTimeTravel.
	cartId := self createCartFor: interface.
	
	self increaseTimeBy: testObjectsFactory underTimeoutDuration.
	
	self shouldnt: [
		interface add: testObjectsFactory itemSellByTheStore
				  quantity: 1
				  toCartIdentifiedAs: cartId.
		self increaseTimeBy: testObjectsFactory underTimeoutDuration.
		interface listCartIdentifiedAs: cartId.
		self increaseTimeBy: testObjectsFactory underTimeoutDuration.
		interface
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: '1111222233334444'
			ownedBy: 'Juan Perez'
			expiringOn: testObjectsFactory notExpiredMonthOfYear. ]
		raise: Error - MessageNotUnderstood.! !


!RestInterfaceTest methodsFor: 'interface' stamp: 'JT 6/13/2023 11:41:41'!
createDefaultInterface
	
	^RestInterface
		authenticatingWith: self
		acceptingItemsOf: testObjectsFactory defaultCatalog
		processingWith: self.! !

!RestInterfaceTest methodsFor: 'interface' stamp: 'JT 6/13/2023 11:50:06'!
createDefaultInterfaceWithTimeTravel
	
	^RestInterface
		authenticatingWith: self
		acceptingItemsOf: testObjectsFactory defaultCatalog
		processingWith: self
		timeProvider: self.! !


!RestInterfaceTest methodsFor: 'authentication message protocol' stamp: 'JT 6/13/2023 13:24:55'!
is: aUser authenticatingWith: aPassword 
	| storedPassword |
	
	storedPassword := testObjectsFactory validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	
	^aPassword = storedPassword ! !


!RestInterfaceTest methodsFor: 'time provider message protocol' stamp: 'JT 6/13/2023 12:00:54'!
increaseTimeBy: aDuration

	aDuration negative ifTrue: [ self error: 'Duration has to be positive' ].
	
	now := now + aDuration.

	^ now.! !

!RestInterfaceTest methodsFor: 'time provider message protocol' stamp: 'JT 6/13/2023 11:51:27'!
now

	^ now.! !


!classDefinition: #Cart category: 'TusLibros-it3'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 00:20'!
content
	
	^Bag new
		addAll: items;
		yourself ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-it3'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros-it3'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ARM 6/11/2023 13:49:52'!
createSale

	^ total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-it3'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: 'TusLibros-it3'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-it3'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: 'TusLibros-it3'!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticationSystem carts catalog lastId merchantProcessor salesBook timeProvider cartTimestamps timeoutDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!RestInterface methodsFor: 'initialization' stamp: 'JT 6/13/2023 12:15:35'!
initializeAuthenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog processingWith: aMerchantProcessor timeProvider: aTimeProvider 

	timeoutDuration := Duration minutes: 30.
	carts := Dictionary new.
	cartTimestamps := Dictionary new.
	lastId := 0.
	
	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	timeProvider := aTimeProvider.! !


!RestInterface methodsFor: 'cart operations' stamp: 'JT 6/13/2023 12:23:37'!
add: aBook quantity: anAmount toCartIdentifiedAs: aCartId

	| cart |
	
	cart := self detectCartCheckingAndUpdatingTimestamps: aCartId.
	cart add: anAmount of: aBook ! !

!RestInterface methodsFor: 'cart operations' stamp: 'JT 6/13/2023 12:28:15'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	| cart |
	
	cart := self detectCartCheckingAndUpdatingTimestamps: aCartId.
	
	Cashier 
		toCheckout: cart 
		charging: (CreditCard expiringOn: anExpirationMonthOfYear) 
		throught: merchantProcessor 
		on: self now 
		registeringOn: salesBook! !

!RestInterface methodsFor: 'cart operations' stamp: 'JT 6/13/2023 12:26:57'!
createCartFor: aUser authenticatedWith: aPassword

	| cartId |
	
	self assertUser: aUser isAuthenticatedWith: aPassword.
	
	cartId := self generateCartId.
	
	carts at: cartId put: (Cart acceptingItemsOf: catalog).
	
	self updateTimestampFor: cartId.
	
	^cartId ! !

!RestInterface methodsFor: 'cart operations' stamp: 'JT 6/13/2023 12:23:59'!
detectCartCheckingAndUpdatingTimestamps: aCartId

	| cart |
	self assertWasUsedBeforeTimeout: aCartId.
	
	cart := carts at: aCartId ifAbsent: [ self signalInvalidCartId ].
	
	self updateTimestampFor: aCartId.
	
	^ cart.! !

!RestInterface methodsFor: 'cart operations' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId
	
	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una 
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"
	
	lastId := lastId + 1.
	^lastId! !

!RestInterface methodsFor: 'cart operations' stamp: 'JT 6/13/2023 12:23:37'!
listCartIdentifiedAs: aCartId

	| cart |
	
	cart := self detectCartCheckingAndUpdatingTimestamps: aCartId.
	
	^cart content! !


!RestInterface methodsFor: 'cart timestamps' stamp: 'JT 6/13/2023 12:31:00'!
timestampFor: aCartId

	^ cartTimestamps at: aCartId ifAbsent: [ self signalInvalidCartId ]! !

!RestInterface methodsFor: 'cart timestamps' stamp: 'JT 6/13/2023 12:25:24'!
updateTimestampFor: aCartId

	^ cartTimestamps at: aCartId put: self now.! !


!RestInterface methodsFor: 'assertions' stamp: 'JT 6/13/2023 12:26:17'!
assertUser: aUser isAuthenticatedWith: aPassword

	(self is: aUser authenticatingWith: aPassword) ifFalse: [
		self signalInvalidUserAndOrPassword
	]! !

!RestInterface methodsFor: 'assertions' stamp: 'JT 6/13/2023 12:24:35'!
assertWasUsedBeforeTimeout: aCartId

	| lastTimeUsed |
	lastTimeUsed := self timestampFor: aCartId.
	
	((self now - lastTimeUsed) < timeoutDuration) ifFalse: [self signalCanNotBeUsedAfterTimeout]! !


!RestInterface methodsFor: 'authentication' stamp: 'ARM 6/11/2023 13:54:36'!
is: aUser authenticatingWith: aPassword 
	
	^authenticationSystem is: aUser authenticatingWith: aPassword 
! !


!RestInterface methodsFor: 'time' stamp: 'JT 6/13/2023 12:05:10'!
now
	
	^timeProvider now! !


!RestInterface methodsFor: 'error descriptions' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage ! !

!RestInterface methodsFor: 'error descriptions' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^Cart invalidItemErrorMessage ! !


!RestInterface methodsFor: 'signals' stamp: 'JT 6/13/2023 12:21:19'!
signalCanNotBeUsedAfterTimeout

	^ self error: self class cartCanNotBeUsedAfterTimeoutErrorDescription! !

!RestInterface methodsFor: 'signals' stamp: 'JT 6/13/2023 12:04:26'!
signalInvalidCartId
	
	self error: self class invalidCartIdErrorDescription! !

!RestInterface methodsFor: 'signals' stamp: 'JT 6/13/2023 12:04:34'!
signalInvalidUserAndOrPassword
	
	self error: self class invalidUserAndOrPasswordErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros-it3'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'JT 6/13/2023 11:43:34'!
authenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog processingWith: aMerchantProcessor

	^self authenticatingWith: anAuthenticationSystem
		  acceptingItemsOf: aCatalog
		  processingWith: aMerchantProcessor
		  timeProvider: DateAndTime.! !

!RestInterface class methodsFor: 'instance creation' stamp: 'JT 6/13/2023 12:36:33'!
authenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog processingWith: aMerchantProcessor timeProvider: aTimeProvider

	^self new initializeAuthenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog processingWith: aMerchantProcessor timeProvider: aTimeProvider! !


!RestInterface class methodsFor: 'error descriptions' stamp: 'JT 6/13/2023 12:01:46'!
cartCanNotBeUsedAfterTimeoutErrorDescription

	^ 'Cart cannot be used after timeout'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'JT 6/13/2023 12:02:36'!
invalidCartIdErrorDescription

	^ 'Invalid cart id'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'JT 6/13/2023 12:03:58'!
invalidUserAndOrPasswordErrorDescription

	^ 'Invalid user and/or password'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-it3'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-it3'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'JT 6/13/2023 12:38:00'!
invalidCartId
	
	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'JT 6/13/2023 13:19:45'!
invalidPassword

	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'JT 6/13/2023 13:20:23'!
invalidUser

	^'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'JT 6/13/2023 13:20:55'!
validPassword

	^'validPassword'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'JT 6/13/2023 13:20:17'!
validUser

	^'validUser'! !

!StoreTestObjectsFactory methodsFor: 'user credentials' stamp: 'JT 6/13/2023 13:22:15'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validPassword;
		yourself! !


!StoreTestObjectsFactory methodsFor: 'timeout duration' stamp: 'JT 6/13/2023 13:25:37'!
overTimeoutDuration

	^self timeoutDuration + (Duration minutes: 1).! !

!StoreTestObjectsFactory methodsFor: 'timeout duration' stamp: 'JT 6/13/2023 13:25:21'!
timeoutDuration

	^Duration minutes: 30.! !

!StoreTestObjectsFactory methodsFor: 'timeout duration' stamp: 'JT 6/13/2023 13:25:42'!
underTimeoutDuration

	^self timeoutDuration - (Duration minutes: 1).! !
