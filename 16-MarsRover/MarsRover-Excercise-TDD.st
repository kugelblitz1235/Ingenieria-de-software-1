!classDefinition: #MarsRoverTest category: 'MarsRover-Excercise-TDD'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:11:03'!
test13FacingWestProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: West.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: North).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:11:15'!
test14FacingNorthProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: North.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: East).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:11:37'!
test15FacingEastProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: East.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: South).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:11:48'!
test16FacingSouthProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: South.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: West).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:12:01'!
test17FacingWestProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: West.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: South).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:12:16'!
test18FacingSouthProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: South.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: East).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:12:35'!
test19FacingEastProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: East.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: North).! !

!MarsRoverTest methodsFor: 'rotation commands' stamp: 'BAG 5/15/2021 03:12:55'!
test20FacingNorthProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: North.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: West).! !


!MarsRoverTest methodsFor: 'no commands' stamp: 'BAG 5/15/2021 03:05:44'!
test01EmptySequenceOfCommandsDoesNothing
	|rover|
	rover := MarsRover startingAt: 0@0 facing: North.
	rover process:''.
	self assert: (rover isAt: 0@0 heading: North).! !


!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:06:09'!
test02FacingNorthProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 0@0 facing: North.
	rover process:'f'.
	self assert: (rover isAt: 0@1 heading: North).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:06:28'!
test03FacingNorthProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 0@0 facing: North.
	rover process:'b'.
	self assert: (rover isAt: 0@-1 heading: North).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:06:53'!
test04FacingSouthProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: South.
	rover process:'f'.
	self assert: (rover isAt: 1@-1 heading: South).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:07:15'!
test05FacingWestProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: West.
	rover process:'f'.
	self assert: (rover isAt: 0@0 heading: West).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:08:47'!
test06FacingEastProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: East.
	rover process:'f'.
	self assert: (rover isAt: 2@0 heading: East).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:09:11'!
test07FacingWestProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: West.
	rover process:'b'.
	self assert: (rover isAt: 2@0 heading: West).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:09:39'!
test08FacingEastProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: East.
	rover process:'b'.
	self assert: (rover isAt: 0@0 heading: East).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/15/2021 03:09:57'!
test09FacingSouthProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: South.
	rover process:'b'.
	self assert: (rover isAt: 1@1 heading: South).! !


!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/15/2021 03:10:11'!
test10FacingEastProcessTwoForwardCommands
	|rover|
	rover := MarsRover startingAt: 1@0 facing: East.
	rover process:'ff'.
	self assert: (rover isAt: 3@0 heading: East).! !

!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/15/2021 03:10:34'!
test11FacingNorthProcessTwoBackwardCommands
	|rover|
	rover := MarsRover startingAt: 1@0 facing: North.
	rover process:'bb'.
	self assert: (rover isAt: 1@-2 heading: North).! !

!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/15/2021 03:10:50'!
test12FacingNorthStopProcessingAfterInvalidCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: North.
	rover process:'bxb'.
	self assert: (rover isAt: 1@-1 heading: North).! !


!classDefinition: #Command category: 'MarsRover-Excercise-TDD'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!Command methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:00:48'!
executeOn: aRover 
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover-Excercise-TDD'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'BAG 5/15/2021 03:00:20'!
for: aCommandType ifInvalid: aBlock 
	aCommandType = $f ifTrue:[^Forward new].
	aCommandType = $b ifTrue:[^Backward new].
	aCommandType = $l ifTrue:[^TurnLeft new].
	aCommandType = $r ifTrue:[^TurnRight new].
	
	aBlock value! !


!classDefinition: #Backward category: 'MarsRover-Excercise-TDD'!
Command subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!Backward methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:01:20'!
executeOn: aRover 
	aRover executeBackward! !


!classDefinition: #Forward category: 'MarsRover-Excercise-TDD'!
Command subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!Forward methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:01:36'!
executeOn: aRover 
	aRover executeForward! !


!classDefinition: #TurnLeft category: 'MarsRover-Excercise-TDD'!
Command subclass: #TurnLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!TurnLeft methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:01:48'!
executeOn: aRover 
	aRover executeTurnLeft! !


!classDefinition: #TurnRight category: 'MarsRover-Excercise-TDD'!
Command subclass: #TurnRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!TurnRight methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:01:59'!
executeOn: aRover 
	aRover executeTurnRight! !


!classDefinition: #Direction category: 'MarsRover-Excercise-TDD'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!Direction methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:36:56'!
moveBackward: aRover
	^self subclassResponsibility ! !

!Direction methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:36:47'!
moveForward: aRover
	^self subclassResponsibility ! !

!Direction methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:07'!
turnLeft: aRover
	^self subclassResponsibility ! !

!Direction methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:02'!
turnRight: aRover
	^self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover-Excercise-TDD'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!East methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:52'!
moveBackward: aRover
	aRover moveWest ! !

!East methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:42'!
moveForward: aRover
	aRover moveEast ! !

!East methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:38:47'!
turnLeft: aRover
	aRover pointNorth ! !

!East methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:38:33'!
turnRight: aRover
	aRover pointSouth ! !


!classDefinition: #North category: 'MarsRover-Excercise-TDD'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!North methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:39:24'!
moveBackward: aRover
	aRover moveSouth ! !

!North methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:39:13'!
moveForward: aRover
	aRover moveNorth ! !

!North methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:39:48'!
turnLeft: aRover
	aRover pointWest ! !

!North methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:39:40'!
turnRight: aRover
	aRover pointEast ! !


!classDefinition: #South category: 'MarsRover-Excercise-TDD'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!South methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:40:13'!
moveBackward: aRover
	aRover moveNorth! !

!South methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:40:29'!
moveForward: aRover
	aRover moveSouth! !

!South methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:58:02'!
turnLeft: aRover
	aRover pointEast! !

!South methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:57:26'!
turnRight: aRover
	aRover pointWest! !


!classDefinition: #West category: 'MarsRover-Excercise-TDD'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!West methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:41:18'!
moveBackward: aRover
	aRover moveEast! !

!West methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:41:09'!
moveForward: aRover
	aRover moveWest! !

!West methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:41:44'!
turnLeft: aRover
	aRover pointSouth! !

!West methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:41:38'!
turnRight: aRover
	aRover pointNorth! !


!classDefinition: #MarsRover category: 'MarsRover-Excercise-TDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!MarsRover methodsFor: 'initialization' stamp: 'BAG 5/15/2021 02:44:02'!
initializeStartingAt: aPoint facing: aDirection 
	position := aPoint.
	direction := aDirection new.! !


!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:04:31'!
executeBackward
	direction moveBackward:self.
	! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:04:15'!
executeCommand: aCommand ifInvalid: aBlock 
	| command | 
	
	command := Command for: aCommand ifInvalid: aBlock.
	command executeOn: self.
	! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:04:45'!
executeForward
	direction moveForward:self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:05:00'!
executeTurnLeft
	direction turnLeft: self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:05:13'!
executeTurnRight
	direction turnRight: self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:18:50'!
process: aSequenceOfCommands
	aSequenceOfCommands do:[:command | self executeCommand: command ifInvalid: [ ^self ]].
	! !


!MarsRover methodsFor: 'testing' stamp: 'BAG 5/15/2021 02:45:07'!
isAt: aPoint heading: aDirection
	^aPoint = position and: (direction isKindOf: aDirection). 
	! !


!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:43:04'!
moveEast
	position:=position + (1@0).
		! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:43:22'!
moveNorth
	position := position + (0@1)
		! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:47:34'!
moveSouth
	position := position + (0@-1)
		! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:42:42'!
moveWest
	position:=position + (-1@0)
		! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:56:12'!
pointEast
	direction:=East new.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:56:26'!
pointNorth
	direction:=North new.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:56:32'!
pointSouth
	direction:=South new.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/15/2021 02:56:19'!
pointWest
	direction:=West new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Excercise-TDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'BAG 5/15/2021 01:55:38'!
startingAt: aPoint facing: aDirection 
	^self new initializeStartingAt: aPoint facing: aDirection ! !
