!classDefinition: #MarsRoverTest category: 'MarsRover-Excercise-TDD'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 20:47:27'!
test13FacingWestProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #West.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: #North).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 21:16:13'!
test14FacingNorthProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #North.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: #East).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 21:14:51'!
test15FacingEastProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #East.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: #South).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 20:47:46'!
test16FacingSouthProcessTurnRightCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #South.
	rover process:'r'.
	self assert: (rover isAt: 1@0 heading: #West).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 20:47:52'!
test17FacingWestProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #West.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: #South).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 21:16:20'!
test18FacingSouthProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #South.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: #East).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 21:14:56'!
test19FacingEastProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #East.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: #North).! !

!MarsRoverTest methodsFor: 'turn left and right commands' stamp: 'BAG 5/16/2021 20:48:24'!
test20FacingNorthProcessTurnLeftCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #North.
	rover process:'l'.
	self assert: (rover isAt: 1@0 heading: #West).! !


!MarsRoverTest methodsFor: 'no commands' stamp: 'BAG 5/16/2021 20:45:57'!
test01EmptySequenceOfCommandsDoesNothing
	|rover|
	rover := MarsRover startingAt: 0@0 facing: #North.
	rover process:''.
	self assert: (rover isAt: 0@0 heading: #North).! !


!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:07'!
test02FacingNorthProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 0@0 facing: #North.
	rover process:'f'.
	self assert: (rover isAt: 0@1 heading: #North).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:13'!
test03FacingNorthProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 0@0 facing: #North.
	rover process:'b'.
	self assert: (rover isAt: 0@-1 heading: #North).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:23'!
test04FacingSouthProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #South.
	rover process:'f'.
	self assert: (rover isAt: 1@-1 heading: #South).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:28'!
test05FacingWestProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #West.
	rover process:'f'.
	self assert: (rover isAt: 0@0 heading: #West).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 21:14:20'!
test06FacingEastProcessForwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #East.
	rover process:'f'.
	self assert: (rover isAt: 2@0 heading: #East).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:40'!
test07FacingWestProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #West.
	rover process:'b'.
	self assert: (rover isAt: 2@0 heading: #West).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 21:14:30'!
test08FacingEastProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #East.
	rover process:'b'.
	self assert: (rover isAt: 0@0 heading: #East).! !

!MarsRoverTest methodsFor: 'forward and backward commands' stamp: 'BAG 5/16/2021 20:46:53'!
test09FacingSouthProcessBackwardCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #South.
	rover process:'b'.
	self assert: (rover isAt: 1@1 heading: #South).! !


!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/16/2021 21:14:43'!
test10FacingEastProcessTwoForwardCommands
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #East.
	rover process:'ff'.
	self assert: (rover isAt: 3@0 heading: #East).! !

!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/16/2021 20:47:10'!
test11FacingNorthProcessTwoBackwardCommands
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #North.
	rover process:'bb'.
	self assert: (rover isAt: 1@-2 heading: #North).! !

!MarsRoverTest methodsFor: 'multiple commands' stamp: 'BAG 5/16/2021 20:47:17'!
test12FacingNorthStopProcessingAfterInvalidCommand
	|rover|
	rover := MarsRover startingAt: 1@0 facing: #North.
	rover process:'bxb'.
	self assert: (rover isAt: 1@-1 heading: #North).! !


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


!classDefinition: #MarsRover category: 'MarsRover-Excercise-TDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!MarsRover methodsFor: 'initialization' stamp: 'BAG 5/16/2021 21:03:31'!
initializeStartingAt: aPoint facing: aDirection 
	position := aPoint.
	direction := aDirection .! !


!MarsRover methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:05:30'!
executeBackward
	self state moveBackward:self.
	! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 03:04:15'!
executeCommand: aCommand ifInvalid: aBlock 
	| command | 
	
	command := Command for: aCommand ifInvalid: aBlock.
	command executeOn: self.
	! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:09:40'!
executeForward
	self state moveForward:self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:09:47'!
executeTurnLeft
	self state turnLeft: self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:10:17'!
executeTurnRight
	self state turnRight: self.
! !

!MarsRover methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:18:50'!
process: aSequenceOfCommands
	aSequenceOfCommands do:[:command | self executeCommand: command ifInvalid: [ ^self ]].
	! !


!MarsRover methodsFor: 'testing' stamp: 'BAG 5/16/2021 21:06:56'!
isAt: aPoint heading: aDirection
	^aPoint = position and: direction = aDirection. 
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

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/16/2021 21:15:15'!
pointEast
	direction:=#East.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/16/2021 21:02:25'!
pointNorth
	direction:=#North.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/16/2021 21:02:18'!
pointSouth
	direction:=#South.! !

!MarsRover methodsFor: 'movements' stamp: 'BAG 5/16/2021 21:02:34'!
pointWest
	direction:=#West.! !


!MarsRover methodsFor: 'private' stamp: 'BAG 5/16/2021 21:26:21'!
state
	^(MarsRoverState stateFor: direction)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Excercise-TDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'BAG 5/16/2021 21:01:01'!
startingAt: aPoint facing: aDirection 
	^self new initializeStartingAt: aPoint facing: aDirection.! !


!classDefinition: #MarsRoverState category: 'MarsRover-Excercise-TDD'!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!MarsRoverState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:36:56'!
moveBackward: aRover
	^self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:36:47'!
moveForward: aRover
	^self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:07'!
turnLeft: aRover
	^self subclassResponsibility ! !

!MarsRoverState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:02'!
turnRight: aRover
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverState class' category: 'MarsRover-Excercise-TDD'!
MarsRoverState class
	instanceVariableNames: ''!

!MarsRoverState class methodsFor: 'instance creation' stamp: 'BAG 5/16/2021 20:53:25'!
invalidDirectionErrorDescription
	^'No se puede crear una instancia con esta dirección'! !

!MarsRoverState class methodsFor: 'instance creation' stamp: 'BAG 5/16/2021 21:25:56'!
stateFor: aDirection
	(aDirection = #North) ifTrue:[^FacingNorthState new].
	(aDirection = #South) ifTrue:[^FacingSouthState new].
	(aDirection = #East) ifTrue:[^FacingEastState new].
	(aDirection = #West) ifTrue:[^FacingWestState new].
	
	self error: self invalidDirectionErrorDescription.! !


!classDefinition: #FacingEastState category: 'MarsRover-Excercise-TDD'!
MarsRoverState subclass: #FacingEastState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!FacingEastState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:52'!
moveBackward: aRover
	aRover moveWest ! !

!FacingEastState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:37:42'!
moveForward: aRover
	aRover moveEast ! !

!FacingEastState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:38:47'!
turnLeft: aRover
	aRover pointNorth ! !

!FacingEastState methodsFor: 'actions' stamp: 'BAG 5/15/2021 02:38:33'!
turnRight: aRover
	aRover pointSouth ! !


!classDefinition: #FacingNorthState category: 'MarsRover-Excercise-TDD'!
MarsRoverState subclass: #FacingNorthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!FacingNorthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:17:48'!
moveBackward: aRover
	aRover moveSouth ! !

!FacingNorthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:17:58'!
moveForward: aRover
	aRover moveNorth ! !

!FacingNorthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:18:06'!
turnLeft: aRover
	aRover pointWest ! !

!FacingNorthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:18:16'!
turnRight: aRover
	aRover pointEast ! !


!classDefinition: #FacingSouthState category: 'MarsRover-Excercise-TDD'!
MarsRoverState subclass: #FacingSouthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!FacingSouthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:22:22'!
moveBackward: aRover
	aRover moveNorth! !

!FacingSouthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:22:27'!
moveForward: aRover
	aRover moveSouth ! !

!FacingSouthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:22:41'!
turnLeft: aRover
	aRover pointEast ! !

!FacingSouthState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:22:47'!
turnRight: aRover
	aRover pointWest ! !


!classDefinition: #FacingWestState category: 'MarsRover-Excercise-TDD'!
MarsRoverState subclass: #FacingWestState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Excercise-TDD'!

!FacingWestState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:23:18'!
moveBackward: aRover
	aRover moveEast! !

!FacingWestState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:23:29'!
moveForward: aRover
	aRover moveWest! !

!FacingWestState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:23:39'!
turnLeft: aRover
	aRover pointSouth! !

!FacingWestState methodsFor: 'actions' stamp: 'BAG 5/16/2021 21:23:48'!
turnRight: aRover
	aRover pointNorth! !
