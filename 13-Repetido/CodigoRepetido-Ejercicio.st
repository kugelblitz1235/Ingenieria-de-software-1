!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assert messages' stamp: 'BAG 4/13/2021 00:02:11'!
assertThat: aCustomerBook
hasANumberOfActiveCustomers: aNumberOfActive
hasANumberOfSuspendedCustomers: aNumberOfSuspended
hasANumberOfCustomers: aNumber
	self assert: aNumberOfActive 
	      equals: aCustomerBook numberOfActiveCustomers.
	
	self assert: aNumberOfSuspended 
	      equals: aCustomerBook numberOfSuspendedCustomers.
	
	self assert: aNumber 
	      equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assert messages' stamp: 'BAG 4/13/2021 00:38:04'!
assertThatMessage: aMessage 
sentToCustomerBook: aCustomerBook 
throwsAnError: anErrorType 
endsWithANumberOfCustomers: aNumber
andIncludesCustomerNamed: aName
	[ aMessage value: aCustomerBook.
	self fail ]
		on: anErrorType
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = aNumber.
			self assert: (aCustomerBook includesCustomerNamed: aName) ]
! !

!CustomerBookTest methodsFor: 'assert messages' stamp: 'BAG 4/13/2021 18:20:07'!
assertThatTheBlock: aBlock takesLessThan: aTimeUpperBoundInMs
 	| millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTimeUpperBoundInMs*millisecond)! !


!CustomerBookTest methodsFor: 'instance creation' stamp: 'BAG 4/13/2021 00:41:51'!
createACustomerBookWithACustomerNamed: aName
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aName.
	^customerBook! !

!CustomerBookTest methodsFor: 'instance creation' stamp: 'BAG 4/13/2021 00:55:17'!
createACustomerBookWithASuspendedCustomerNamed: aName
	| customerBook |
	customerBook := self createACustomerBookWithACustomerNamed: aName.
	customerBook suspendCustomerNamed: aName.
	^customerBook! !


!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 18:21:10'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	self assertThatTheBlock: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 18:20:41'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createACustomerBookWithACustomerNamed: paulMcCartney .
	
	self assertThatTheBlock: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 01:02:54'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 00:57:59'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.		
	customerBook := self createACustomerBookWithACustomerNamed: johnLennon .
	
	self assertThatMessage: [:aCustomerBook | aCustomerBook removeCustomerNamed: 'Paul McCartney'.]  	
	sentToCustomerBook:  customerBook 
	throwsAnError: NotFound 
	endsWithANumberOfCustomers: 1 
	andIncludesCustomerNamed: johnLennon.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 00:53:31'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createACustomerBookWithASuspendedCustomerNamed: paulMcCartney. 
	
	self assertThat: customerBook
	hasANumberOfActiveCustomers: 0
	hasANumberOfSuspendedCustomers: 1
	hasANumberOfCustomers: 1.
		
	self assert: (customerBook includesCustomerNamed: paulMcCartney).

	
	

	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 00:54:38'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	
	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook := self createACustomerBookWithASuspendedCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook
	hasANumberOfActiveCustomers: 0
	hasANumberOfSuspendedCustomers: 0
	hasANumberOfCustomers: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 01:01:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook := self createACustomerBookWithACustomerNamed: johnLennon .
	
	self assertThatMessage: [:aCustomerBook | aCustomerBook suspendCustomerNamed: 'George Harrison'.]  	
		sentToCustomerBook:  customerBook 
		throwsAnError: CantSuspend 
		endsWithANumberOfCustomers: 1 
		andIncludesCustomerNamed: johnLennon.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'BAG 4/13/2021 00:59:36'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.		
	customerBook := self createACustomerBookWithASuspendedCustomerNamed: johnLennon.
	
	self assertThatMessage: [:aCustomerBook | aCustomerBook suspendCustomerNamed: johnLennon.]  	
		sentToCustomerBook:  customerBook 
		throwsAnError: CantSuspend 
		endsWithANumberOfCustomers: 1 
		andIncludesCustomerNamed: johnLennon.
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'BAG 4/13/2021 01:16:35'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'BAG 4/13/2021 01:17:51'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'BAG 4/13/2021 01:53:12'!
removeCustomerNamed: aName 
	(active includes: aName) ifTrue:[^active remove: aName].
	(suspended includes: aName) ifTrue:[^suspended remove: aName].
		
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
