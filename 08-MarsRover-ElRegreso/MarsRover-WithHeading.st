!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #ObserversTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserversTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserversTest methodsFor: 'headings' stamp: 'JT 6/1/2023 20:30:20'!
east

	^ MarsRoverHeadingEast! !

!ObserversTest methodsFor: 'headings' stamp: 'JT 6/1/2023 20:30:16'!
north

	^ MarsRoverHeadingNorth ! !

!ObserversTest methodsFor: 'headings' stamp: 'JT 6/1/2023 20:30:30'!
south

	^ MarsRoverHeadingSouth! !

!ObserversTest methodsFor: 'headings' stamp: 'JT 6/1/2023 20:30:25'!
west

	^ MarsRoverHeadingWest! !


!ObserversTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 21:39:34'!
assertArray: anArray equalsCollection: aCollection

	self assert: anArray size equals: aCollection size.
	anArray with: aCollection do: [:arrayElement :collectionElement |
		self assert: arrayElement equals: collectionElement
	].! !


!ObserversTest methodsFor: 'tests' stamp: 'JT 6/1/2023 21:51:39'!
test01LogForRoverThatHasntProcessedCommandsIsEmpty

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	marsRover process: ''.
	
	logger := MarsRoverLogger for: marsRover.
	
	self assert: logger lines isEmpty.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 13:56:09'!
test02LogForRoverThatMovesForwardHasLineWithNewPosition

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger for: marsRover.
	
	marsRover process: 'f'.

	self assertArray: { '(0,1)' } equalsCollection: logger lines.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 13:56:29'!
test03LogForRoverThatMovesBackwardHasLineWithNewPosition

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger for: marsRover.
	
	marsRover process: 'b'.

	self assertArray: { '(0,-1)' } equalsCollection: logger lines.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 13:57:52'!
test04LogForRoverThatRotatesRightHasLineWithNewHeading

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger for: marsRover.
	
	marsRover process: 'r'.

	self assertArray: { 'East' } equalsCollection: logger lines.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 13:58:08'!
test05LogForRoverThatRotatesLeftHasLineWithNewHeading

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger for: marsRover.
	
	marsRover process: 'l'.
	
	self assertArray: { 'West' } equalsCollection: logger lines.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 14:15:07'!
test06LogForRoverThatProcessesMultipleCommandsHasLinesWithPositionsAndHeadings

	| marsRover logger |
	marsRover := MarsRover at: 0@0 heading: self north.
	logger := MarsRoverLogger for: marsRover.
	
	marsRover process: 'frflb'.
	
	self assertArray: {
		'(0,1)'.
		'East'.
		'(1,1)'.
		'North'.
		'(1,0)' }
		equalsCollection: logger lines.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/2/2023 21:20:03'!
test07WindowForRoverThatHasntProcessedCommandsIsEmpty

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	marsRover process: ''.

	window := MarsRoverWindow for: marsRover.

	self assert: '' equals: window status.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/3/2023 00:13:15'!
test08WindowForRoverThatMovesBackwardsShowsCurrentPosition

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'f'.

	self assert: '(0,1)' equals: window currentPosition.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/3/2023 00:12:39'!
test09WindowForRoverThatMovesForwardShowsCurrentPosition

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'b'.

	self assert: '(0,-1)' equals: window currentPosition.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/3/2023 12:51:04'!
test10WindowForRoverThatRotatesRightShowsCurrentHeadingDirection

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'r'.

	self assert: 'Apuntando al Este' equals: window currentHeading.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/3/2023 12:53:27'!
test11WindowForRoverThatRotatesLeftShowsCurrentHeadingDirection

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'l'.

	self assert: 'Apuntando al Oeste' equals: window currentHeading.! !

!ObserversTest methodsFor: 'tests' stamp: 'JT 6/3/2023 12:55:40'!
test12WindowForRoverThatProcessesMultipleCommandsShowsCurrentPositionAndHeading

	| marsRover window |
	marsRover := MarsRover at: 0@0 heading: self north.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'frflb'.

	self assert: '(1,0)' equals: window currentPosition.
	self assert: 'Apuntando al Norte' equals: window currentHeading.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:06:27'!
notifyHeadingEast

	observers do: [:anObserver | anObserver headingEast].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:06:45'!
notifyHeadingNorth

	observers do: [:anObserver | anObserver headingNorth].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:06:51'!
notifyHeadingSouth

	observers do: [:anObserver | anObserver headingSouth].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:06:56'!
notifyHeadingWest

	observers do: [:anObserver | anObserver headingWest].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:10:53'!
notifyPosition: aPosition

	observers do: [:anObserver | anObserver movedTo: aPosition].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/2/2023 14:07:26'!
subscribe: anObserver

	observers add: anObserver! !


!MarsRover methodsFor: 'initialization' stamp: 'JT 6/2/2023 14:06:03'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	observers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'JT 6/1/2023 21:50:07'!
headEast
	
	head := MarsRoverHeadingEast for: self.

	self notifyHeadingEast.! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/1/2023 21:51:17'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	
	self notifyHeadingNorth.! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/1/2023 21:51:25'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	
	self notifyHeadingSouth.! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/1/2023 21:51:31'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	
	self notifyHeadingWest.! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/1/2023 21:45:00'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'JT 6/2/2023 14:08:28'!
moveBackward
	
	head moveBackward.
	self notifyPosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'JT 6/2/2023 14:08:28'!
moveForward
	
	head moveForward.
	self notifyPosition: position.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !



"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !



!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'string' stamp: 'JT 6/1/2023 21:20:09'!
asString

	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'string' stamp: 'JT 6/1/2023 21:20:09'!
asString

	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'string' stamp: 'JT 6/1/2023 21:20:09'!
asString

	self subclassResponsibility ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'marsRover lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'JT 6/2/2023 14:07:26'!
initializeFor: aMarsRover

	lines := OrderedCollection new.
	marsRover := aMarsRover.
	
	marsRover subscribe: self.! !


!MarsRoverLogger methodsFor: 'lines' stamp: 'JT 6/1/2023 20:59:11'!
lines

	^ lines! !


!MarsRoverLogger methodsFor: 'observations' stamp: 'JT 6/2/2023 14:07:42'!
headingEast

	lines add: 'East'.! !

!MarsRoverLogger methodsFor: 'observations' stamp: 'JT 6/2/2023 14:07:45'!
headingNorth

	lines add: 'North'.! !

!MarsRoverLogger methodsFor: 'observations' stamp: 'JT 6/2/2023 14:07:48'!
headingSouth

	lines add: 'South'.! !

!MarsRoverLogger methodsFor: 'observations' stamp: 'JT 6/2/2023 14:07:51'!
headingWest

	lines add: 'West'.! !

!MarsRoverLogger methodsFor: 'observations' stamp: 'JT 6/2/2023 14:11:08'!
movedTo: aPosition

	lines add: '(' , aPosition x asString , ',' , aPosition y asString , ')'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'JT 6/1/2023 20:43:45'!
for: aMarsRover 
	^self new initializeFor: aMarsRover! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRover currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'JT 6/2/2023 21:36:34'!
initializeFor: aMarsRover
	marsRover := aMarsRover.
	
	marsRover subscribe: self.! !


!MarsRoverWindow methodsFor: 'status' stamp: 'JT 6/3/2023 12:52:39'!
currentHeading
	^currentHeading! !

!MarsRoverWindow methodsFor: 'status' stamp: 'JT 6/3/2023 00:13:31'!
currentPosition
	currentPosition ifNil: [^''].
	
	^ '(' , currentPosition x asString , ',' , currentPosition y asString , ')'! !


!MarsRoverWindow methodsFor: 'observations' stamp: 'JT 6/3/2023 12:52:22'!
headingEast
	currentHeading := 'Apuntando al Este'.! !

!MarsRoverWindow methodsFor: 'observations' stamp: 'JT 6/3/2023 12:56:01'!
headingNorth
	currentHeading := 'Apuntando al Norte'! !

!MarsRoverWindow methodsFor: 'observations' stamp: 'JT 6/3/2023 12:56:16'!
headingSouth
	currentHeading := 'Apuntando al Sur'.! !

!MarsRoverWindow methodsFor: 'observations' stamp: 'JT 6/3/2023 12:53:47'!
headingWest
	currentHeading := 'Apuntando al Oeste'! !

!MarsRoverWindow methodsFor: 'observations' stamp: 'JT 6/3/2023 00:12:54'!
movedTo: aPosition

	currentPosition := aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'JT 6/1/2023 20:48:19'!
for: aMarsRover
	^self new initializeFor: aMarsRover ! !
