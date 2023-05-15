!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingWest marsRoverPointingEast initialDefaultPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:05'!
test01CreatedAtOriginIsAtOrigin

	self assert: initialDefaultPosition equals: marsRoverPointingNorth position! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 16:15:15'!
test02CreatedFacingNorthFacesNorth

	self assert: North new equals: marsRoverPointingNorth direction! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:14'!
test03AfterEmptyCommandDoesNothing
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: '' 
		 isAt: initialDefaultPosition 
		 pointingTo: North new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:16'!
test04FacingNorthAfterLeftCommandFacesWestAtSamePosition
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'l'
		 isAt: initialDefaultPosition 
		 pointingTo: West new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:18'!
test05FacingNorthAfterRightCommandFacesEastAtSamePosition
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'r'
		 isAt: initialDefaultPosition 
		 pointingTo: East new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:21'!
test06FacingSouthAfterLeftCommandFacesEastAtSamePosition
	
	self assertThat: marsRoverPointingSouth 
		 afterReading: 'l'
		 isAt: initialDefaultPosition 
		 pointingTo: East new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:24'!
test07FacingSouthAfterRightCommandFacesWestAtSamePosition
	
	self assertThat: marsRoverPointingSouth 
		 afterReading: 'r'
		 isAt: initialDefaultPosition 
		 pointingTo: West new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:27'!
test08FacingWestAfterRightCommandFacesNorthAtSamePosition
	
	self assertThat: marsRoverPointingWest 
		 afterReading: 'r'
		 isAt: initialDefaultPosition 
		 pointingTo: North new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:29'!
test09FacingWestAfterLeftCommandFacesSouthAtSamePosition

	self assertThat: marsRoverPointingWest 
		 afterReading: 'l'
		 isAt: initialDefaultPosition 
		 pointingTo: South new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:32'!
test10FacingEastAfterRightCommandFacesSouthAtSamePosition

	self assertThat: marsRoverPointingEast 
		 afterReading: 'r'
		 isAt: initialDefaultPosition 
		 pointingTo: South new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:36'!
test11FacingEastAfterLeftCommandFacesNorthAtSamePosition
	
	self assertThat: marsRoverPointingEast 
		 afterReading: 'l'
		 isAt: initialDefaultPosition 
		 pointingTo: North new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:38'!
test12FacingNorthAfterTwoRightCommandsFacesSouthAtSamePosition
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'rr'
		 isAt: initialDefaultPosition 
		 pointingTo: South new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:00'!
test13FacingSouthAfterThreeRightCommandsFacesEastAtSamePosition
	
	self assertThat: marsRoverPointingSouth 
		 afterReading: 'rrr'
		 isAt: initialDefaultPosition 
		 pointingTo: East new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:42'!
test14CreatedFacingWestAfterRLRRCommandsFacesEastAtSamePosition

	self assertThat: marsRoverPointingWest 
		 afterReading: 'rlrr'
		 isAt: initialDefaultPosition 
		 pointingTo: East new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:30:34'!
test15FacingNorthAfterForwardMovesAStepNorth
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'f'
		 isAt: (Position x: 0 y: 1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:30:50'!
test16FacingSouthAfterForwardMovesAStepSouth
	
	self assertThat: marsRoverPointingSouth 
		 afterReading: 'f'
		 isAt: (Position x: 0 y: -1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:31:07'!
test17FacingWestAfterForwardMovesAStepWest

	self assertThat: marsRoverPointingWest 
		 afterReading: 'f'
		 isAt: (Position x: -1 y: 0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:31:18'!
test18FacingEastAfterForwardMovesAStepEast
	
	self assertThat: marsRoverPointingEast 
		 afterReading: 'f'
		 isAt: (Position x: 1 y: 0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:31:55'!
test19FacingNorthAfterFFMovesTwoStepsNorth
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'ff'
		 isAt: (Position x: 0 y: 2).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:32:20'!
test20FacingNorthAfterBackwardMovesAStepSouth
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'b'
		 isAt: (Position x: 0 y: -1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:32:31'!
test21FacingSouthAfterBackwardMovesAStepNorth

	self assertThat: marsRoverPointingSouth 
		 afterReading: 'b'
		 isAt: (Position x: 0 y: 1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:32:44'!
test22FacingWestAfterBackwardMovesAStepEast

	self assertThat: marsRoverPointingWest 
		 afterReading: 'b'
		 isAt: (Position x: 1 y: 0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:32:57'!
test23FacingEastAfterBackwardMovesAStepWest

	self assertThat: marsRoverPointingEast 
		 afterReading: 'b'
		 isAt: (Position x: -1 y: 0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:33:25'!
test24FacingNorthAfterBBMovesTwoStepsSouth
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'bb'
		 isAt: (Position x: 0 y: -2).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:33:52'!
test25FacingNorthAfterLFMovesAStepWest
	
	self assertThat: marsRoverPointingNorth 
		 afterReading: 'lf'
		 isAt: (Position x: -1 y: 0).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:34:16'!
test26FacingEastAfterRBMovesAStepNorth
	
	self assertThat: marsRoverPointingEast 
		 afterReading: 'rb'
		 isAt: (Position x: 0 y: 1).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:52'!
test27FacingSouthAfterLRFBEndsUpFacingSouthAtSamePosition
	
	self assertThat: marsRoverPointingSouth 
		 afterReading: 'lrfb'
		 isAt: initialDefaultPosition 
		 pointingTo: South new.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'IV 5/14/2023 17:42:59'!
test28ReadingInvalidCommandAfterValidCommandsExecutesThoseCommandsAndThenThrowsErrorStoppingCommandExecution

	self should: [ marsRoverPointingNorth readCommands: 'rlrrar' ]
		 raise: Error
		 withExceptionDo: [:anError | 
			self assert:	 Command invalidCommandErrorDescription 
				 equals: anError messageText.
		].
	
	self assert: initialDefaultPosition equals: marsRoverPointingNorth position.	
	self assert: South new equals: marsRoverPointingNorth direction.
	! !


!MarsRoverTest methodsFor: 'setUp/tearDown' stamp: 'IV 5/14/2023 17:49:15'!
setUp
	initialDefaultPosition := Position x: 0 y: 0.
	marsRoverPointingNorth := MarsRover at: initialDefaultPosition pointingTo: North new.
	marsRoverPointingSouth := MarsRover at: initialDefaultPosition pointingTo: South new.
	marsRoverPointingWest  := MarsRover at: initialDefaultPosition pointingTo: West new.
	marsRoverPointingEast  := MarsRover at: initialDefaultPosition pointingTo: East new.! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'IV 5/14/2023 17:29:51'!
assertThat: aMarsRover afterReading: aCommandsString isAt: aPosition

	aMarsRover readCommands: aCommandsString.

	self assert: aPosition equals: aMarsRover position.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'IV 5/14/2023 17:30:20'!
assertThat: aMarsRover afterReading: aCommandsString isAt: aPosition pointingTo: aDirection

	self assertThat: aMarsRover afterReading: aCommandsString isAt: aPosition.
	
	self assert: aDirection equals: aMarsRover direction! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'comparing' stamp: 'JT 5/11/2023 21:05:07'!
= anObject

	^ anObject isKindOf: self class
	! !

!CardinalPoint methodsFor: 'comparing' stamp: 'JT 5/11/2023 21:05:14'!
hash
	^ self class hash! !


!CardinalPoint methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:58:03'!
left
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'relative points' stamp: 'IV 5/14/2023 16:38:40'!
opposite
	^ self subclassResponsibility ! !

!CardinalPoint methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:58:16'!
right
	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'stepping' stamp: 'IV 5/14/2023 16:30:45'!
stepForwardFrom: aPosition 
	^ self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:58:41'!
left
	^ North new! !

!East methodsFor: 'relative points' stamp: 'IV 5/14/2023 16:38:52'!
opposite
	^ West new. ! !

!East methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:58:52'!
right
	^ South new! !


!East methodsFor: 'stepping' stamp: 'IV 5/14/2023 16:31:01'!
stepForwardFrom: aPosition 
	^ Position x: aPosition x + 1 
			   y: aPosition y! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:59:15'!
left
	^ West new! !

!North methodsFor: 'relative points' stamp: 'IV 5/14/2023 16:39:14'!
opposite
	^ South new. ! !

!North methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:59:31'!
right
	^ East new! !


!North methodsFor: 'stepping' stamp: 'IV 5/14/2023 16:30:50'!
stepForwardFrom: aPosition 
	^ Position x: aPosition x 
			   y: aPosition y + 1! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:59:46'!
left
	^ East new! !

!South methodsFor: 'relative points' stamp: 'IV 5/14/2023 16:39:21'!
opposite
	^ North new. ! !

!South methodsFor: 'relative points' stamp: 'JT 5/11/2023 20:59:57'!
right
	^ West new! !


!South methodsFor: 'stepping' stamp: 'IV 5/14/2023 16:31:16'!
stepForwardFrom: aPosition 
	^ Position x: aPosition x 
			   y: aPosition y - 1! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'relative points' stamp: 'JT 5/11/2023 21:00:14'!
left
	^ South new! !

!West methodsFor: 'relative points' stamp: 'IV 5/14/2023 16:39:02'!
opposite
	^ East new. ! !

!West methodsFor: 'relative points' stamp: 'JT 5/11/2023 21:00:21'!
right
	^ North new! !


!West methodsFor: 'stepping' stamp: 'IV 5/14/2023 16:31:10'!
stepForwardFrom: aPosition 
	^ Position x: aPosition x - 1
			   y: aPosition y! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'execution' stamp: 'JT 5/11/2023 21:53:19'!
executeOn: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'error descriptions' stamp: 'IV 5/14/2023 15:56:57'!
invalidCommandErrorDescription

	^ 'Invalid command'! !


!Command class methodsFor: 'instance creation' stamp: 'IV 5/15/2023 10:26:31'!
forChar: aCommandChar

	| command |
	
	command := self subclasses detect: [:aCommandClass | aCommandClass correspondsTo: aCommandChar] ifNone: [self error: self invalidCommandErrorDescription].
	
	^ command new.! !


!Command class methodsFor: 'corresponding char' stamp: 'IV 5/15/2023 10:26:30'!
correspondsTo: aCommandChar
	self subclassResponsibility ! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
Command subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'execution' stamp: 'JT 5/11/2023 21:53:29'!
executeOn: aMarsRover

	aMarsRover moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'corresponding char' stamp: 'IV 5/15/2023 10:26:31'!
correspondsTo: aCommandChar
	^ aCommandChar = $b! !


!classDefinition: #MoveForwards category: 'MarsRover'!
Command subclass: #MoveForwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForwards methodsFor: 'execution' stamp: 'JT 5/11/2023 21:53:41'!
executeOn: aMarsRover

	aMarsRover moveForwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwards class' category: 'MarsRover'!
MoveForwards class
	instanceVariableNames: ''!

!MoveForwards class methodsFor: 'corresponding char' stamp: 'IV 5/15/2023 10:26:31'!
correspondsTo: aCommandChar
	^ aCommandChar = $f! !


!classDefinition: #RotateLeft category: 'MarsRover'!
Command subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'execution' stamp: 'JT 5/11/2023 21:53:51'!
executeOn: aMarsRover

	aMarsRover rotateLeft! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'corresponding char' stamp: 'IV 5/15/2023 10:26:31'!
correspondsTo: aCommandChar
	^ aCommandChar = $l! !


!classDefinition: #RotateRight category: 'MarsRover'!
Command subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'execution' stamp: 'JT 5/11/2023 21:54:03'!
executeOn: aMarsRover

	aMarsRover rotateRight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'corresponding char' stamp: 'IV 5/15/2023 10:26:31'!
correspondsTo: aCommandChar
	^ aCommandChar = $r! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'IV 5/14/2023 16:13:51'!
initializeAt: aPosition pointingTo: aDirection 
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'IV 5/14/2023 17:50:08'!
direction
	^ direction! !

!MarsRover methodsFor: 'accessing' stamp: 'JT 5/11/2023 21:29:56'!
position
	^ position! !


!MarsRover methodsFor: 'commands' stamp: 'JT 5/11/2023 21:23:58'!
readCommands: aCommandString
	aCommandString do: [:aCommandChar | self executeCommand: aCommandChar ].! !


!MarsRover methodsFor: 'private commands' stamp: 'IV 5/14/2023 17:49:39'!
executeCommand: aCommandChar

	(Command forChar: aCommandChar) executeOn: self.! !

!MarsRover methodsFor: 'private commands' stamp: 'IV 5/14/2023 16:37:56'!
moveBackwards

	position := position stepTowards: direction opposite.! !

!MarsRover methodsFor: 'private commands' stamp: 'IV 5/14/2023 16:22:52'!
moveForwards

	position := position stepTowards: direction.! !

!MarsRover methodsFor: 'private commands' stamp: 'JT 5/11/2023 21:54:45'!
rotateLeft

	direction := direction left! !

!MarsRover methodsFor: 'private commands' stamp: 'JT 5/11/2023 21:54:49'!
rotateRight

	direction := direction right! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'IV 5/14/2023 16:16:03'!
at: aCoordinate pointingTo: aDirection
	^self new initializeAt: aCoordinate pointingTo: aDirection! !


!classDefinition: #Position category: 'MarsRover'!
Object subclass: #Position
	instanceVariableNames: 'x y'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Position methodsFor: 'initialization' stamp: 'IV 5/14/2023 16:08:10'!
initializeWithX: anXValue andY: aYValue

	x := anXValue.
	y := aYValue.! !


!Position methodsFor: 'comparing' stamp: 'IV 5/14/2023 16:10:14'!
= anObject

	^ (anObject isKindOf: self class) and: 
	  (anObject x = x) and:
	  (anObject y = y)! !

!Position methodsFor: 'comparing' stamp: 'IV 5/14/2023 16:10:37'!
hash
	^ x hash + y hash! !


!Position methodsFor: 'accessing' stamp: 'IV 5/14/2023 16:11:26'!
x
	^ x! !

!Position methodsFor: 'accessing' stamp: 'IV 5/14/2023 16:11:39'!
y
	^ y! !


!Position methodsFor: 'steps' stamp: 'IV 5/14/2023 16:24:01'!
stepTowards: aDirection 
	^ aDirection stepForwardFrom: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Position class' category: 'MarsRover'!
Position class
	instanceVariableNames: ''!

!Position class methodsFor: 'instance creation' stamp: 'IV 5/14/2023 16:08:11'!
x: anXValue y: aYValue

	^ self new initializeWithX: anXValue andY: aYValue.! !
