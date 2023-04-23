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
	instanceVariableNames: 'emptyStack firstSentence secondSentence thirdSentence prefixThatMatchesFirstAndThird prefixThatMatchesNone sentenceFinder badPrefixWithSpace'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JT 4/22/2023 18:27:57'!
setUp

	emptyStack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix new.

	firstSentence := 'hoy es viernes'.
	secondSentence := 'ayer fue jueves'.
	thirdSentence := 'hoy no llueve'.
	
	prefixThatMatchesFirstAndThird := 'hoy'.
	prefixThatMatchesNone := 'abcdefg'.
	badPrefixWithSpace := 'bad '.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:28:29'!
test01FindOnEmptyStackShouldReturnEmptyCollection
	| sentencesMatchingPrefix |

	sentencesMatchingPrefix := sentenceFinder find: prefixThatMatchesNone in: emptyStack.
	
	self assert: sentencesMatchingPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:17:55'!
test02FindEmptyPrefixGivesError
	
	self
		should: [ sentenceFinder find: '' in: emptyStack ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:20:09'!
test03FindPrefixWithWhitespaceGivesError

	self
		should: [ sentenceFinder find: badPrefixWithSpace in: emptyStack ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithWhitespaceErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:19:19'!
test04EmptyStackRemainsEmpty
	
	sentenceFinder find: prefixThatMatchesNone in: emptyStack.
	
	self assert: emptyStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:27:50'!
test05StackWithOneSentenceKeepsSameSentence
	| sentenceStack |
	
	sentenceStack := emptyStack push: firstSentence.
	
	sentenceFinder find: prefixThatMatchesNone in: sentenceStack.
	
	self assert: sentenceStack pop equals: firstSentence.
	self assert: sentenceStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:27:54'!
test06NonEmptyStackKeepsAllSentencesInSameOrder
	| sentenceStack |
	
	sentenceStack := emptyStack push: firstSentence.
	sentenceStack push: secondSentence.
	
	sentenceFinder find: prefixThatMatchesNone in: sentenceStack.
	
	self assert: sentenceStack pop equals: secondSentence.
	self assert: sentenceStack pop equals: firstSentence.
	self assert: sentenceStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:27:54'!
test07FindPrefixMatchingOneSentenceReturnsCollectionWithThatSentence
	| sentencesMatchingPrefix sentenceStack |
	
	sentenceStack := emptyStack push: firstSentence.
	sentenceStack push: secondSentence.
	sentencesMatchingPrefix := sentenceFinder find: prefixThatMatchesFirstAndThird in: sentenceStack.
	
	self assert: (sentencesMatchingPrefix includes: firstSentence).
	self assert: sentencesMatchingPrefix size equals: 1! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JT 4/22/2023 18:27:57'!
test08FindPrefixMatchingMultipleSentencesReturnsCollectionWithThoseSentences
	| sentenceStack sentencesMatchingPrefix |
	
	sentenceStack := emptyStack push: firstSentence.
	sentenceStack push: secondSentence.
	sentenceStack push: thirdSentence.
	
	sentencesMatchingPrefix := sentenceFinder find: prefixThatMatchesFirstAndThird in: sentenceStack.
	
	self assert: (sentencesMatchingPrefix includes: firstSentence).
	self assert: (sentencesMatchingPrefix includes: thirdSentence).
	self assert: (sentencesMatchingPrefix size) equals: 2.! !


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

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'JT 4/22/2023 18:12:11'!
find: aPrefixToMatch in: aSentencesStack
	| firstSentenceToTest firstSentenceHasPrefix restOfMatchingSentences |
	
	self verifyThatPrefixIsValid: aPrefixToMatch.	
	
	aSentencesStack isEmpty ifTrue: [^OrderedCollection new].	
	
	firstSentenceToTest := aSentencesStack pop.	
	firstSentenceHasPrefix := firstSentenceToTest is: aPrefixToMatch substringAt: 1.	
	restOfMatchingSentences := self find: aPrefixToMatch in: aSentencesStack.	

	firstSentenceHasPrefix ifTrue: [ restOfMatchingSentences add: firstSentenceToTest ].
	
	aSentencesStack push: firstSentenceToTest.
	
	^restOfMatchingSentences
	
	
	
	! !


!SentenceFinderByPrefix methodsFor: 'preconditions' stamp: 'JT 4/22/2023 18:07:17'!
verifyThatPrefixIsNotEmpty: aPrefixToValidate

	aPrefixToValidate isEmpty ifTrue: [ self error: self class prefixEmptyErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'preconditions' stamp: 'JT 4/22/2023 18:08:06'!
verifyThatPrefixIsValid: aPrefixToValidate

	self verifyThatPrefixIsNotEmpty: aPrefixToValidate.
	self verifyThatPrefixIsWord: aPrefixToValidate.! !

!SentenceFinderByPrefix methodsFor: 'preconditions' stamp: 'JT 4/22/2023 18:07:45'!
verifyThatPrefixIsWord: aPrefixToValidate

	(aPrefixToValidate includesSubString: ' ') ifTrue: [ self error: self class prefixWithWhitespaceErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IV 4/21/2023 18:00:38'!
prefixEmptyErrorDescription
	^'Cannot find with empty prefix'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IV 4/21/2023 18:06:42'!
prefixWithWhitespaceErrorDescription
	^'Cannot find with a prefix containing whitespaces'! !
