!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyFinder fourSentencesFinder stackOfFourSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'TT 4/27/2021 18:37:19'!
setUp
	emptyFinder :=  SentenceFinderByPrefix createWithSentences: (OOStack new).
	stackOfFourSentences := OOStack new.
	stackOfFourSentences 
		push: 'winter is coming';
		push: 'winning is everything';
		push: 'The winds of Winter';
		push: 'Winter is here'.
	
	fourSentencesFinder := SentenceFinderByPrefix createWithSentences: stackOfFourSentences.
		

	! !


!SentenceFinderByPrefixTest methodsFor: 'auxiliars' stamp: 'TT 4/27/2021 18:56:14'!
assertStack: aStack isEqualToStack: anotherStack
	| aStackCopy anotherStackCopy |
	aStackCopy := aStack copy.
	anotherStackCopy := anotherStack copy.
	
	self assert: (aStackCopy size = anotherStackCopy size).
	
	[aStackCopy isEmpty] whileFalse: [
		self assert: (aStackCopy pop = anotherStackCopy pop).
	].! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TT 4/27/2021 18:19:30'!
test01CreateShouldReceiveAStack
	self
		should: [SentenceFinderByPrefix createWithSentences: (OrderedCollection new).]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix collaboratorShouldBeAStackErrorDescription.].
		
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TT 4/27/2021 18:33:01'!
test02StackShouldOnlyContainSentences
	| anInvalidStack |
	
	anInvalidStack := OOStack new.
	anInvalidStack
		push: 'The'; 
		push: 1;
		push: 'pepe'.
	
	self
		should: [SentenceFinderByPrefix createWithSentences: anInvalidStack.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix stackShouldOnlyContainSentencesErrorDescription.].
		
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'TT 4/27/2021 18:40:33'!
test03CreateShouldWorkIfStackIsValid
	| finder |
	finder := SentenceFinderByPrefix createWithSentences: stackOfFourSentences.
	self assertStack: stackOfFourSentences isEqualToStack: finder sentences.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:40:43'!
test04FindPrefixShouldNotBeEmpty 
	
	self
		should: [ fourSentencesFinder find: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotBeEmptyErrorDescription .
		].
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:41:05'!
test05FindPrefixShouldNotContainBlanks

	self
		should: [ fourSentencesFinder find: 'winter is']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotContainBlanksErrorDescription .
		].
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:41:16'!
test06StackIsNotModifiedIfFindDoesNotReturnSentences
	| initialSentences |
	initialSentences := fourSentencesFinder sentences.
	fourSentencesFinder find: 'pepe'.
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:41:23'!
test07StackIsNotModifiedIfFindReturnSentences
	| initialSentences |
	initialSentences := fourSentencesFinder sentences.
	fourSentencesFinder find: 'win'.
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:41:31'!
test08FindShouldNotReturnSentencesFromEmptyStack
	| initialSentences |
	initialSentences := emptyFinder sentences.
	
	self assert: (emptyFinder find: 'pepe') size = 0. 
	self assertStack: initialSentences isEqualToStack: emptyFinder sentences.
		
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:41:40'!
test09FindShouldNotReturnSentencesIfNoneMatch
	|initialSentences|
	initialSentences := fourSentencesFinder sentences.
	
	self assert: (fourSentencesFinder find: 'pepe') = (OrderedCollection new). 
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:42:44'!
test10FindShouldReturnOneSentence
	|initialSentences expectedResults|
	expectedResults := OrderedCollection new.
	expectedResults add: 'Winter is here'.
	initialSentences := fourSentencesFinder sentences.
	
	self assert: (fourSentencesFinder find: 'Wint') = expectedResults. 
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:42:55'!
test11FindShouldReturnMultipleSentences
	|initialSentences expectedResults|
	initialSentences := fourSentencesFinder sentences.
	
	expectedResults := OrderedCollection new.
	expectedResults			
		add: 'winning is everything';
		add: 'winter is coming'.
				 
	self assert: (fourSentencesFinder find: 'win') = expectedResults.
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'BAG 4/29/2021 00:43:02'!
test12FindShouldBeCaseSensitive
	| initialSentences expectedResults|
	initialSentences := fourSentencesFinder sentences .
	expectedResults := OrderedCollection new.
	
	self assert: (fourSentencesFinder find: 'WIN') = expectedResults. 
	self assertStack: initialSentences isEqualToStack: fourSentencesFinder sentences.! !


!classDefinition: #OOList category: 'Stack-Exercise'!
Object subclass: #OOList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:10:43'!
add: anElement
	^OONonEmptyList createWithTail: self andHead: anElement ! !

!OOList methodsFor: 'list operations' stamp: 'BAG 4/25/2021 21:47:57'!
head 
	self subclassResponsibility ! !

!OOList methodsFor: 'list operations' stamp: 'BAG 4/25/2021 21:48:27'!
isEmpty 
	self subclassResponsibility ! !

!OOList methodsFor: 'list operations' stamp: 'BAG 4/25/2021 21:48:19'!
size 
	self subclassResponsibility ! !

!OOList methodsFor: 'list operations' stamp: 'BAG 4/25/2021 21:48:05'!
tail 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOList class' category: 'Stack-Exercise'!
OOList class
	instanceVariableNames: ''!

!OOList class methodsFor: 'as yet unclassified' stamp: 'TT 4/25/2021 20:03:57'!
new
	^OOEmptyList basicNew! !


!classDefinition: #OOEmptyList category: 'Stack-Exercise'!
OOList subclass: #OOEmptyList
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:05:47'!
head
	^self error: OOStack stackEmptyErrorDescription ! !

!OOEmptyList methodsFor: 'list operations' stamp: 'TT 4/24/2021 20:10:57'!
isEmpty
	^true! !

!OOEmptyList methodsFor: 'list operations' stamp: 'TT 4/24/2021 20:13:11'!
size
	^0! !

!OOEmptyList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:05:59'!
tail
	^self error: OOStack stackEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyList class' category: 'Stack-Exercise'!
OOEmptyList class
	instanceVariableNames: ''!

!OOEmptyList class methodsFor: 'as yet unclassified' stamp: 'TT 4/24/2021 20:09:34'!
new
	^self basicNew! !


!classDefinition: #OONonEmptyList category: 'Stack-Exercise'!
OOList subclass: #OONonEmptyList
	instanceVariableNames: 'tail head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONonEmptyList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:06:21'!
head
	^head! !

!OONonEmptyList methodsFor: 'list operations' stamp: 'TT 4/24/2021 20:19:11'!
isEmpty
	^false! !

!OONonEmptyList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:12:15'!
size
	^tail size + 1! !

!OONonEmptyList methodsFor: 'list operations' stamp: 'TT 4/25/2021 20:06:15'!
tail
	^tail ! !


!OONonEmptyList methodsFor: 'initialization' stamp: 'TT 4/25/2021 20:07:16'!
initializeWithTail: aList andHead: anElement
	tail := aList. 
	head := anElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONonEmptyList class' category: 'Stack-Exercise'!
OONonEmptyList class
	instanceVariableNames: ''!

!OONonEmptyList class methodsFor: 'as yet unclassified' stamp: 'TT 4/25/2021 20:08:23'!
createWithTail: aList andHead: anElement
	^self basicNew initializeWithTail: aList andHead: anElement ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'listOfElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'TT 4/25/2021 20:09:36'!
initialize
	listOfElements := OOList new.! !


!OOStack methodsFor: 'stack operations' stamp: 'TT 4/25/2021 20:09:40'!
isEmpty
	^listOfElements isEmpty ! !

!OOStack methodsFor: 'stack operations' stamp: 'TT 4/25/2021 20:09:54'!
pop
	| topElement |
	topElement := listOfElements head.
	listOfElements := listOfElements tail.
	^topElement ! !

!OOStack methodsFor: 'stack operations' stamp: 'TT 4/25/2021 20:11:17'!
push: anElement
	listOfElements := listOfElements add: anElement ! !

!OOStack methodsFor: 'stack operations' stamp: 'TT 4/25/2021 20:11:27'!
size
	^listOfElements size! !

!OOStack methodsFor: 'stack operations' stamp: 'TT 4/25/2021 20:11:37'!
top
	^listOfElements head ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'TT 4/25/2021 19:22:55'!
new
	^self basicNew initialize! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackOfSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'BAG 4/29/2021 01:48:12'!
initializeWithSentences: aStackOfSentences
	self assertTypeIsStack: aStackOfSentences.
	self assertIsAStackOfSentences: aStackOfSentences.
	
	stackOfSentences := aStackOfSentences copy
	
	! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'BAG 4/27/2021 00:59:32'!
find: aPrefix
	self class assertPrefixNotEmpty: aPrefix.
	self class assertPrefixWithoutBlanks: aPrefix.
	
	^self selectSentencesWithPrefix: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'BAG 4/29/2021 01:48:46'!
sentences
	^ stackOfSentences copy! !


!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'BAG 4/29/2021 01:15:34'!
from: aStack select: aBlock
	|selectedElements stackCopy|
	selectedElements := OrderedCollection new.
	stackCopy := OOStack new.
	
	[aStack isEmpty ] whileFalse: [ 
		| topElement |
		topElement := aStack pop.
		self ifElement: topElement satisfies: aBlock  addTo: selectedElements	.
		stackCopy push: topElement 
	].                                                                                                            
	
	self restore: aStack from: stackCopy.
		

	^selectedElements .	
! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'BAG 4/27/2021 00:34:18'!
ifElement: anElement satisfies: aBlockCondition addTo: aCollectionOfElements
		(aBlockCondition value: anElement) ifTrue:[aCollectionOfElements add: anElement].! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'BAG 4/29/2021 00:56:34'!
restore: aStack from: anotherStack
	[anotherStack isEmpty] whileFalse:[aStack push: (anotherStack pop)].! !

!SentenceFinderByPrefix methodsFor: 'auxiliar operations' stamp: 'BAG 4/27/2021 00:40:58'!
selectSentencesWithPrefix: aPrefix
	^self from: stackOfSentences select: [:aSentence | aSentence beginsWith: aPrefix].! !


!SentenceFinderByPrefix methodsFor: 'asserts' stamp: 'BAG 4/27/2021 00:51:46'!
assertIsAStackOfSentences: aStack
	|nonSentences|
	nonSentences := (self from: aStack select: [:elem | (elem isKindOf: String) not ]). 
	
	nonSentences isEmpty ifFalse:[^self error: self class stackShouldOnlyContainSentencesErrorDescription ].! !

!SentenceFinderByPrefix methodsFor: 'asserts' stamp: 'BAG 4/27/2021 00:58:39'!
assertTypeIsStack: aStack
	(aStack isKindOf: OOStack) ifFalse:[^self error: self class collaboratorShouldBeAStackErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'asserts' stamp: 'BAG 4/27/2021 00:52:40'!
assertPrefixNotEmpty: aPrefix
	(aPrefix isEmpty) ifTrue:[^self error: self prefixCanNotBeEmptyErrorDescription ].! !

!SentenceFinderByPrefix class methodsFor: 'asserts' stamp: 'BAG 4/27/2021 00:53:12'!
assertPrefixWithoutBlanks: aPrefix
	(aPrefix includesSubString: ' ') ifTrue:[^self error: self prefixCanNotContainBlanksErrorDescription ].! !


!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'BAG 4/27/2021 00:57:25'!
collaboratorShouldBeAStackErrorDescription
	^'No se puede crear un Sentence finder con algo que no sea un stack'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'BAG 4/27/2021 00:52:40'!
prefixCanNotBeEmptyErrorDescription
	^'No se puede buscar una sentencia con prefijo vacío'.! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'BAG 4/27/2021 00:53:12'!
prefixCanNotContainBlanksErrorDescription
	^'No se puede buscar una sentencia con un prefijo que tenga espacios'.! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'BAG 4/27/2021 00:51:46'!
stackShouldOnlyContainSentencesErrorDescription
	^'No se puede crear un Sentence finder con un stack que no tiene sentencias'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'BAG 4/29/2021 01:33:45'!
createWithSentences: aStackOfSentences
	^self new initializeWithSentences: aStackOfSentences ! !
