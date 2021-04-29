!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'BAG 4/19/2021 21:13:14'!
setUp

	zero := Entero with:0.
	one := Entero with:1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:40:02'!
addFromEntero: anEnteroAdder
	^self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:42:00'!
addFromFraccion: aFraccionAdder
	^self subclassResponsibility! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:42:05'!
divideFromEntero: anEnteroDividend
	^self subclassResponsibility! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:42:10'!
divideFromFraccion: aFraccionDividend
	^self subclassResponsibility! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:41:05'!
multiplyFromEntero: anEnteroMultiplier
	^self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'TT 4/20/2021 01:22:07'!
multiplyFromFraccion: aFraccionMultiplier
	^self subclassResponsibility ! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:41:21'!
substractFromEntero: anEnteroSubtrahend
	^ self subclassResponsibility 
	! !

!Numero methodsFor: 'private' stamp: 'TT 4/21/2021 12:41:39'!
substractFromFraccion: anEnteroSubtrahend
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'BAG 4/16/2021 20:45:52'!
* aMultiplier 
	^aMultiplier multiplyFromEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TT 4/16/2021 01:11:49'!
+ anAdder 
	^anAdder addFromEntero: self
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TT 4/16/2021 01:28:38'!
- aSubtrahend 
	^aSubtrahend substractFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'BAG 4/16/2021 20:41:35'!
/ aDivisor 
	^aDivisor divideFromEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'BAG 4/22/2021 00:32:32'!
// aDivisor 
	
	^Entero with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'TT 4/21/2021 13:07:16'!
fibonacci

	^self subclassResponsibility .
	
	"Si bien al momento de aplicar la tecnica de polimorfismo, los distintos ifs tenian condiciones que implicaban cuatro categorias: Negativos, Cero, Uno y MayorQueUno, pensamos que era mejor utilizar naturales en lugar de mayor que uno, y luego hacer que uno fuera una subclase de este. Creemos que esto representa mejor una jerarquia de los numeros que la otra, porque la clase MayorQueUno no parece formar parte de una forma de categorizar a los numeros."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'BAG 4/22/2021 00:33:36'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (self integerValue gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'BAG 4/22/2021 00:33:13'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'BAG 4/22/2021 00:33:56'!
hash

	^self integerValue hash! !



!Entero methodsFor: 'value' stamp: 'BAG 4/22/2021 00:40:25'!
integerValue

	^self subclassResponsibility ! !


!Entero methodsFor: 'printing' stamp: 'BAG 4/22/2021 00:34:37'!
printOn: aStream

	aStream print: self integerValue ! !


!Entero methodsFor: 'testing' stamp: 'BAG 4/22/2021 00:34:18'!
isNegative
	
	^self integerValue < 0! !

!Entero methodsFor: 'testing' stamp: 'BAG 4/22/2021 00:35:33'!
isOne
	
	^self integerValue = 1! !

!Entero methodsFor: 'testing' stamp: 'BAG 4/22/2021 00:35:06'!
isZero
	
	^self integerValue = 0! !


!Entero methodsFor: 'private' stamp: 'BAG 4/22/2021 00:31:46'!
addFromEntero: anEnteroAdder
	^Entero with: (anEnteroAdder integerValue + self integerValue)
! !

!Entero methodsFor: 'private' stamp: 'TT 4/21/2021 12:52:45'!
addFromFraccion: aFraccionAdder
	^Fraccion with: (aFraccionAdder numerator + aFraccionAdder denominator * self ) over: aFraccionAdder denominator 
		
	"Sabemos que esto es codigo repetido con respecto a la implementación de addFromEntero en la clase Fraccion, pero decidimos no sacarlo para que se vea reflejado los pasos que seguimos para sacar los ifs a traves del polimorfismo"! !

!Entero methodsFor: 'private' stamp: 'TT 4/20/2021 00:01:13'!
divideFromEntero: anEnteroDividend
	^Fraccion with: anEnteroDividend over: self! !

!Entero methodsFor: 'private' stamp: 'TT 4/20/2021 00:01:43'!
divideFromFraccion: aFraccionDividend
	^Fraccion with: aFraccionDividend numerator over: (aFraccionDividend denominator * self)! !

!Entero methodsFor: 'private' stamp: 'BAG 4/22/2021 00:31:06'!
multiplyFromEntero: anEnteroMultiplier
	^Entero with: anEnteroMultiplier integerValue * self integerValue ! !

!Entero methodsFor: 'private' stamp: 'TT 4/21/2021 12:52:19'!
multiplyFromFraccion: aFraccionMultiplier
	^Fraccion with: (aFraccionMultiplier numerator * self) over: aFraccionMultiplier denominator
	
	"Sabemos que esto es codigo repetido con respecto a la implementación de multiplyFromEntero en la clase Fraccion, pero decidimos no sacarlo para que se vea reflejado los pasos que seguimos para sacar los ifs a traves del polimorfismo"! !

!Entero methodsFor: 'private' stamp: 'BAG 4/22/2021 00:32:08'!
substractFromEntero: anEnteroSubtrahend
	^ Entero with: (anEnteroSubtrahend integerValue - self integerValue).
	! !

!Entero methodsFor: 'private' stamp: 'TT 4/20/2021 00:03:09'!
substractFromFraccion: anEnteroSubtrahend
	^Fraccion with: (anEnteroSubtrahend numerator - (self * anEnteroSubtrahend denominator)) over: anEnteroSubtrahend denominator! !


!Entero methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:56:02'!
fraccionWithKnownDenominatorValue: numerator
	^Fraccion new initializeWith: numerator over: self! !

!Entero methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:56:45'!
fraccionWithKnownDivisorAndDividend: aKnownDivisor
	| denominator greatestCommonDivisor numerator |
	greatestCommonDivisor := self greatestCommonDivisorWith: aKnownDivisor. 
	numerator := self // greatestCommonDivisor.
	denominator := aKnownDivisor // greatestCommonDivisor.
	
	^denominator fraccionWithKnownDenominatorValue: numerator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'BAG 4/22/2021 01:01:33'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	aValue =1 ifTrue:[^Uno new ].
	aValue =0 ifTrue:[^Cero new ].
	aValue <0 ifTrue:[^Negativos new initializeWith: aValue].
	^NaturalesMayoresAUno new initializeWith: aValue! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'BAG 4/19/2021 21:30:11'!
fibonacci
	^Entero with:1.! !


!Cero methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:54:12'!
fraccionWithKnownDivisorAndDividend: aKnownDivisor
	^self! !

!Cero methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:51:40'!
fraccionWithKnownDivisorValue: aDividend
	^self error: self class canNotDivideByZeroErrorDescription ! !


!Cero methodsFor: 'value' stamp: 'BAG 4/22/2021 00:46:37'!
integerValue
	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'BAG 4/21/2021 23:23:04'!
elCeroNoPuedeSerInicializadoConUnValor
	^'El Número cero no puede crear una instancia a partir de un valor'! !

!Cero class methodsFor: 'as yet unclassified' stamp: 'BAG 4/21/2021 23:22:20'!
with: aValue
	^self error: self elCeroNoPuedeSerInicializadoConUnValor! !


!classDefinition: #NaturalesMayoresAUno category: 'Numero-Exercise'!
Entero subclass: #NaturalesMayoresAUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NaturalesMayoresAUno methodsFor: 'arithmetic operations' stamp: 'BAG 4/19/2021 21:29:48'!
fibonacci

	| one two |
	
	one := Entero with:1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!NaturalesMayoresAUno methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:53:39'!
fraccionWithKnownDivisorValue: aDividend
	^aDividend fraccionWithKnownDivisorAndDividend: self! !


!NaturalesMayoresAUno methodsFor: 'value' stamp: 'BAG 4/22/2021 00:43:01'!
integerValue

	^value! !


!NaturalesMayoresAUno methodsFor: 'initialization' stamp: 'BAG 4/22/2021 01:14:37'!
initializeWith: aValue 
	"En este caso agregamos el if para prevenir un mal uso del método dado que si quisieramos quitar este if con polimorfismo deberíamos agregar un mensaje en la clase Integer del sistema "
	aValue <= 1 ifTrue:[^self error: self excepcionInicializandoNumeroNaturalMenorA2].
	value := aValue! !


!NaturalesMayoresAUno methodsFor: 'exceptions' stamp: 'BAG 4/22/2021 01:13:42'!
excepcionInicializandoNumeroNaturalMenorA2
	^'No puede inicializarse un número natural mayor a uno con un valor menor a 2'! !


!classDefinition: #Negativos category: 'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'fraccion initialization' stamp: 'TT 4/20/2021 00:52:41'!
fraccionWithKnownDivisorValue: aDividend
	^aDividend negated / self negated.
	
! !


!Negativos methodsFor: 'arithmetic operations' stamp: 'BAG 4/19/2021 20:44:19'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription.	! !


!Negativos methodsFor: 'value' stamp: 'BAG 4/22/2021 00:51:34'!
integerValue
	^value! !


!Negativos methodsFor: 'initialization' stamp: 'BAG 4/22/2021 01:14:28'!
initializeWith: aValue 
	"En este caso agregamos el if para prevenir un mal uso del método dado que si quisieramos quitar este if con polimorfismo deberíamos agregar un mensaje en la clase Integer del sistema "
	aValue >= 0 ifTrue:[^self error: self exceptionNegativoInicializadoConValorNoNegativo].
	value := aValue! !


!Negativos methodsFor: 'exceptions' stamp: 'BAG 4/22/2021 01:14:14'!
exceptionNegativoInicializadoConValorNoNegativo
	^'Un número negativo no puede ser inicializado con un valor mayor o igual a cero'! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'BAG 4/22/2021 00:18:19'!
fibonacci
	^self.! !


!Uno methodsFor: 'fraccion initialization' stamp: 'BAG 4/22/2021 00:18:34'!
fraccionWithKnownDenominatorValue: numerator
	^numerator.! !


!Uno methodsFor: 'value' stamp: 'BAG 4/22/2021 00:46:28'!
integerValue
	^1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'BAG 4/22/2021 00:20:29'!
unoNoPuedeInicializarseConUnValor
	^'El número uno no puede ser inicializado con un valor'! !

!Uno class methodsFor: 'as yet unclassified' stamp: 'BAG 4/22/2021 00:20:14'!
with: aValue
	^self error: self unoNoPuedeInicializarseConUnValor! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'BAG 4/16/2021 20:45:41'!
* aMultiplier 
	^aMultiplier multiplyFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TT 4/16/2021 01:13:26'!
+ anAdder 
	^anAdder addFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'TT 4/16/2021 01:32:34'!
- aSubtrahend 
	^aSubtrahend substractFromFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'BAG 4/16/2021 20:42:07'!
/ aDivisor 
	^aDivisor divideFromFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'private' stamp: 'BAG 4/19/2021 21:58:43'!
addFromEntero: anEnteroAdder
	^Fraccion with:((anEnteroAdder *denominator)+numerator) over: denominator.! !

!Fraccion methodsFor: 'private' stamp: 'BAG 4/19/2021 21:59:45'!
addFromFraccion: aFraccionAdder
	| newNumerator newDenominator |
	
	newNumerator := (aFraccionAdder denominator * numerator) + (aFraccionAdder numerator * denominator).
	newDenominator := aFraccionAdder denominator * denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:05:50'!
divideFromEntero: anEnteroDividend
	^Fraccion with: (anEnteroDividend * denominator) over: numerator.
	! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:05:37'!
divideFromFraccion: aFraccionDividend
	^(aFraccionDividend numerator * denominator ) / (aFraccionDividend denominator * numerator ) ! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:05:22'!
multiplyFromEntero: anEnteroMultiplier
	^Fraccion with: (anEnteroMultiplier * numerator ) over: denominator .! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:05:12'!
multiplyFromFraccion: aFraccionMultiplier
	^(aFraccionMultiplier numerator * numerator) / (aFraccionMultiplier denominator * denominator)
	! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:04:02'!
substractFromEntero: anEnteroSubtrahend
	^Fraccion with:((anEnteroSubtrahend * denominator) - numerator) over: denominator.! !

!Fraccion methodsFor: 'private' stamp: 'TT 4/20/2021 00:04:46'!
substractFromFraccion: aFraccionSubtrahend
	| newNumerator newDenominator |
	newNumerator := (aFraccionSubtrahend numerator * denominator) - (aFraccionSubtrahend denominator * numerator) .
	newDenominator :=  aFraccionSubtrahend denominator * denominator.
	
	^newNumerator / newDenominator 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'TT 4/20/2021 00:53:22'!
with: aDividend over: aDivisor
	
	^aDivisor fraccionWithKnownDivisorValue: aDividend ! !
