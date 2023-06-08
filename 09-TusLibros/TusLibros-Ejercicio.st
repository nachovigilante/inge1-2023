!classDefinition: #TusLibrosTest category: 'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'catalog cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/8/2023 18:41:27'!
setUp
	catalog := Dictionary newFromPairs: {
		'isbn1'. 10 * peso.
		'isbn2'. 20 * peso.
		'isbn3'. 30 * peso }.
	cart := Cart using: catalog.! !


!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/5/2023 20:12:23'!
test01NewCartIsEmpty

	self assert: Cart new isEmpty.
	
	

! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 11:25:46'!
test02CartWithBookIsNotEmpty

	cart addOneOf: 'isbn1'.
	
	self deny: cart isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 18:49:11'!
test03CartWithBookListsBookWithAQuantityOfOne

	| bookISBN |
	bookISBN := 'isbn1'.
	cart addOneOf: bookISBN.
	
	self assert: cart items equals: ((Bag new) add: bookISBN; yourself).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'JT 6/8/2023 18:47:19'!
test04CartWithManyBooksListsAllOfThemWithEachQuantity

	| aBook anotherBook expectedItems |
	aBook := 'isbn1'.
	anotherBook := 'isbn2'.

	cart addOneOf: aBook;
		 add: 2 of: anotherBook.
	
	expectedItems := Bag new.
	expectedItems add: aBook;
				  add: anotherBook withOccurrences: 2.
		
	self assert: cart items equals: expectedItems.! !

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


!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'items bookCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'JT 6/8/2023 18:42:16'!
initialize

	items := Bag new.
	bookCatalog := Dictionary new.! !

!Cart methodsFor: 'initialization' stamp: 'JT 6/8/2023 11:19:25'!
initializeUsing: aBookCatalog
	bookCatalog := aBookCatalog.! !


!Cart methodsFor: 'testing' stamp: 'JT 6/5/2023 21:19:24'!
isEmpty

	^ items isEmpty.! !


!Cart methodsFor: 'adding' stamp: 'JT 6/8/2023 18:42:44'!
add: aQuantity of: anISBN

	self verifyValidISBN: anISBN.

	items add: anISBN withOccurrences: aQuantity.! !

!Cart methodsFor: 'adding' stamp: 'JT 6/8/2023 11:22:45'!
addOneOf: anISBN

	self add: 1 of: anISBN! !


!Cart methodsFor: 'items' stamp: 'JT 6/8/2023 18:42:59'!
items
	^ items copy.! !

!Cart methodsFor: 'items' stamp: 'JT 6/8/2023 18:49:33'!
totalPrice

	^ items inject: 0 * peso into: [:total :item | | price |
		price := bookCatalog at: item.
		total + price
	].! !


!Cart methodsFor: 'preconditions' stamp: 'JT 6/8/2023 12:07:08'!
signalInvalidISBN

	^ self error: self class invalidISBNErrorDescription! !

!Cart methodsFor: 'preconditions' stamp: 'JT 6/8/2023 18:44:27'!
verifyValidISBN: anISBN

	(bookCatalog includesKey: anISBN) ifFalse: [self signalInvalidISBN].! !

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
