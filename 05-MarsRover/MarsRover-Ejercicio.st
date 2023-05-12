!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover marsRoverSouth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setup' stamp: 'JT 5/11/2023 21:06:25'!
setUp
	marsRover := MarsRover at: 0@0 pointingAt: North new.
	marsRoverSouth := MarsRover at: 0@0 pointingAt: South new.! !


!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:06:40'!
test01CreatedAtOriginIsAtOrigin

	self assert: 0@0 equals: marsRover position! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:06:36'!
test02CreatedFacingNorthFacesNorth

	self assert: North new equals: marsRover direction! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:06:49'!
test03AfterEmptyCommandDoesNothing
	
	marsRover readCommands: ''.
	
	self assert: 0@0 equals: marsRover position.
	self assert: North new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:06:59'!
test04CreatedFacingNorthAfterLeftCommandFacesWestAtSamePosition

	marsRover readCommands: 'l'.
	
	self assert: 0@0 equals: marsRover position.	
	self assert: West new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:07:11'!
test05CreatedFacingNorthAfterRightCommandFacesEastAtSamePosition

	marsRover readCommands: 'r'.
	
	self assert: 0@0 equals: marsRover position.	
	self assert: East new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:09:40'!
test06CreatedFacingSouthAfterLeftCommandFacesEastAtSamePosition

	marsRoverSouth readCommands: 'l'.
	
	self assert: 0@0 equals: marsRoverSouth position.	
	self assert: East new equals: marsRoverSouth direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:09:59'!
test07CreatedFacingSouthAfterRightCommandFacesWestAtSamePosition

	marsRoverSouth readCommands: 'r'.
	
	self assert: 0@0 equals: marsRoverSouth position.	
	self assert: West new equals: marsRoverSouth direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:20:54'!
test08CreatedFacingWestAfterLeftCommandFacesSouthAtSamePosition

	| marsRoverWest |
	marsRoverWest := MarsRover at: 0@0 pointingAt: West new.
	
	marsRoverWest readCommands: 'l'.
	
	self assert: 0@0 equals: marsRoverWest position.	
	self assert: South new equals: marsRoverWest direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:17:28'!
test09CreatedFacingNorthAfterTwoRightCommandsFacesSouthAtSamePosition

	marsRover readCommands: 'rr'.
	
	self assert: 0@0 equals: marsRover position.	
	self assert: South new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:21:28'!
test10CreatedFacingNorthAfterThreeRightCommandsFacesWestAtSamePosition

	marsRover readCommands: 'rrr'.
	
	self assert: 0@0 equals: marsRover position.	
	self assert: West new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:24:51'!
test11CreatedFacingNorthAfterRLRRCommandsFacesSouthAtSamePosition

	marsRover readCommands: 'rlrr'.
	
	self assert: 0@0 equals: marsRover position.	
	self assert: South new equals: marsRover direction.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:27:16'!
test12FacingNorthAfterForwardMovesAStepNorth

	marsRover readCommands: 'f'.
	
	self assert: 0@1 equals: marsRover position.	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:33:01'!
test13FacingNorthAfterFFMovesTwoStepsNorth

	marsRover readCommands: 'ff'.
	
	self assert: 0@2 equals: marsRover position.	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:34:45'!
test14FacingNorthAfterBackwardMovesAStepSouth

	marsRover readCommands: 'b'.
	
	self assert: 0@-1 equals: marsRover position.	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:37:03'!
test15FacingNorthAfterLFMovesAStepWest

	marsRover readCommands: 'lf'.
	
	self assert: -1@0 equals: marsRover position.	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:45:06'!
test16FacingEastAfterRBMovesAStepNorth

	| marsRoverEast |
	marsRoverEast := MarsRover at: 0@0 pointingAt: East new.
	
	marsRoverEast readCommands: 'rb'.
	
	self assert: 0@1 equals: marsRoverEast position.	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'JT 5/11/2023 21:59:04'!
test17ReadingInvalidCommandOnFirstCharThrowsErrorAndDoesNothing

	self should: [ marsRover readCommands: 'a' ]
		 raise: Error
		 withExceptionDo: [:anError | anError		 ]
	! !


!classDefinition: #Cardinal category: 'MarsRover'!
Object subclass: #Cardinal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Cardinal methodsFor: 'comparing' stamp: 'JT 5/11/2023 21:05:07'!
= anObject

	^ anObject isKindOf: self class
	! !

!Cardinal methodsFor: 'comparing' stamp: 'JT 5/11/2023 21:05:14'!
hash
	^ self class hash! !


!Cardinal methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:43:33'!
backward
	^ self forward * (-1)! !

!Cardinal methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:41:37'!
forward
	self subclassResponsibility ! !

!Cardinal methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:58:03'!
left
	self subclassResponsibility ! !

!Cardinal methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:58:16'!
right
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
Cardinal subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 20:58:41'!
left
	^ North new! !

!East methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 20:58:52'!
right
	^ South new! !


!East methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:41:53'!
forward
	^ 1@0! !


!classDefinition: #North category: 'MarsRover'!
Cardinal subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:43:19'!
forward
	^ 0@1! !

!North methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:59:15'!
left
	^ West new! !

!North methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:59:31'!
right
	^ East new! !


!classDefinition: #South category: 'MarsRover'!
Cardinal subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:44:07'!
forward
	^ 0@-1! !

!South methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:59:46'!
left
	^ East new! !

!South methodsFor: 'neighbours' stamp: 'JT 5/11/2023 20:59:57'!
right
	^ West new! !


!classDefinition: #West category: 'MarsRover'!
Cardinal subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:44:15'!
forward
	^ -1@0! !

!West methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:00:14'!
left
	^ South new! !

!West methodsFor: 'neighbours' stamp: 'JT 5/11/2023 21:00:21'!
right
	^ North new! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:53:19'!
executeOn: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:51:50'!
canHandle: aCommandChar
	self subclassResponsibility ! !

!Command class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:55:29'!
forChar: aCommandChar

	^ (self subclasses detect: [:aCommandClass | aCommandClass canHandle: aCommandChar]) new.! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
Command subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:53:29'!
executeOn: aMarsRover

	aMarsRover moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:52:06'!
canHandle: aCommandChar
	^ aCommandChar = $b! !


!classDefinition: #MoveForwards category: 'MarsRover'!
Command subclass: #MoveForwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForwards methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:53:41'!
executeOn: aMarsRover

	aMarsRover moveForwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwards class' category: 'MarsRover'!
MoveForwards class
	instanceVariableNames: ''!

!MoveForwards class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:52:10'!
canHandle: aCommandChar
	^ aCommandChar = $f! !


!classDefinition: #RotateLeft category: 'MarsRover'!
Command subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:53:51'!
executeOn: aMarsRover

	aMarsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:52:16'!
canHandle: aCommandChar
	^ aCommandChar = $l! !


!classDefinition: #RotateRight category: 'MarsRover'!
Command subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:54:03'!
executeOn: aMarsRover

	aMarsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'as yet unclassified' stamp: 'JT 5/11/2023 21:52:21'!
canHandle: aCommandChar
	^ aCommandChar = $r! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'JT 5/11/2023 21:29:56'!
initializeAt: aPosition pointingAt: aDirection 
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'JT 5/11/2023 20:38:48'!
direction
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'JT 5/11/2023 21:29:56'!
position
	^ position! !


!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:52:56'!
executeCommand: aCommandChar
	|command|
	
	command := Command forChar: aCommandChar.
	
	command executeOn: self.! !

!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:54:33'!
moveBackwards

	position := position + direction backward! !

!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:54:27'!
moveForwards

	position := position + direction forward! !

!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:23:58'!
readCommands: aCommandString
	aCommandString do: [:aCommandChar | self executeCommand: aCommandChar ].! !

!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:54:45'!
rotateLeft

	direction := direction left! !

!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:54:49'!
rotateRight

	direction := direction right! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JT 5/11/2023 20:36:11'!
at: aCoordinate pointingAt: aDirection
	^self new initializeAt: aCoordinate pointingAt: aDirection! !
