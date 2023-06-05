!classDefinition: #MarsRover category: 'MarsRover2-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger observers positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRover methodsFor: 'initialization' stamp: 'JT 6/4/2023 22:31:28'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	positionObservers := OrderedCollection new.
	headingObservers := OrderedCollection new.! !


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


!MarsRover methodsFor: 'moving' stamp: 'JT 6/4/2023 22:35:07'!
moveBackward
	
	head moveBackward.
	self notifyPositionChanged.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'JT 6/4/2023 22:35:07'!
moveForward
	
	head moveForward.
	self notifyPositionChanged.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:50:29'!
headEast
	
	head := MarsRoverHeadingEast for: self.! !

!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:50:26'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.! !

!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:50:23'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.! !

!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:50:19'!
headWest
	
	head := MarsRoverHeadingWest for: self.! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/4/2023 22:41:37'!
rotateLeft
	
	head rotateLeft.
	self notifyHeadingChanged.
	
	 
	
	
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'JT 6/4/2023 22:41:37'!
rotateRight
	
	head rotateRight.
	self notifyHeadingChanged.! !


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


!MarsRover methodsFor: 'observers' stamp: 'JT 6/4/2023 22:31:12'!
attachToHeadingChanges: aMarsRoverObserver

	headingObservers add: aMarsRoverObserver! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/4/2023 22:44:52'!
attachToPositionChanges: aMarsRoverObserver

	positionObservers add: aMarsRoverObserver! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/4/2023 22:42:30'!
notifyHeadingChanged

	headingObservers do: [:aHeadingObserver | head notifyTo: aHeadingObserver].! !

!MarsRover methodsFor: 'observers' stamp: 'JT 6/4/2023 22:46:27'!
notifyPositionChanged

	positionObservers do: [:aPositionObserver | aPositionObserver notifyPositionChangedTo: position].! !


!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover2-Ejercicio'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover2-Ejercicio'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRoverHeading methodsFor: 'observers' stamp: 'JT 6/4/2023 22:43:13'!
notifyTo: aHeadingObserver

	self subclassResponsibility ! !


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

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover2-Ejercicio'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover2-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

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


!MarsRoverHeadingEast methodsFor: 'observers' stamp: 'JT 6/4/2023 22:43:30'!
notifyTo: aHeadingObserver

	aHeadingObserver notifyNowHeadingEast! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover2-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

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


!MarsRoverHeadingNorth methodsFor: 'observers' stamp: 'JT 6/4/2023 22:43:37'!
notifyTo: aHeadingObserver

	aHeadingObserver notifyNowHeadingNorth! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover2-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

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


!MarsRoverHeadingSouth methodsFor: 'observers' stamp: 'JT 6/4/2023 22:43:53'!
notifyTo: aHeadingObserver

	aHeadingObserver notifyNowHeadingSouth ! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover2-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

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


!MarsRoverHeadingWest methodsFor: 'observers' stamp: 'JT 6/4/2023 22:44:02'!
notifyTo: aHeadingObserver

	aHeadingObserver notifyNowHeadingWest! !


!classDefinition: #MarsRoverObserver category: 'MarsRover2-Ejercicio'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRoverObserver methodsFor: 'initialization' stamp: 'IV 6/4/2023 20:16:27'!
initializeForHeadingOf: aMarsRover

	self subscribeToHeadingChangesOf: aMarsRover.! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'IV 6/4/2023 20:16:31'!
initializeForPositionAndHeadingOf: aMarsRover

	self subscribeToPositionChangesOf: aMarsRover.
	self subscribeToHeadingChangesOf: aMarsRover.! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'IV 6/4/2023 20:16:33'!
initializeForPositionOf: aMarsRover

	self subscribeToPositionChangesOf: aMarsRover.! !


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

!MarsRoverObserver methodsFor: 'notifications' stamp: 'JT 6/4/2023 22:48:17'!
notifyPositionChangedTo: aNewPosition

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:47:23'!
value

	self subclassResponsibility ! !


!MarsRoverObserver methodsFor: 'subscriptions' stamp: 'JT 6/4/2023 22:28:44'!
subscribeToHeadingChangesOf: aMarsRover

	aMarsRover attachToHeadingChanges: self! !

!MarsRoverObserver methodsFor: 'subscriptions' stamp: 'JT 6/4/2023 22:29:25'!
subscribeToPositionChangesOf: aMarsRover

	aMarsRover attachToPositionChanges: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover2-Ejercicio'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'IV 6/4/2023 20:21:37'!
forHeadingOf: aMarsRover
	^self new initializeForHeadingOf: aMarsRover ! !

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'IV 6/4/2023 20:21:40'!
forPositionAndHeadingOf: aMarsRover
	^self new initializeForPositionAndHeadingOf: aMarsRover ! !

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'IV 6/4/2023 20:21:43'!
forPositionOf: aMarsRover
	^self new initializeForPositionOf: aMarsRover ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover2-Ejercicio'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'IV 6/3/2023 18:41:57'!
initialize
	lines := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/4/2023 20:05:52'!
notifyNowHeadingEast

	lines add: 'East'.! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/4/2023 20:05:57'!
notifyNowHeadingNorth

	lines add: 'North'.! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/4/2023 20:06:02'!
notifyNowHeadingSouth

	lines add: 'South'.! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/4/2023 20:06:07'!
notifyNowHeadingWest

	lines add: 'West'.! !

!MarsRoverLogger methodsFor: 'notifications' stamp: 'JT 6/4/2023 22:48:29'!
notifyPositionChangedTo: aNewPosition

	lines add: aNewPosition asString! !


!MarsRoverLogger methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:46:58'!
value

	^ lines! !


!classDefinition: #MarsRoverWindow category: 'MarsRover2-Ejercicio'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'IV 6/4/2023 20:19:13'!
initialize
	currentPosition := 'No information'.
	currentHeading := 'No information'.! !


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

!MarsRoverWindow methodsFor: 'notifications' stamp: 'JT 6/4/2023 22:46:27'!
notifyPositionChangedTo: aPosition

	currentPosition := aPosition.! !


!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/4/2023 20:19:59'!
headingStatus
	
	^'Heading: ', currentHeading asString.! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/4/2023 20:19:48'!
positionStatus

	^'Position: ', currentPosition asString.! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:56:24'!
value

	^self positionStatus, ', ', self headingStatus.! !
!classDefinition: #MarsRoverLoggersTest category: 'MarsRover2-Tests'!
TestCase subclass: #MarsRoverLoggersTest
	instanceVariableNames: 'marsRoverHeadingNorth marsRoverHeadingSouth marsRoverHeadingWest marsRoverHeadingEast'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Tests'!

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:05'!
test01LogForRoverThatHasntProcessedCommandsIsEmpty

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth
				   processing: ''.

	self assert: logger value isEmpty.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:23:53'!
test02LogForRoverThatMovesForwardHeadingNorthLogsNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth 
				   processing: 'f'.

	self assert: logger hasLine: '0@1'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:12'!
test03LogForRoverThatMovesForwardHeadingSouthLogsNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingSouth
				   processing: 'f'.

	self assert: logger hasLine: '0@ -1'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:17'!
test04LogForRoverThatMovesForwardHeadingWestLogsNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingWest
				   processing: 'f'.

	self assert: logger hasLine: '-1@0'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:22'!
test05LogForRoverThatMovesForwardHeadingEastLogsNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingEast
			  processing: 'f'.

	self assert: logger hasLine: '1@0'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:26'!
test06LogForRoverThatMovesBackwardHeadingNorthHasLineWithNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth
				   processing: 'b'.

	self assert: logger hasLine: '0@ -1'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:33'!
test07LogForRoverThatMovesBackwardHeadingSouthHasLineWithNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingSouth
				   processing: 'b'.

	self assert: logger hasLine: '0@1'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:39'!
test08LogForRoverThatMovesBackwardHeadingWestHasLineWithNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingWest
				   processing: 'b'.

	self assert: logger hasLine: '1@0'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:45'!
test09LogForRoverThatMovesBackwardHeadingEastHasLineWithNewPosition

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingEast
				   processing: 'b'.

	self assert: logger hasLine: '-1@0'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:51'!
test10LogForRoverThatRotatesRightHeadingNorthHasLineWithNewHeading

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth
				   processing: 'r'.

	self assert: logger hasLine: 'East'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:39:56'!
test11LogForRoverThatRotatesRightHeadingSouthHasLineWithNewHeading

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingSouth
				   processing: 'r'.

	self assert: logger hasLine: 'West'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:01'!
test12LogForRoverThatRotatesRightHeadingWestHasLineWithNewHeading

	| logger |
		
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingWest
				   processing: 'r'.

	self assert: logger hasLine: 'North'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:08'!
test13LogForRoverThatRotatesRightHeadingEastHasLineWithNewHeading

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingEast
				   processing: 'r'.

	self assert: logger hasLine: 'South'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:12'!
test14LogForRoverThatRotatesLeftHeadingNorthHasLineWithNewHeading

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth
				   processing: 'l'.

	self assert: logger hasLine: 'West'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:18'!
test15LogForRoverThatRotatesLeftHeadingSouthHasLineWithNewHeading

	| logger |
	
	logger := self positionAndHeadingLoggerFor: marsRoverHeadingSouth
				   processing: 'l'.

	self assert: logger hasLine: 'East'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:41:07'!
test16LogForRoverThatRotatesLeftHeadingWestHasLineWithNewHeading

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingWest
				   processing: 'l'.

	self assert: logger hasLine: 'South'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:41:11'!
test17LogForRoverThatRotatesLeftHeadingEastHasLineWithNewHeading

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingEast
				   processing: 'l'.

	self assert: logger hasLine: 'North'.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:41:16'!
test18LogForRoverThatProcessesMultipleCommandsHasLinesWithPositionsAndHeadings

	| logger |

	logger := self positionAndHeadingLoggerFor: marsRoverHeadingNorth
				   processing: 'frfrflbl'.

	self assert: logger hasLines: {
		'0@1'.
		'East'.
		'1@1'.
		'South'.
		'1@0'.
		'East'.
		'0@0'.
		'North'
	}! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:42'!
test19PositionLogForRoverThatProcessesMultipleCommandsHasLinesWithPositionsOnly

	| logger |
	
	logger := self positionLoggerFor: marsRoverHeadingNorth
				   processing: 'frfrflbl'.
	
	self assert: logger hasLines: {
		'0@1'.
		'1@1'.
		'1@0'.
		'0@0'.
	}.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 23:40:48'!
test20HeadingLogForRoverThatProcessesMultipleCommandsHasLinesWithHeadingsOnly

	| logger |
	
	logger := self headingLoggerFor: marsRoverHeadingNorth
				   processing: 'frfrflbl'.
	
	self assert: logger hasLines: {
		'East'.
		'South'.
		'East'.
		'North'
	}! !


!MarsRoverLoggersTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/4/2023 23:16:12'!
setUp

	marsRoverHeadingNorth := MarsRover at: 0@0 heading: self north.
	marsRoverHeadingSouth := MarsRover at: 0@0 heading: self south.
	marsRoverHeadingWest := MarsRover at: 0@0 heading: self west.
	marsRoverHeadingEast := MarsRover at: 0@0 heading: self east.! !


!MarsRoverLoggersTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 23:36:48'!
assert: aMarsRoverLogger hasLine: aLogLine

	self assert: aMarsRoverLogger hasLines: {aLogLine}! !

!MarsRoverLoggersTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 23:37:00'!
assert: aMarsRoverLogger hasLines: aCollectionOfStrings

	| logLines |
	logLines := aMarsRoverLogger value.
	
	self assert: aCollectionOfStrings size equals: logLines size.
	aCollectionOfStrings with: logLines do: [:aString :aLogLine |
		self assert: aString equals: aLogLine
	]! !


!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:40'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'JT 6/4/2023 00:38:05'!
north

	^ MarsRoverHeadingNorth! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:50'!
south

	^ MarsRoverHeadingSouth! !

!MarsRoverLoggersTest methodsFor: 'headings' stamp: 'IV 6/3/2023 19:38:53'!
west

	^ MarsRoverHeadingWest! !


!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'JT 6/4/2023 23:19:11'!
headingLoggerFor: aMarsRover processing: aCommandsString

	| logger |
	logger := MarsRoverLogger forHeadingOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ logger! !

!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'JT 6/4/2023 23:18:25'!
positionAndHeadingLoggerFor: aMarsRover processing: aCommandsString

	| logger |
	logger := MarsRoverLogger forPositionAndHeadingOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ logger! !

!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'JT 6/4/2023 23:18:59'!
positionLoggerFor: aMarsRover processing: aCommandsString

	| logger |
	logger := MarsRoverLogger forPositionOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ logger! !


!classDefinition: #MarsRoverTest category: 'MarsRover2-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Tests'!

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


!classDefinition: #MarsRoverWindowTest category: 'MarsRover2-Tests'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: 'marsRoverHeadingNorth marsRoverHeadingWest marsRoverHeadingEast marsRoverHeadingSouth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Tests'!

!MarsRoverWindowTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/5/2023 00:15:28'!
setUp

	marsRoverHeadingNorth := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	marsRoverHeadingSouth := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	marsRoverHeadingWest := MarsRover at: 0@0 heading: MarsRoverHeadingWest.
	marsRoverHeadingEast := MarsRover at: 0@0 heading: MarsRoverHeadingEast.! !


!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:18:14'!
test01WindowForRoverThatHasntProcessedCommandsShowsNoInformation

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: ''.

	self assertWindowHasNoPositionNorHeadingInformation: window.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:13:42'!
test02WindowForRoverThatMovesForwardHeadingNorthShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: 'f'.
	
	self assert: window hasNoHeadingButHasPosition: '0@1'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:15:40'!
test03WindowForRoverThatMovesForwardHeadingSouthShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingSouth processing: 'f'.
	
	self assert: window hasNoHeadingButHasPosition: '0@ -1'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:16:37'!
test04WindowForRoverThatMovesForwardHeadingWestShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingWest processing: 'f'.
	
	self assert: window hasNoHeadingButHasPosition: '-1@0'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:17:01'!
test05WindowForRoverThatMovesForwardHeadingEastShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingEast processing: 'f'.
	
	self assert: window hasNoHeadingButHasPosition: '1@0'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:20:02'!
test06CompleteWindowForRoverThatMovesBackwardHeadingNorthShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: 'b'.

	self assert: window hasNoHeadingButHasPosition: '0@ -1'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:21:11'!
test07CompleteWindowForRoverThatMovesBackwardHeadingSouthShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingSouth processing: 'b'.

	self assert: window hasNoHeadingButHasPosition: '0@1'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:22:42'!
test08CompleteWindowForRoverThatMovesBackwardHeadingWestShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingWest processing: 'b'.

	self assert: window hasNoHeadingButHasPosition: '1@0'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:22:35'!
test09CompleteWindowForRoverThatMovesBackwardHeadingEastShowsCurrentPosition

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingEast processing: 'b'.

	self assert: window hasNoHeadingButHasPosition: '-1@0'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:24:00'!
test10WindowForRoverThatRotatesRightHeadingNorthShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: 'r'.

	self assert: window hasNoPositionButHasHeading: 'East'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:24:31'!
test11WindowForRoverThatRotatesRightHeadingSouthShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingSouth processing: 'r'.

	self assert: window hasNoPositionButHasHeading: 'West'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:24:48'!
test12WindowForRoverThatRotatesRightHeadingWestShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingWest processing: 'r'.

	self assert: window hasNoPositionButHasHeading: 'North'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:25:12'!
test13WindowForRoverThatRotatesRightHeadingEastShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingEast processing: 'r'.

	self assert: window hasNoPositionButHasHeading: 'South'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:26:33'!
test14WindowForRoverThatRotatesLeftHeadingNorthShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: 'l'.

	self assert: window hasNoPositionButHasHeading: 'West'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:26:53'!
test15WindowForRoverThatRotatesLeftHeadingSouthShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingSouth processing: 'l'.

	self assert: window hasNoPositionButHasHeading: 'East'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:27:51'!
test16WindowForRoverThatRotatesLeftHeadingWestShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingWest processing: 'l'.
	self assert: window hasNoPositionButHasHeading: 'South'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:28:13'!
test17WindowForRoverThatRotatesLeftHeadingEastShowsCurrentHeadingDirection

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingEast processing: 'l'.
	self assert: window hasNoPositionButHasHeading: 'North'.! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:34:57'!
test18WindowForRoverThatProcessesMultipleCommandsShowsCurrentPositionAndHeading

	| window |
	
	window := self positionAndHeadingWindowFor: marsRoverHeadingNorth processing: 'frflb'.

	self assert: window hasPosition: '1@0' andHeading: 'North'! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:36:09'!
test19PositionWindowForRoverThatProcessesMultipleCommandsShowsCurrentPosition

	| window |
	
	window := self positionWindowFor: marsRoverHeadingNorth processing: 'frflb'.

	self assert: window hasPosition: '1@0' andHeading: 'No information'! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'JT 6/5/2023 00:39:56'!
test20HeadingWindowForRoverThatProcessesMultipleCommandsShowsCurrentHeading

	| window |
	
	window := self headingWindowFor: marsRoverHeadingNorth processing: 'frflb'.

	self assert: window hasPosition: 'No information' andHeading: 'North'! !


!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'JT 6/5/2023 00:00:49'!
assert: aMarsRoverWindow hasNoHeadingButHasPosition: aPosition

	self assert: aMarsRoverWindow hasPosition: aPosition andHeading: 'No information'.! !

!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'JT 6/5/2023 00:01:23'!
assert: aMarsRoverWindow hasNoPositionButHasHeading: aHeading

	self assert: aMarsRoverWindow hasPosition: 'No information' andHeading: aHeading.! !

!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 23:57:09'!
assert: aMarsRoverWindow hasPosition: aPosition andHeading: aHeading

	| expectedStatus |
	expectedStatus := 'Position: ' , aPosition , ', Heading: ' , aHeading.
	self assert: expectedStatus equals: aMarsRoverWindow value.! !

!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 23:58:09'!
assertWindowHasNoPositionNorHeadingInformation: aMarsRoverWindow

	self assert: aMarsRoverWindow hasPosition: 'No information' andHeading: 'No information'! !


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


!MarsRoverWindowTest methodsFor: 'windows' stamp: 'JT 6/5/2023 00:39:05'!
headingWindowFor: aMarsRover processing: aCommandsString

	| window |
	window := MarsRoverWindow forHeadingOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ window! !

!MarsRoverWindowTest methodsFor: 'windows' stamp: 'JT 6/5/2023 00:09:21'!
positionAndHeadingWindowFor: aMarsRover processing: aCommandsString

	| window |
	window := MarsRoverWindow forPositionAndHeadingOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ window! !

!MarsRoverWindowTest methodsFor: 'windows' stamp: 'JT 6/5/2023 00:38:22'!
positionWindowFor: aMarsRover processing: aCommandsString

	| window |
	window := MarsRoverWindow forPositionOf: aMarsRover.
	aMarsRover process: aCommandsString.
	
	^ window! !
