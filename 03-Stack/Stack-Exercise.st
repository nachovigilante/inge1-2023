!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'IV 4/21/2023 17:08:31'!
test01! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'mutations' stamp: 'IV 4/21/2023 16:50:17'!
pop
	| topElement |
	
	topElement := self top.
	state := state previousState.
	
	^topElement
	! !

!OOStack methodsFor: 'mutations' stamp: 'IV 4/21/2023 16:34:54'!
push: anElementToBePushed
	state := OOStackNonEmptyState with: anElementToBePushed from: state
	
	! !


!OOStack methodsFor: 'initialization' stamp: 'IV 4/21/2023 12:56:25'!
initialize
	state := OOStackEmptyState new! !


!OOStack methodsFor: 'queries' stamp: 'IV 4/21/2023 12:51:15'!
isEmpty
	^state isEmpty! !

!OOStack methodsFor: 'queries' stamp: 'IV 4/21/2023 16:41:44'!
size
	^state elementCount ! !

!OOStack methodsFor: 'queries' stamp: 'IV 4/21/2023 16:31:31'!
top
	^state value
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:45:10'!
elementCount
	self subclassResponsibility ! !

!OOStackState methodsFor: 'queries' stamp: 'IV 4/21/2023 12:51:45'!
isEmpty
	self subclassResponsibility ! !

!OOStackState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:31:19'!
value
	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyState category: 'Stack-Exercise'!
OOStackState subclass: #OOStackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:41:26'!
elementCount
	^0! !

!OOStackEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 13:01:23'!
isEmpty
	^true! !

!OOStackEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:31:19'!
value
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackNonEmptyState category: 'Stack-Exercise'!
OOStackState subclass: #OOStackNonEmptyState
	instanceVariableNames: 'previousState value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNonEmptyState methodsFor: 'initialization' stamp: 'IV 4/21/2023 16:30:42'!
initializeWith: anElementToBeSavedAsValue from: aPreviousState
	value := anElementToBeSavedAsValue.
	previousState := aPreviousState! !


!OOStackNonEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:41:17'!
elementCount
	^previousState elementCount + 1! !

!OOStackNonEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 13:01:19'!
isEmpty
	^false! !

!OOStackNonEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 13:21:05'!
previousState
	^previousState! !

!OOStackNonEmptyState methodsFor: 'queries' stamp: 'IV 4/21/2023 16:31:19'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNonEmptyState class' category: 'Stack-Exercise'!
OOStackNonEmptyState class
	instanceVariableNames: ''!

!OOStackNonEmptyState class methodsFor: 'instance creation' stamp: 'IV 4/21/2023 16:33:16'!
with: anElementToBoSavedAsValue from: aPreviousState
	^OOStackNonEmptyState new initializeWith: anElementToBoSavedAsValue from: aPreviousState ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
