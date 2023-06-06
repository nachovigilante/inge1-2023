!classDefinition: #TusLibrosTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 20:12:23'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.
	
	

! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 21:16:07'!
test02CartWithBookIsNotEmpty

	| cart |
	cart := Cart new.
	cart addOneOf: Book new.
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 21:16:07'!
test03CartWithBookListsBookWithAQuantityOfOne

	| cart book |
	cart := Cart new.
	book := Book new.

	cart addOneOf: book.
	
	self assert: (cart items includes: (CartItem withOneOf: book)).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 21:16:07'!
test04CartWithManyBooksListsAllOfThemWithEachQuantity

	| cart aBook anotherBook |
	cart := Cart new.
	aBook := Book new.
	anotherBook := Book new.

	cart addOneOf: aBook.
	cart add: 2 of: anotherBook.
	
	self assert: cart hasItems: {
		CartItem withOneOf: aBook.
		CartItem with: 2 of: anotherBook.
	}.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 21:36:51'!
test05CartWithManyBooksCanCalculateTotalPriceOfItems

	| cart aBook anotherBook |
	cart := Cart new.
	aBook := Book forISBN: 'isbn1' priced: 10 * peso.
	anotherBook := Book forISBN: 'isbn2' priced: 10 * peso.

	cart addOneOf: aBook.
	cart add: 2 of: anotherBook.

	self assert: cart totalPrice equals: 30 * peso.! !


!TusLibrosTest methodsFor: 'assertions' stamp: 'JT 6/5/2023 21:07:10'!
assert: aCart hasItems: expectedCartItems

	| cartItems |
	cartItems := aCart items.
	
	self assert: cartItems size equals: expectedCartItems size.
	cartItems with: expectedCartItems do: [:cartItem :expectedCartItem |
		self assert: cartItem equals: expectedCartItem
	]! !


!classDefinition: #Book category: 'TusLibros-Ejercicio'!
Object subclass: #Book
	instanceVariableNames: 'isbn price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Book methodsFor: 'initialization' stamp: 'JT 6/5/2023 21:38:41'!
initializeForISBN: anISBN priced: aPrice 
	isbn := anISBN.
	price := aPrice.! !


!Book methodsFor: 'accessing' stamp: 'JT 6/5/2023 21:40:15'!
price
	^price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'TusLibros-Ejercicio'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'JT 6/5/2023 21:37:50'!
forISBN: aString priced: aSimpleMeasure 

	^self new initializeForISBN: aString priced: aSimpleMeasure ! !


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'JT 6/5/2023 21:19:16'!
initialize
	items := OrderedCollection new.! !


!Cart methodsFor: 'testing' stamp: 'JT 6/5/2023 21:19:24'!
isEmpty

	^ items isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'JT 6/5/2023 21:18:25'!
add: aQuantity of: aBook

	items add: (CartItem with: aQuantity of: aBook).! !

!Cart methodsFor: 'adding' stamp: 'JT 6/5/2023 21:18:18'!
addOneOf: aBook

	self add: 1 of: aBook! !


!Cart methodsFor: 'items' stamp: 'JT 6/5/2023 21:19:34'!
items
	^ items.! !

!Cart methodsFor: 'items' stamp: 'JT 6/5/2023 21:39:55'!
totalPrice

	^ items inject: 0 * peso into: [:total :item | total + (item book price * item quantity)]! !


!classDefinition: #CartItem category: 'TusLibros-Ejercicio'!
Object subclass: #CartItem
	instanceVariableNames: 'book quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartItem methodsFor: 'initialization' stamp: 'JT 6/5/2023 21:17:25'!
initializeWith: aQuantity of: aBook
	quantity := aQuantity.
	book := aBook.! !


!CartItem methodsFor: 'accessing' stamp: 'JT 6/5/2023 21:10:58'!
book

	^ book! !

!CartItem methodsFor: 'accessing' stamp: 'JT 6/5/2023 21:40:24'!
quantity

	^quantity! !


!CartItem methodsFor: 'comparing' stamp: 'JT 6/5/2023 21:10:50'!
= aCartItem

	^ book = aCartItem book! !

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
