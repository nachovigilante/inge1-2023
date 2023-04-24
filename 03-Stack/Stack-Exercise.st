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
	instanceVariableNames: 'emptyStack firstSentence secondSentence thirdSentence prefixThatMatchesFirstAndThird prefixThatMatchesNone emptySentenceFinder badPrefixWithSpace sentenceFinderWithThreeSentences sentenceFinderWithOneSentence prefixThatMatchesFirst sentenceFinderWithThreeUpperCaseSentences prefixWithLowerCase sentenceFinderWithAllSentences substringThatMatchesMidSecondSentence'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JT 4/24/2023 12:23:28'!
setUp
	| allUpperCaseSentences allLowerCaseSentences allSentences oneSentence |
	firstSentence := 'hoy es viernes'.
	secondSentence := 'ayer fue jueves'.
	thirdSentence := 'hola mundo'.
	
	allLowerCaseSentences := {firstSentence. secondSentence. thirdSentence}.
	allUpperCaseSentences := allLowerCaseSentences collect:[:sentence | sentence asUppercase].
	oneSentence := {firstSentence}.
	allSentences := allLowerCaseSentences , allUpperCaseSentences.
	
	emptySentenceFinder := SentenceFinderByPrefix new.
	sentenceFinderWithThreeSentences := SentenceFinderByPrefix for: allLowerCaseSentences.
	sentenceFinderWithAllSentences := SentenceFinderByPrefix for: allSentences.
	sentenceFinderWithOneSentence := SentenceFinderByPrefix for: oneSentence.
	
	prefixThatMatchesFirst := 'hoy'.
	prefixThatMatchesFirstAndThird := 'ho'.
	prefixThatMatchesNone := 'abcdefg'.
	substringThatMatchesMidSecondSentence := 'jue'.
	badPrefixWithSpace := 'bad '.! !


!SentenceFinderByPrefixTest methodsFor: 'test stack' stamp: 'JT 4/24/2023 12:55:47'!
test03EmptyStackRemainsEmptyAfterFind
	
	emptySentenceFinder find: prefixThatMatchesNone.
	
	self assert: emptySentenceFinder sentenceStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test stack' stamp: 'JT 4/24/2023 12:55:46'!
test04StackWithOneSentenceKeepsSameSentenceAfterFind

	sentenceFinderWithOneSentence find: prefixThatMatchesNone.
	
	self assert: sentenceFinderWithOneSentence sentenceStack pop equals: firstSentence.
	self assert: sentenceFinderWithOneSentence sentenceStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test stack' stamp: 'JT 4/24/2023 12:55:47'!
test05StackWithMultipleSentencesKeepsAllSentencesInSameOrderAfterFind
	sentenceFinderWithThreeSentences find: prefixThatMatchesNone.
	
	self assert: sentenceFinderWithThreeSentences sentenceStack pop equals: thirdSentence.
	self assert: sentenceFinderWithThreeSentences sentenceStack pop equals: secondSentence.
	self assert: sentenceFinderWithThreeSentences sentenceStack pop equals: firstSentence.
	self assert: sentenceFinderWithThreeSentences sentenceStack isEmpty.! !


!SentenceFinderByPrefixTest methodsFor: 'test prefix' stamp: 'JT 4/24/2023 12:55:46'!
test01CanNotSearchByEmptyPrefix
	
	self
		should: [ emptySentenceFinder find: '' ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test prefix' stamp: 'JT 4/24/2023 12:55:46'!
test02CanNotSearchByPrefixWithWhitespace

	self
		should: [ emptySentenceFinder find: badPrefixWithSpace ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithWhitespaceErrorDescription ]! !


!SentenceFinderByPrefixTest methodsFor: 'test case sensitivity' stamp: 'JT 4/24/2023 12:55:47'!
test11PrefixWithUpperCaseDoesntMatchSentenceWithLowerCase
	| sentencesMatchingPrefix |
	sentencesMatchingPrefix := sentenceFinderWithAllSentences find: prefixThatMatchesFirstAndThird asUppercase.
	
	self assert: (sentencesMatchingPrefix includes: firstSentence asUppercase).
	self assert: (sentencesMatchingPrefix includes: thirdSentence asUppercase).
	self assert: sentencesMatchingPrefix size equals: 2.! !

!SentenceFinderByPrefixTest methodsFor: 'test case sensitivity' stamp: 'JT 4/24/2023 12:55:46'!
test12PrefixWithLowerCaseDoesntMatchSentenceWithUpperCase
	| sentencesMatchingPrefix |
	sentencesMatchingPrefix := sentenceFinderWithAllSentences find: prefixThatMatchesFirstAndThird .
	
	self assert: (sentencesMatchingPrefix includes: firstSentence).
	self assert: (sentencesMatchingPrefix includes: thirdSentence).
	self assert: sentencesMatchingPrefix size equals: 2.! !


!SentenceFinderByPrefixTest methodsFor: 'test find' stamp: 'JT 4/24/2023 12:55:47'!
test06FindOnEmptyStackShouldReturnEmptyCollection
	| sentencesMatchingPrefix |

	sentencesMatchingPrefix := emptySentenceFinder find: prefixThatMatchesNone.
	
	self assert: sentencesMatchingPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test find' stamp: 'JT 4/24/2023 12:55:47'!
test07FindPrefixMatchingOneSentenceReturnsCollectionWithThatSentence
	| sentencesMatchingPrefix |
	
	sentencesMatchingPrefix := sentenceFinderWithThreeSentences find: prefixThatMatchesFirst.
	
	self assert: (sentencesMatchingPrefix includes: firstSentence).
	self assert: sentencesMatchingPrefix size equals: 1! !

!SentenceFinderByPrefixTest methodsFor: 'test find' stamp: 'JT 4/24/2023 12:55:46'!
test08FindPrefixMatchingMultipleSentencesReturnsCollectionWithThoseSentences
	| sentencesMatchingPrefix |
	
	sentencesMatchingPrefix := sentenceFinderWithThreeSentences find: prefixThatMatchesFirstAndThird.
	
	self assert: (sentencesMatchingPrefix includes: firstSentence).
	self assert: (sentencesMatchingPrefix includes: thirdSentence).
	self assert: (sentencesMatchingPrefix size) equals: 2.! !

!SentenceFinderByPrefixTest methodsFor: 'test find' stamp: 'JT 4/24/2023 12:55:47'!
test09FindPrefixMatchingNoneReturnsEmptyCollection
	| sentencesMatchingPrefix |
	
	sentencesMatchingPrefix := sentenceFinderWithThreeSentences find: prefixThatMatchesNone.
	
	self assert: sentencesMatchingPrefix isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test find' stamp: 'JT 4/24/2023 12:55:47'!
test10FindPrefixMatchingMidSentenceReturnsEmptyCollection

	| sentencesMatchingPrefix |
	
	sentencesMatchingPrefix := sentenceFinderWithThreeSentences find: substringThatMatchesMidSecondSentence.
	
	self assert: sentencesMatchingPrefix isEmpty.! !


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


!OOStack methodsFor: 'printing' stamp: 'JT 4/24/2023 13:32:14'!
printOn: aStream
	aStream nextPutAll: 'an OOStack('.
	state printOn: aStream.
	aStream nextPut: $).! !


!OOStack methodsFor: 'testing' stamp: 'IV 4/21/2023 12:51:15'!
isEmpty
	^state isEmpty! !


!OOStack methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:41:44'!
size
	^state elementCount ! !

!OOStack methodsFor: 'accessing' stamp: 'JT 4/24/2023 13:41:42'!
top
	state ifEmpty: [self error: self class stackEmptyErrorDescription].
	
	^state value! !

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

!OOStackState methodsFor: 'testing' stamp: 'JT 4/24/2023 13:40:18'!
ifEmpty: aBlockToRunIfEmpty
	self subclassResponsibility ! !

!OOStackState methodsFor: 'testing' stamp: 'IV 4/21/2023 12:51:45'!
isEmpty
	self subclassResponsibility ! !


!OOStackState methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:45:10'!
elementCount
	self subclassResponsibility ! !

!OOStackState methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:31:19'!
value
	self subclassResponsibility ! !


!OOStackState methodsFor: 'printing' stamp: 'JT 4/22/2023 20:40:45'!
printOn: aStream
	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyState category: 'Stack-Exercise'!
OOStackState subclass: #OOStackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'testing' stamp: 'JT 4/24/2023 13:42:26'!
ifEmpty: aBlockToRunIfEmpty
	^ aBlockToRunIfEmpty value.! !

!OOStackEmptyState methodsFor: 'testing' stamp: 'IV 4/21/2023 13:01:23'!
isEmpty
	^true! !


!OOStackEmptyState methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:41:26'!
elementCount
	^0! !


!OOStackEmptyState methodsFor: 'printing' stamp: 'JT 4/22/2023 20:44:38'!
printOn: aStream
	aStream nextPutAll: '[]'.! !


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


!OOStackNonEmptyState methodsFor: 'printing' stamp: 'JT 4/24/2023 13:37:41'!
printOn: aStream
	aStream nextPut: $[.
	value printOn: aStream.
	aStream nextPutAll: ']->'.
		
	previousState printOn: aStream.! !


!OOStackNonEmptyState methodsFor: 'testing' stamp: 'JT 4/24/2023 13:42:51'!
ifEmpty: aBlockToRunIfEmpty
! !

!OOStackNonEmptyState methodsFor: 'testing' stamp: 'IV 4/21/2023 13:01:19'!
isEmpty
	^false! !


!OOStackNonEmptyState methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:41:17'!
elementCount
	^previousState elementCount + 1! !

!OOStackNonEmptyState methodsFor: 'accessing' stamp: 'IV 4/21/2023 13:21:05'!
previousState
	^previousState! !

!OOStackNonEmptyState methodsFor: 'accessing' stamp: 'IV 4/21/2023 16:31:19'!
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
	instanceVariableNames: 'sentenceStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'JT 4/24/2023 13:00:09'!
find: aPrefixToMatch
	self verifyThatPrefixIsValid: aPrefixToMatch.	
	
	^ self withFirstSentence:[:aSentence | | sentenceHasPrefix restOfMatchingSentences | 
		sentenceHasPrefix := self does: aSentence havePrefix: aPrefixToMatch.
		restOfMatchingSentences := self find: aPrefixToMatch.	
		sentenceHasPrefix ifTrue: [ restOfMatchingSentences add: aSentence ].
		restOfMatchingSentences
	] ifNone: [OrderedCollection new].! !


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


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'JT 4/22/2023 19:51:21'!
initialize
	sentenceStack := OOStack new.! !

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'JT 4/22/2023 19:49:10'!
initializeFor: aSentenceCollection

	aSentenceCollection do: [:sentence | sentenceStack push: sentence].! !


!SentenceFinderByPrefix methodsFor: 'private - integrity' stamp: 'JT 4/24/2023 13:04:43'!
withFirstSentence: aNonReturningBlockThatUsesASentence ifNone: aBlockToRunWhenStackHasNoSentences
	"Access stack sentences while keeping the stack intact."
	| blockResult firstSentence |
	^ sentenceStack isEmpty
		ifTrue: [ aBlockToRunWhenStackHasNoSentences value ]
		ifFalse: [
			firstSentence := sentenceStack pop.		
			blockResult := aNonReturningBlockThatUsesASentence value: firstSentence.
			sentenceStack push: firstSentence.
			blockResult
		].! !


!SentenceFinderByPrefix methodsFor: 'private - matching' stamp: 'JT 4/24/2023 12:51:01'!
does: aSentence havePrefix: aPrefixToMatch.
	^ aSentence is: aPrefixToMatch substringAt: 1.! !


!SentenceFinderByPrefix methodsFor: 'private - accessing for tests' stamp: 'JT 4/22/2023 19:58:27'!
sentenceStack
	^ sentenceStack ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'JT 4/22/2023 20:03:08'!
for: aSentenceCollection
	^ self new initializeFor: aSentenceCollection.! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IV 4/21/2023 18:00:38'!
prefixEmptyErrorDescription
	^'Cannot find with empty prefix'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'IV 4/21/2023 18:06:42'!
prefixWithWhitespaceErrorDescription
	^'Cannot find with a prefix containing whitespaces'! !
