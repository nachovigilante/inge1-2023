!classDefinition: #MarsRoverLoggersTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:40'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:46'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:50'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:53'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverLoggersTest methodsFor: 'assertions' stamp: 'IV 6/3/2023 19:39:11'!
assertArray: anArray equalsCollection: aCollection

	self assert: anArray size equals: aCollection size.
	anArray with: aCollection do: [:arrayElement :collectionElement |
		self assert: arrayElement equals: collectionElement
	].! !


!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:34:54'!
test01CompleteLogForRoverThatHasntProcessedCommandsIsEmpty

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.

	self assert: logger value isEmpty.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:34:59'!
test02CompleteLogForRoverThatMovesForwardHasLineWithNewPosition

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0 
					heading: MarsRoverHeadingNorth 
					processing: 'f'.

	self assertArray: { '0@1' } equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:35:11'!
test03CompleteLogForRoverThatMovesBackwardHasLineWithNewPosition

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'b'.

	self assertArray: { '0@ -1' } equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:35:22'!
test04CompleteLogForRoverThatRotatesRightHasLineWithNewHeading

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'r'.

	self assertArray: { 'East' } equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:35:37'!
test05CompleteLogForRoverThatRotatesLeftHasLineWithNewHeading

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'l'.
		
	self assertArray: { 'West' } equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:35:42'!
test06CompleteLogForRoverThatProcessesMultipleCommandsHasLinesWithPositionsAndHeadings

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'frflb'.
	
	self assertArray: {
		'0@1'.
		'East'.
		'1@1'.
		'North'.
		'1@0' }
		equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:42:42'!
test07PositionLogForRoverThatProcessesMultipleCommandsHasLinesWithPositions

	| logger |
	
	logger := self positionLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'frflb'.
	
	self assertArray: {
		'0@1'.
		'1@1'.
		'1@0' }
		equalsCollection: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:46:11'!
test08HeadingLogForRoverThatProcessesMultipleCommandsHasLinesWithHeadings

	| logger |
	
	logger := self headingLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: 'frflb'.
	
	self assertArray: {'East'.'North'}
		equalsCollection: logger value.! !


!MarsRoverLoggersTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/3/2023 19:28:53'!
completeLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString  

	| marsRover logger |

	marsRover := self marsRoverAt: aPosition heading: aHeadingDirection.
	logger := MarsRoverCompleteLogger for: marsRover.

	marsRover process: aCommandsString.

	^ logger! !

!MarsRoverLoggersTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/3/2023 19:42:29'!
headingLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString  

	| marsRover logger |

	marsRover := self marsRoverAt: aPosition heading: aHeadingDirection.
	logger := MarsRoverHeadingLogger for: marsRover.

	marsRover process: aCommandsString.

	^ logger! !

!MarsRoverLoggersTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/3/2023 19:39:00'!
marsRoverAt: aPosition heading: aHeadingDirection
	| marsRover |
	
	marsRover := MarsRover at: aPosition heading: aHeadingDirection.
	
	^ marsRover.! !

!MarsRoverLoggersTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/3/2023 19:42:19'!
positionLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString  

	| marsRover logger |

	marsRover := self marsRoverAt: aPosition heading: aHeadingDirection.
	logger := MarsRoverPositionLogger for: marsRover.

	marsRover process: aCommandsString.

	^ logger! !


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


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:41'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:46'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:51'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverWindowTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:53'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverWindowTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/3/2023 19:39:00'!
marsRoverAt: aPosition heading: aHeadingDirection
	| marsRover |
	
	marsRover := MarsRover at: aPosition heading: aHeadingDirection.
	
	^ marsRover.! !


!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'IV 6/3/2023 19:39:11'!
assertArray: anArray equalsCollection: aCollection

	self assert: anArray size equals: aCollection size.
	anArray with: aCollection do: [:arrayElement :collectionElement |
		self assert: arrayElement equals: collectionElement
	].! !


!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:40:51'!
test01CompleteWindowForRoverThatHasntProcessedCommandsIsEmpty

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	marsRover process: ''.

	window := MarsRoverWindow for: marsRover.

	self assert: 'Position: No information, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:40:57'!
test02CompleteWindowForRoverThatMovesBackwardsShowsCurrentPosition

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'f'.

	self assert: 'Position: 0@1, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:41:01'!
test03CompleteWindowForRoverThatMovesForwardShowsCurrentPosition

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'b'.

	self assert: 'Position: 0@ -1, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:41:27'!
test04CompleteWindowForRoverThatRotatesRightShowsCurrentHeadingDirection

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'r'.

	self assert: 'Position: No information, Heading: East' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:41:11'!
test05CompleteWindowForRoverThatRotatesLeftShowsCurrentHeadingDirection

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'l'.

	self assert: 'Position: No information, Heading: West' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/3/2023 19:41:20'!
test06CompleteWindowForRoverThatProcessesMultipleCommandsShowsCurrentPositionAndHeading

	| marsRover window |
	marsRover := self completeLoggerForMarsRoverStartingAt: 0@0 heading: MarsRoverHeadingNorth processing: ''.
	window := MarsRoverWindow for: marsRover.

	marsRover process: 'frflb'.

	self assert: 'Position: 1@0, Heading: North' equals: (window value).! !


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


!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:31:44'!
newSuscriber: anObserver

	observers add: anObserver! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:45:55'!
notifyHeadingEast

	observers do: [:anObserver | anObserver notifyNowHeadingEast].! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:45:46'!
notifyHeadingNorth

	observers do: [:anObserver | anObserver notifyNowHeadingNorth].! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:45:37'!
notifyHeadingSouth

	observers do: [:anObserver | anObserver notifyNowHeadingSouth].! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:45:28'!
notifyHeadingWest

	observers do: [:anObserver | anObserver notifyNowHeadingWest].! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/3/2023 18:49:49'!
notifyPosition: aPosition

	observers do: [:anObserver | anObserver notifyMovedTo: aPosition].! !


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


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'initialization' stamp: 'IV 6/3/2023 18:40:35'!
initializeFor: aMarsRover
	marsRover := aMarsRover.
	
	marsRover newSuscriber: self.! !


!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:44:12'!
notifyMovedTo: aPosition

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:44:36'!
notifyNowHeadingEast

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:44:30'!
notifyNowHeadingNorth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:44:34'!
notifyNowHeadingSouth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:44:39'!
notifyNowHeadingWest

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:47:23'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'IV 6/3/2023 18:41:10'!
for: aMarsRover
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'IV 6/3/2023 18:41:57'!
initialize
	lines := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:46:58'!
value

	^ lines! !


!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:05:08'!
notifyMovedTo: aPosition

	self subclassResponsibility! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:14'!
notifyNowHeadingEast

	self subclassResponsibility! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:20'!
notifyNowHeadingNorth

	self subclassResponsibility! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:25'!
notifyNowHeadingSouth

	self subclassResponsibility! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:34'!
notifyNowHeadingWest

	self subclassResponsibility! !


!classDefinition: #MarsRoverCompleteLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverCompleteLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverCompleteLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:24:50'!
notifyMovedTo: aPosition

	lines add: aPosition asString! !

!MarsRoverCompleteLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:14'!
notifyNowHeadingEast

	lines add: 'East'.! !

!MarsRoverCompleteLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:20'!
notifyNowHeadingNorth

	lines add: 'North'.! !

!MarsRoverCompleteLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:25'!
notifyNowHeadingSouth

	lines add: 'South'.! !

!MarsRoverCompleteLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:34'!
notifyNowHeadingWest

	lines add: 'West'.! !


!classDefinition: #MarsRoverHeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverHeadingLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:05:22'!
notifyMovedTo: aPosition! !

!MarsRoverHeadingLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:14'!
notifyNowHeadingEast

	lines add: 'East'.! !

!MarsRoverHeadingLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:19'!
notifyNowHeadingNorth

	lines add: 'North'.! !

!MarsRoverHeadingLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:25'!
notifyNowHeadingSouth

	lines add: 'South'.! !

!MarsRoverHeadingLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:06:34'!
notifyNowHeadingWest

	lines add: 'West'.! !


!classDefinition: #MarsRoverPositionLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverPositionLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:44:11'!
notifyMovedTo: aPosition

	lines add: aPosition asString! !

!MarsRoverPositionLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:07:25'!
notifyNowHeadingEast
! !

!MarsRoverPositionLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:07:22'!
notifyNowHeadingNorth
! !

!MarsRoverPositionLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:07:19'!
notifyNowHeadingSouth
! !

!MarsRoverPositionLogger methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:07:15'!
notifyNowHeadingWest
! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:59:48'!
headingStatus

	| headingString |

	currentHeading ifNil: [headingString := 'No information'] ifNotNil: [ headingString := currentHeading asString ].
	
	^'Heading: ', headingString .! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:59:07'!
positionStatus

	| positionString |

	currentPosition ifNil: [positionString := 'No information'] ifNotNil: [ positionString := currentPosition asString ].
	
	^'Position: ', positionString.! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:56:24'!
value

	^self positionStatus, ', ', self headingStatus.! !


!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/3/2023 18:45:04'!
notifyMovedTo: aPosition

	currentPosition := aPosition.! !

!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:01:54'!
notifyNowHeadingEast
	currentHeading := 'East'.! !

!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:01:58'!
notifyNowHeadingNorth
	currentHeading := 'North'! !

!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:02:01'!
notifyNowHeadingSouth
	currentHeading := 'South'.! !

!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/3/2023 19:02:06'!
notifyNowHeadingWest
	currentHeading := 'West'! !
