!classDefinition: #MarsRover category: 'MarsRover2-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger observers positionNotifications headingNotifications'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'observers' stamp: 'IV 6/4/2023 19:35:45'!
addHeadingNotification: aNotification

	headingNotifications add: aNotification! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/4/2023 19:36:03'!
addPositionNotification: aNotification

	positionNotifications add: aNotification! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/4/2023 19:52:30'!
notifyHeading

	headingNotifications do: [:aNotification | aNotification value: head].! !

!MarsRover methodsFor: 'observers' stamp: 'IV 6/4/2023 19:52:45'!
notifyPosition

	positionNotifications do: [:aNotification | aNotification value: position ].! !


!MarsRover methodsFor: 'initialization' stamp: 'IV 6/4/2023 19:55:06'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	positionNotifications := OrderedCollection new.
	headingNotifications := OrderedCollection new.! !


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

!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:53:06'!
rotateLeft
	
	head rotateLeft.
	self notifyHeading.
	
	 
	
	
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'IV 6/4/2023 19:53:19'!
rotateRight
	
	head rotateRight.
	self notifyHeading.! !


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


!MarsRover methodsFor: 'moving' stamp: 'IV 6/4/2023 19:53:42'!
moveBackward
	
	head moveBackward.
	self notifyPosition.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'IV 6/4/2023 19:53:38'!
moveForward
	
	head moveForward.
	self notifyPosition.! !

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


!MarsRoverObserver methodsFor: 'notifications' stamp: 'IV 6/4/2023 19:36:52'!
newPosition: aPosition

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


!MarsRoverObserver methodsFor: 'subscriptions' stamp: 'IV 6/4/2023 20:30:25'!
subscribeToHeadingChangesOf: aMarsRover

	^ aMarsRover addHeadingNotification: [:aHeading | 
		( aHeading isKindOf: MarsRoverHeadingNorth ) ifTrue: 	[ self notifyNowHeadingNorth ].
		( aHeading isKindOf: MarsRoverHeadingSouth ) ifTrue: 	[ self notifyNowHeadingSouth ].
		( aHeading isKindOf: MarsRoverHeadingEast ) ifTrue: 	[ self notifyNowHeadingEast ].
		( aHeading isKindOf: MarsRoverHeadingWest ) ifTrue: 	[ self notifyNowHeadingWest ].
	]! !

!MarsRoverObserver methodsFor: 'subscriptions' stamp: 'IV 6/4/2023 20:17:55'!
subscribeToPositionChangesOf: aMarsRover

	^ aMarsRover addPositionNotification: [:aPosition | self newPosition: aPosition]! !

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


!MarsRoverLogger methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:46:58'!
value

	^ lines! !


!MarsRoverLogger methodsFor: 'notifications' stamp: 'IV 6/4/2023 20:05:45'!
newPosition: aPosition

	lines add: aPosition asString! !

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


!classDefinition: #MarsRoverWindow category: 'MarsRover2-Ejercicio'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'currentPosition currentHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Ejercicio'!

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/4/2023 20:19:59'!
headingStatus
	
	^'Heading: ', currentHeading asString.! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/4/2023 20:19:48'!
positionStatus

	^'Position: ', currentPosition asString.! !

!MarsRoverWindow methodsFor: 'evaluating' stamp: 'IV 6/3/2023 18:56:24'!
value

	^self positionStatus, ', ', self headingStatus.! !


!MarsRoverWindow methodsFor: 'notifications' stamp: 'IV 6/4/2023 19:36:53'!
newPosition: aPosition

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


!MarsRoverWindow methodsFor: 'initialization' stamp: 'IV 6/4/2023 20:19:13'!
initialize
	currentPosition := 'No information'.
	currentHeading := 'No information'.! !
!classDefinition: #MarsRoverLoggersTest category: 'MarsRover2-Tests'!
TestCase subclass: #MarsRoverLoggersTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Tests'!

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:46:14'!
test01CompleteLogForRoverThatHasntProcessedCommandsIsEmpty

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: ''.

	self assert: logger value isEmpty.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test02CompleteLogForRoverThatMovesForwardHasLineWithNewPosition

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0 
				   heading: self north
				   processing: 'f'.

	self assertLog: { '0@1' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test03CompleteLogForRoverThatMovesBackwardHasLineWithNewPosition

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'b'.

	self assertLog: { '0@ -1' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test04CompleteLogForRoverThatRotatesRightHasLineWithNewHeading

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'r'.

	self assertLog: { 'East' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test05CompleteLogForRoverThatRotatesLeftHasLineWithNewHeading

	| logger |

	logger := self completeLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'l'.
		
	self assertLog: { 'West' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test06CompleteLogForRoverThatProcessesMultipleCommandsHasLinesWithPositionsAndHeadings

	| logger |
	
	logger := self completeLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'frflb'.
	
	self assertLog: {
		'0@1'.
		'East'.
		'1@1'.
		'North'.
		'1@0' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test07PositionLogForRoverThatProcessesMultipleCommandsHasLinesWithPositions

	| logger |
	
	logger := self positionLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'frflb'.
	
	self assertLog: {
		'0@1'.
		'1@1'.
		'1@0' } equals: logger value.! !

!MarsRoverLoggersTest methodsFor: 'tests' stamp: 'JT 6/4/2023 00:50:18'!
test08HeadingLogForRoverThatProcessesMultipleCommandsHasLinesWithHeadings

	| logger |
	
	logger := self headingLoggerForMarsRoverStartingAt: 0@0
				   heading: self north
				   processing: 'frflb'.
	
	self assertLog: {'East'.'North'} equals: logger value.! !


!MarsRoverLoggersTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 00:50:00'!
assertLog: aCollectionOfStrings equals: aLog

	self assert: aCollectionOfStrings size equals: aLog size.
	aCollectionOfStrings with: aLog do: [:anString :aLogLine |
		self assert: anString equals: aLogLine
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


!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'IV 6/4/2023 20:04:09'!
completeLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString

	| marsRover logger |
	
	marsRover := MarsRover at: aPosition heading: aHeadingDirection.
	logger := MarsRoverLogger forPositionAndHeadingOf: marsRover.
	marsRover process: aCommandsString.
	
	^ logger! !

!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'IV 6/4/2023 20:04:30'!
headingLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString  

	| marsRover logger |
	
	marsRover := MarsRover at: aPosition heading: aHeadingDirection.
	logger := MarsRoverLogger forHeadingOf: marsRover.
	marsRover process: aCommandsString.
	
	^ logger! !

!MarsRoverLoggersTest methodsFor: 'loggers' stamp: 'IV 6/4/2023 20:04:42'!
positionLoggerForMarsRoverStartingAt: aPosition heading: aHeadingDirection processing: aCommandsString  

	| marsRover logger |
	
	marsRover := MarsRover at: aPosition heading: aHeadingDirection.
	logger := MarsRoverLogger forPositionOf: marsRover.
	marsRover process: aCommandsString.
	
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
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2-Tests'!

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


!MarsRoverWindowTest methodsFor: 'assertions' stamp: 'JT 6/4/2023 00:51:00'!
assertLog: anArray equals: aCollection

	self assert: anArray size equals: aCollection size.
	anArray with: aCollection do: [:arrayElement :collectionElement |
		self assert: arrayElement equals: collectionElement
	].! !



!MarsRoverWindowTest methodsFor: 'setUp/tearDown' stamp: 'IV 6/4/2023 20:14:39'!
setUp

	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.! !


!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:13'!
test01CompleteWindowForRoverThatHasntProcessedCommandsIsEmpty

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	self assert: 'Position: No information, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:17'!
test02CompleteWindowForRoverThatMovesBackwardsShowsCurrentPosition

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	marsRover process: 'f'.

	self assert: 'Position: 0@1, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:19'!
test03CompleteWindowForRoverThatMovesForwardShowsCurrentPosition

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	marsRover process: 'b'.

	self assert: 'Position: 0@ -1, Heading: No information' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:21'!
test04CompleteWindowForRoverThatRotatesRightShowsCurrentHeadingDirection

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	marsRover process: 'r'.

	self assert: 'Position: No information, Heading: East' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:23'!
test05CompleteWindowForRoverThatRotatesLeftShowsCurrentHeadingDirection

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	marsRover process: 'l'.

	self assert: 'Position: No information, Heading: West' equals: (window value).! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'IV 6/4/2023 20:22:25'!
test06CompleteWindowForRoverThatProcessesMultipleCommandsShowsCurrentPositionAndHeading

	| window |
	
	window := MarsRoverWindow forPositionAndHeadingOf: marsRover.

	marsRover process: 'frflb'.

	self assert: 'Position: 1@0, Heading: North' equals: (window value).! !
