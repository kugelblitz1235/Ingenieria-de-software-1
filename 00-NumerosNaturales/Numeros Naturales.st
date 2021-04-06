!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:09:43'!
* unFactor
	^unFactor.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 23:46:11'!
+ unSumando
		^unSumando next. 
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:26:00'!
- unSustraendo
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:20:42'!
/ unDivisor
	self = unDivisor ifTrue:[^I. ]. 
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:33:37'!
< unNumero
	^(self = unNumero) not.! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:45:56'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El divisor no puede ser mayor al dividendo en esta representación'! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:26:42'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los números negativos no son soportados en esta representación'! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	previous := nil.! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 20:59:04'!
next
	next ifNil: [
		next := self cloneNamed: self name,'I'].
		next previous: self.
	^next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 21:07:34'!
previous
	^previous.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 21:05:30'!
previous: aPredecesor
	previous := aPredecesor.
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 23:59:17'!
substractFrom: unMinuendo
	^unMinuendo previous! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:09:05'!
* unFactor
	^self previous * unFactor + unFactor.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 23:46:39'!
+ unSumando
	^self previous + unSumando next
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:01:32'!
- unSustraendo
	^unSustraendo substractFrom: self.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:44:33'!
/ unDivisor
	|cociente|
	self < unDivisor ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	self = unDivisor ifTrue: [^I ].
	cociente := self - unDivisor.
	cociente < unDivisor ifTrue: [^I]. 
	^(cociente / unDivisor) next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:34:19'!
< unNumero
	unNumero = I ifTrue:[^false].
	^self previous < unNumero previous.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:46:14'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El divisor no puede ser mayor al dividendo en esta representación'! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 00:04:02'!
next
	next ifNil: [
		next := self createChildNamed: self name,'I'].
		next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 21:59:05'!
previous
	^previous.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/5/2021 21:59:05'!
previous: aPredecesor
	previous := aPredecesor.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:00:01'!
substractFrom: unMinuendo
	^unMinuendo previous - self previous.
! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'BAG 4/6/2021 01:45:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!