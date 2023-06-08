!classDefinition: #TusLibrosTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'catalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/8/2023 11:56:48'!
setUp
	catalog := BookCatalog new.
	catalog add: 'isbn1' priced: 10 * peso.
	catalog add: 'isbn2' priced: 20 * peso.
	catalog add: 'isbn3' priced: 30 * peso.
	cart := Cart using: catalog.! !


!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 20:12:23'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.
	
	

! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 11:25:46'!
test02CartWithBookIsNotEmpty

	cart addOneOf: 'isbn1'.
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 11:35:32'!
test03CartWithBookListsBookWithAQuantityOfOne

	| bookISBN |
	bookISBN := 'isbn1'.
	cart addOneOf: bookISBN.
	
	self assert: cart
		 hasItems: { CartItem withOneOf: bookISBN }.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 11:36:13'!
test04CartWithManyBooksListsAllOfThemWithEachQuantity

	| aBook anotherBook |
	aBook := 'isbn1'.
	anotherBook := 'isbn2'.

	cart addOneOf: aBook;
		 add: 2 of: anotherBook.
	
	self assert: cart hasItems: {
		CartItem withOneOf: aBook.
		CartItem with: 2 of: anotherBook.
	}.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 11:36:38'!
test05CartWithManyBooksCanCalculateTotalPriceOfItems

	cart addOneOf: 'isbn1'.
	cart add: 2 of: 'isbn2'.

	self assert: cart totalPrice equals: 50 * peso.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 12:06:34'!
test06CartCannotAddBookWithMissingISBN

	self should: [ cart addOneOf: 'invalid-isbn' ]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: Cart invalidISBNErrorDescription
				 equals: anError messageText.
		 ]! !


!TusLibrosTest methodsFor: 'assertions' stamp: 'JT 6/5/2023 21:07:10'!
assert: aCart hasItems: expectedCartItems

	| cartItems |
	cartItems := aCart items.
	
	self assert: cartItems size equals: expectedCartItems size.
	cartItems with: expectedCartItems do: [:cartItem :expectedCartItem |
		self assert: cartItem equals: expectedCartItem
	]! !


!classDefinition: #BookCatalog category: 'TusLibros-Ejercicio'!
Object subclass: #BookCatalog
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!BookCatalog methodsFor: 'adding' stamp: 'JT 6/8/2023 11:58:47'!
add: anISBN priced: aPrice 

	items add: (BookCatalogItem with: anISBN for: aPrice).! !


!BookCatalog methodsFor: 'initialization' stamp: 'JT 6/8/2023 11:18:35'!
initialize

	items := OrderedCollection new.! !


!BookCatalog methodsFor: 'price' stamp: 'JT 6/8/2023 12:02:36'!
priceFor: anISBN

	^ (items detect: [:item | item isbn = anISBN]) price.! !


!BookCatalog methodsFor: 'testing' stamp: 'JT 6/8/2023 11:59:04'!
hasBookWith: anISBN

	^ items anySatisfy: [:item | item isbn = anISBN].! !


!classDefinition: #BookCatalogItem category: 'TusLibros-Ejercicio'!
Object subclass: #BookCatalogItem
	instanceVariableNames: 'isbn price amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!BookCatalogItem methodsFor: 'initialization' stamp: 'JT 6/8/2023 11:58:06'!
initializeWith: anISBN for: aPrice
	isbn := anISBN.
	price := aPrice.! !


!BookCatalogItem methodsFor: 'accessing' stamp: 'JT 6/8/2023 11:58:18'!
isbn
	^isbn! !

!BookCatalogItem methodsFor: 'accessing' stamp: 'JT 6/8/2023 11:32:44'!
price
	^price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookCatalogItem class' category: 'TusLibros-Ejercicio'!
BookCatalogItem class
	instanceVariableNames: ''!

!BookCatalogItem class methodsFor: 'instance creation' stamp: 'JT 6/8/2023 11:17:59'!
with: aBook for: anAmount
	^self new initializeWith: aBook for: anAmount ! !


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'JT 6/8/2023 11:20:09'!
initialize

	items := OrderedCollection new.
	bookCatalog := BookCatalog new.! !

!Cart methodsFor: 'initialization' stamp: 'JT 6/8/2023 11:19:25'!
initializeUsing: aBookCatalog
	bookCatalog := aBookCatalog.! !


!Cart methodsFor: 'testing' stamp: 'JT 6/5/2023 21:19:24'!
isEmpty

	^ items isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'JT 6/8/2023 11:25:09'!
add: aQuantity of: anISBN

	self verifyValidISBN: anISBN.

	items add: (CartItem with: aQuantity of: anISBN).! !

!Cart methodsFor: 'adding' stamp: 'JT 6/8/2023 11:22:45'!
addOneOf: anISBN

	self add: 1 of: anISBN! !


!Cart methodsFor: 'items' stamp: 'JT 6/5/2023 21:19:34'!
items
	^ items.! !

!Cart methodsFor: 'items' stamp: 'JT 6/8/2023 12:04:24'!
totalPrice

	^ items inject: 0 * peso into: [:total :item | | price |
		price := bookCatalog priceFor: item isbn.
		total + (price * item quantity)
	]! !


!Cart methodsFor: 'preconditions' stamp: 'JT 6/8/2023 12:07:08'!
signalInvalidISBN

	^ self error: self class invalidISBNErrorDescription! !

!Cart methodsFor: 'preconditions' stamp: 'JT 6/8/2023 12:07:08'!
verifyValidISBN: anISBN

	(bookCatalog hasBookWith: anISBN) ifFalse: [self signalInvalidISBN].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JT 6/8/2023 11:19:09'!
using: aBookCatalog
	^self new initializeUsing: aBookCatalog ! !


!Cart class methodsFor: 'error description' stamp: 'JT 6/8/2023 11:30:01'!
invalidISBNErrorDescription

	^ 'ISBN invalido'! !


!classDefinition: #CartItem category: 'TusLibros-Ejercicio'!
Object subclass: #CartItem
	instanceVariableNames: 'isbn quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartItem methodsFor: 'initialization' stamp: 'JT 6/8/2023 12:10:11'!
initializeWith: aQuantity of: anISBN
	quantity := aQuantity.
	isbn := anISBN.! !


!CartItem methodsFor: 'accessing' stamp: 'JT 6/8/2023 12:09:51'!
isbn

	^ isbn! !

!CartItem methodsFor: 'accessing' stamp: 'JT 6/5/2023 21:40:24'!
quantity

	^quantity! !


!CartItem methodsFor: 'comparing' stamp: 'JT 6/8/2023 12:09:51'!
= aCartItem

	^ isbn = aCartItem isbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartItem class' category: 'TusLibros-Ejercicio'!
CartItem class
	instanceVariableNames: ''!

!CartItem class methodsFor: 'instance creation' stamp: 'JT 6/5/2023 21:17:08'!
with: aQuantity of: aBook

	^self new initializeWith: aQuantity of: aBook ! !

!CartItem class methodsFor: 'instance creation' stamp: 'JT 6/5/2023 21:17:51'!
withOneOf: aBook

	^self with: 1 of: aBook! !
