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


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'IV 4/21/2023 13:28:50'!
pop
	| tail topElement |
	
	topElement := self top.
	tail := state previousState.
	state := tail.
	
	^topElement
	! !

!OOStack methodsFor: 'operations' stamp: 'IV 4/21/2023 13:16:09'!
push: anElement
	| newState |
	
	newState := OOStackNonEmptyState with: anElement from: state.
	state := newState
	
	! !

!OOStack methodsFor: 'operations' stamp: 'IV 4/21/2023 13:16:40'!
top
	^state element
	! !


!OOStack methodsFor: 'initialization' stamp: 'IV 4/21/2023 12:56:25'!
initialize
	state := OOStackEmptyState new! !


!OOStack methodsFor: 'testing' stamp: 'IV 4/21/2023 12:51:15'!
isEmpty
	^state isEmpty! !

!OOStack methodsFor: 'testing' stamp: 'IV 4/21/2023 13:25:38'!
size
	^state positionNumber! !

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

!OOStackState methodsFor: 'testing' stamp: 'IV 4/21/2023 12:51:45'!
isEmpty
	self subclassResponsibility ! !


!OOStackState methodsFor: 'operations' stamp: 'IV 4/21/2023 12:50:18'!
element
	self subclassResponsibility ! !

!OOStackState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:35:24'!
positionNumber
	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyState category: 'Stack-Exercise'!
OOStackState subclass: #OOStackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:30:56'!
element
	self error: OOStack stackEmptyErrorDescription! !

!OOStackEmptyState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:26:09'!
positionNumber
	^0! !


!OOStackEmptyState methodsFor: 'testing' stamp: 'IV 4/21/2023 13:01:23'!
isEmpty
	^true! !


!classDefinition: #OOStackNonEmptyState category: 'Stack-Exercise'!
OOStackState subclass: #OOStackNonEmptyState
	instanceVariableNames: 'previousState element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNonEmptyState methodsFor: 'initialization' stamp: 'IV 4/21/2023 13:13:25'!
element: anElement
	element := anElement! !

!OOStackNonEmptyState methodsFor: 'initialization' stamp: 'IV 4/21/2023 13:13:05'!
previousState: aState
	previousState := aState! !


!OOStackNonEmptyState methodsFor: 'testing' stamp: 'IV 4/21/2023 13:01:19'!
isEmpty
	^false! !


!OOStackNonEmptyState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:19:30'!
element
	^element! !

!OOStackNonEmptyState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:26:27'!
positionNumber
	^previousState positionNumber + 1! !

!OOStackNonEmptyState methodsFor: 'operations' stamp: 'IV 4/21/2023 13:21:05'!
previousState
	^previousState! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNonEmptyState class' category: 'Stack-Exercise'!
OOStackNonEmptyState class
	instanceVariableNames: ''!

!OOStackNonEmptyState class methodsFor: 'instance creation' stamp: 'IV 4/21/2023 13:13:47'!
with: anElement from: aState
	| newState |
	
	newState := OOStackNonEmptyState new.
	newState previousState: aState.
	newState element: anElement.
	
	^newState! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
