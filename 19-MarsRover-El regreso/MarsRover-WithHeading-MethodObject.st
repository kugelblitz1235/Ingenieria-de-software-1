!classDefinition: #MarsRoverStateLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverStateLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateLoggerTest methodsFor: 'position' stamp: 'BAG 6/4/2021 19:55:11'!
test01PositionLoggerLogsWhenMovingForward
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToPositionChange:logger.
	
	marsRover process:'f'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: '1@2' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'position' stamp: 'BAG 6/4/2021 19:55:20'!
test02PositionLoggerLogsWhenMovingBackward
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToPositionChange:logger.
	
	marsRover process:'b'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: '1@0' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'position' stamp: 'BAG 6/4/2021 19:55:31'!
test03PositionLoggerOnlyLogsWhenPositionChanges
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToPositionChange:logger.
	
	marsRover process:'r'.
	log := logger log.
	
	self assert: 0 equals: log size.
	! !

!MarsRoverStateLoggerTest methodsFor: 'position' stamp: 'BAG 6/7/2021 00:12:13'!
test09PositionLoggerLogsWhenMovingForwardInAllDirections
	| marsRover logger log expectedLog |
	
	expectedLog := OrderedCollection withAll: #('1@2' '2@2' '2@1' '1@1').
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToPositionChange:logger.
	
	marsRover process:'frfrfrfr'.
	log := logger log.
	
	self assert: 4 equals: log size.
	self assert:  expectedLog equals: log.
	! !

!MarsRoverStateLoggerTest methodsFor: 'position' stamp: 'BAG 6/7/2021 00:16:21'!
test10PositionLoggerLogsWhenMovingBackwardInAllDirections
	| marsRover logger log expectedLog |
	
	expectedLog := OrderedCollection withAll: #('1@0' '0@0' '0@1' '1@1').
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToPositionChange:logger.
	
	marsRover process:'brbrbrbr'.
	log := logger log.
	
	self assert: 4 equals: log size.
	self assert:  expectedLog equals: log.
	! !


!MarsRoverStateLoggerTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:55:39'!
test04HeadingLoggerLogsWhenRotatingEast
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToHeadingChange: logger.
	
	marsRover process:'r'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Este' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:55:46'!
test05HeadingLoggerLogsWhenRotatingWest
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToHeadingChange: logger.
	
	marsRover process:'l'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Oeste' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:55:54'!
test06HeadingLoggerLogsWhenRotatingSouth
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToHeadingChange: logger.
	
	marsRover process:'l'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Sur' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:56:01'!
test07HeadingLoggerLogsWhenRotatingNorth
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToHeadingChange: logger.
	
	marsRover process:'r'.
	log := logger log.
	
	self assert: 1 equals: log size.
	self assert: 'Apuntando al Norte' equals: log first.
	! !

!MarsRoverStateLoggerTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:56:20'!
test08HeadingLoggerOnlyLogsWhenHeadingChanges
	| marsRover logger log |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	logger := MarsRoverStateLogger new.
	marsRover subscribeToHeadingChange:logger.
	
	marsRover process:'fb'.
	log := logger log.
	
	self assert: 0 equals: log size.
	! !


!classDefinition: #MarsRoverStateWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverStateWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateWindowTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:58:08'!
test03WindowShowsHeadingWhenRotatingEast
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover subscribeToHeadingChange: window.
	
	marsRover process:'r'.
	
	self assert: 'Este' equals: window headingTextFieldModel.
	! !

!MarsRoverStateWindowTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:58:18'!
test04WindowShowsHeadingWhenRotatingWest
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover subscribeToHeadingChange: window.
	
	marsRover process:'l'.
	
	self assert: 'Oeste' equals: window headingTextFieldModel.
	! !

!MarsRoverStateWindowTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:58:25'!
test05WindowShowsHeadingWhenRotatingSouth
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverStateWindow new.
	marsRover subscribeToHeadingChange: window.
	
	marsRover process:'r'.
	
	self assert: 'Sur' equals: window headingTextFieldModel.
	! !

!MarsRoverStateWindowTest methodsFor: 'heading' stamp: 'BAG 6/4/2021 19:58:33'!
test06WindowShowsHeadingWhenRotatingNorth
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #East.
	window := MarsRoverStateWindow new.
	marsRover subscribeToHeadingChange: window.
	
	marsRover process:'l'.
	
	self assert: 'Norte' equals: window headingTextFieldModel.! !


!MarsRoverStateWindowTest methodsFor: 'position' stamp: 'BAG 6/4/2021 19:57:50'!
test01WindowShowsPositionWhenMovingForward
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	window := MarsRoverStateWindow new.
	marsRover subscribeToPositionChange: window.
	
	marsRover process:'f'.
	
	self assert: 0@1 equals: window positionTextFieldModel.
	! !

!MarsRoverStateWindowTest methodsFor: 'position' stamp: 'BAG 6/4/2021 19:57:58'!
test02WindowShowsPositionWhenMovingBackward
	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: #West.
	window := MarsRoverStateWindow new.
	marsRover subscribeToPositionChange: window.
	
	marsRover process:'b'.
	
	self assert: 2@1 equals: window positionTextFieldModel.
	! !

!MarsRoverStateWindowTest methodsFor: 'position' stamp: 'BAG 6/7/2021 00:41:47'!
test07WindowsShowsPositionWhenMovingBackwardInAllDirections
	| marsRover window expectedPositions expectedHeading |
	
	expectedPositions := OrderedCollection with: 1@0 with: 0@0 with: 0@1 with: 1@1.
	expectedHeading := OrderedCollection withAll: #('Este' 'Sur' 'Oeste' 'Norte').
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover subscribeToPositionChange: window.
	marsRover subscribeToHeadingChange: window.
	
	expectedPositions do: [ :expectedPosition | 
				marsRover process: 'br'.
				self assert: expectedPosition equals: window positionTextFieldModel. 
			].
	expectedHeading do: [ :heading | 
			marsRover process: 'br'.
			self assert: heading equals: window headingTextFieldModel. 
		].
	! !

!MarsRoverStateWindowTest methodsFor: 'position' stamp: 'BAG 6/7/2021 00:44:23'!
test08WindowsShowsPositionWhenMovingForwardInAllDirections
	| marsRover window expectedPositions |
	
	expectedPositions := OrderedCollection with: 1@2 with: 2@2 with: 2@1 with: 1@1.
	
	marsRover := MarsRover at: 1@1 heading: #North.
	window := MarsRoverStateWindow new.
	marsRover subscribeToPositionChange: window.
	
	expectedPositions do: [ :expectedPosition | 
				marsRover process: 'fr'.
				self assert: expectedPosition equals: window positionTextFieldModel. 
			].
	! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #HeadingFinder category: 'MarsRover-WithHeading'!
Object subclass: #HeadingFinder
	instanceVariableNames: 'marsRoverHeadingState heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingFinder methodsFor: 'initialization' stamp: 'BAG 6/7/2021 00:59:37'!
initializeFor: aMarsRoverHeadingState
	marsRoverHeadingState := aMarsRoverHeadingState .! !


!HeadingFinder methodsFor: 'heading' stamp: 'BAG 6/7/2021 00:57:30'!
changeHeadingToEast
	heading := 'Este'.! !

!HeadingFinder methodsFor: 'heading' stamp: 'BAG 6/7/2021 00:57:40'!
changeHeadingToNorth
	heading := 'Norte'.! !

!HeadingFinder methodsFor: 'heading' stamp: 'BAG 6/7/2021 00:57:47'!
changeHeadingToSouth
	heading := 'Sur'.! !

!HeadingFinder methodsFor: 'heading' stamp: 'BAG 6/7/2021 00:57:55'!
changeHeadingToWest
	heading := 'Oeste'.! !

!HeadingFinder methodsFor: 'heading' stamp: 'BAG 6/7/2021 00:58:46'!
heading
	marsRoverHeadingState sendHeadingStateTo: self.
	^heading copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingFinder class' category: 'MarsRover-WithHeading'!
HeadingFinder class
	instanceVariableNames: ''!

!HeadingFinder class methodsFor: 'instance creation' stamp: 'BAG 6/7/2021 00:59:59'!
for: aMarsRoverHeadingState
	^self new initializeFor: aMarsRoverHeadingState .! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionObservers headingObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'BAG 6/4/2021 00:49:52'!
initializeAt: aPosition heading: aHeading
	headingObservers := OrderedCollection new.
	positionObservers := OrderedCollection new.
	position := aPosition.
	head := aHeading ! !


!MarsRover methodsFor: 'heading' stamp: 'BAG 6/4/2021 20:14:18'!
changeHeadTo: aHead
	head := aHead.
	headingObservers do: [:observer | observer headingChangedTo: head ].
	! !

!MarsRover methodsFor: 'heading' stamp: 'BAG 6/4/2021 20:13:48'!
headEast
	self changeHeadTo: MarsRoverHeadingEast new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'BAG 6/4/2021 20:13:48'!
headNorth
	self changeHeadTo: MarsRoverHeadingNorth new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'BAG 6/4/2021 20:13:48'!
headSouth
	self changeHeadTo: MarsRoverHeadingSouth new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'BAG 6/4/2021 20:13:48'!
headWest
	self changeHeadTo: MarsRoverHeadingWest new.
	! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:07:11'!
rotateLeft
	
	head rotateLeft: self! !

!MarsRover methodsFor: 'heading' stamp: 'BAG 6/3/2021 20:51:31'!
rotateRight
	
	head rotateRight: self.
	! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

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


!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:47:17'!
changePositionBy: anOffset
	position := position + anOffset. 
	positionObservers do: [:observer | observer positionChangedTo: position ].
	! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:41:41'!
moveBackward
	head moveBackward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:42:11'!
moveEast
	self changePositionBy: (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:41:48'!
moveForward
	head moveForward: self.! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:42:23'!
moveNorth
	self changePositionBy:(0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:42:33'!
moveSouth
	self changePositionBy:(0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'BAG 6/4/2021 00:42:52'!
moveWest
	self changePositionBy: (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'BAG 6/3/2021 20:36:32'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ].
	
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'BAG 6/4/2021 00:55:55'!
subscribeToHeadingChange: anObserver 
	headingObservers add: anObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'BAG 6/4/2021 00:54:15'!
subscribeToPositionChange: anObserver 
	positionObservers add: anObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:01:48'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'observer' stamp: 'BAG 6/4/2021 20:18:53'!
sendHeadingStateTo: anObserver
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'observer' stamp: 'BAG 6/4/2021 20:18:53'!
sendHeadingStateTo: anObserver
	anObserver changeHeadingToEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'observer' stamp: 'BAG 6/4/2021 20:18:53'!
sendHeadingStateTo: anObserver
	anObserver changeHeadingToNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'observer' stamp: 'BAG 6/4/2021 20:18:53'!
sendHeadingStateTo: anObserver
	anObserver changeHeadingToSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'observer' stamp: 'BAG 6/4/2021 20:18:53'!
sendHeadingStateTo: anObserver
	anObserver changeHeadingToWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverStateLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStateLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateLogger methodsFor: 'initialization' stamp: 'BAG 6/3/2021 20:29:53'!
initialize
	log := OrderedCollection new.! !


!MarsRoverStateLogger methodsFor: 'accesing' stamp: 'BAG 6/3/2021 20:30:07'!
log
	^log copy.! !


!MarsRoverStateLogger methodsFor: 'position change' stamp: 'BAG 6/4/2021 00:06:51'!
positionChangedTo: aPosition 
	log add: aPosition printString.! !


!MarsRoverStateLogger methodsFor: 'heading change' stamp: 'BAG 6/7/2021 01:11:36'!
headingChangedTo: aMarsRoverHeading
	| directionFinder |
	directionFinder := HeadingFinder for: aMarsRoverHeading.
	
	log add: 'Apuntando al ',directionFinder heading.! !


!classDefinition: #MarsRoverStateWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStateWindow
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStateWindow methodsFor: 'accesing' stamp: 'BAG 6/4/2021 01:03:38'!
headingTextFieldModel
	^heading copy.! !

!MarsRoverStateWindow methodsFor: 'accesing' stamp: 'BAG 6/4/2021 01:03:50'!
positionTextFieldModel
	^position copy.! !


!MarsRoverStateWindow methodsFor: 'position change' stamp: 'BAG 6/4/2021 00:01:40'!
positionChangedTo: aPosition 
	position := aPosition! !


!MarsRoverStateWindow methodsFor: 'heading change' stamp: 'BAG 6/7/2021 01:02:27'!
headingChangedTo: aMarsRoverHeading
	| directionFinder |
	directionFinder := HeadingFinder for: aMarsRoverHeading.
	
	heading := directionFinder heading.! !
