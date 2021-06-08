!classDefinition: #ShoppingCartTest category: 'Ejercicio-TusLibros.com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'bookRuperto bookRicardo catalog shoppingCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:02'!
test01EmptyShoppingCartHasZeroUnitsOfABook

	self assert: 0 equals: (shoppingCart unitsOf: bookRuperto).! !

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:07'!
test02EmptyShoppingCartWithBookAddedOnceHasOneUnitOfThatBook
	catalog register: bookRuperto.
	
	shoppingCart add: bookRuperto units: 1.
	
	self assert: 1 equals: (shoppingCart unitsOf: bookRuperto)! !

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:13'!
test03EmptyShoppingCartWithBookAddedTwiceHasTwoUnitsOfThatBook
	catalog register: bookRuperto.
	
	shoppingCart add: bookRuperto units: 1.
	shoppingCart add: bookRuperto units: 1.
	
	self assert: 2 equals: (shoppingCart unitsOf: bookRuperto).! !

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:19'!
test04CanNotAddABookToShoppingCartThatIsNotInCatalog

	self should: [shoppingCart add: bookRuperto units: 1] raise: Error withMessageText: ShoppingCart bookIsNotInCatalogErrorDescription.! !

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:26'!
test05CanNotAddABookWithFractionalQuantityToShoppingCart

	self should: [shoppingCart add: bookRuperto units: 1.5] raise: Error withMessageText: ShoppingCart unitsHasToBeAPositiveIntegerErrorDescription.! !

!ShoppingCartTest methodsFor: 'adding books' stamp: 'TT 6/8/2021 18:58:36'!
test06CanNotAddABookWithNegativeQuantityToShoppingCart

	self should: [shoppingCart add: bookRuperto units: -5] raise: Error withMessageText: ShoppingCart unitsHasToBeAPositiveIntegerErrorDescription.! !


!ShoppingCartTest methodsFor: 'finding books' stamp: 'TT 6/8/2021 18:58:44'!
test07EmptyShoppingCartReturnsNoBooks
	| books |
	books := shoppingCart books.
	
	self assert: 0 equals: books size.! !

!ShoppingCartTest methodsFor: 'finding books' stamp: 'TT 6/8/2021 18:58:50'!
test08ShoppingCartWithOneUniqueBookReturnsThatBook
	| books |
	catalog register: bookRuperto.
	
	shoppingCart add: bookRuperto units: 5.
	 
	books := shoppingCart books.
	
	self assert: 1 equals: books size.
	self assert: bookRuperto equals: books first.! !

!ShoppingCartTest methodsFor: 'finding books' stamp: 'TT 6/8/2021 18:59:03'!
test09ShoppingCartWithTwoUniqueBooksReturnsThoseTwoBooks
	| books |
	catalog register: bookRuperto .
	catalog register: bookRicardo .
	
	shoppingCart add: bookRuperto units: 5.
	shoppingCart add: bookRicardo units: 7.
	 
	books := shoppingCart books.
	
	self assert: 2 equals: books size.
	self assert: bookRuperto equals: books first.
	self assert: bookRicardo equals: books second.! !


!ShoppingCartTest methodsFor: 'setup' stamp: 'TT 6/8/2021 18:57:21'!
setUp
	bookRuperto := '978-3-16-148410-0'.
	bookRicardo := '978-3-16-148410-1'.
	
	catalog := BookCatalog new.
	
	shoppingCart := ShoppingCart withBookCatalog: catalog.! !


!classDefinition: #BookCatalog category: 'Ejercicio-TusLibros.com'!
Object subclass: #BookCatalog
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!BookCatalog methodsFor: 'actions' stamp: 'TT 6/8/2021 18:37:01'!
register: aBook
	books add: aBook ! !


!BookCatalog methodsFor: 'accessing' stamp: 'TT 6/8/2021 18:37:13'!
has: aBook
	^books anySatisfy: [ :book | book = aBook ]! !


!BookCatalog methodsFor: 'initialization' stamp: 'TT 6/8/2021 00:04:42'!
initialize
	books := OrderedCollection new.! !


!classDefinition: #ShoppingCart category: 'Ejercicio-TusLibros.com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books bookCatalog newBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros.com'!

!ShoppingCart methodsFor: 'accessing' stamp: 'TT 6/8/2021 18:15:58'!
books
	| uniqueBooks |
	uniqueBooks := Set withAll: books.
	^OrderedCollection withAll: uniqueBooks ! !

!ShoppingCart methodsFor: 'accessing' stamp: 'TT 6/8/2021 18:22:35'!
has: aBook
	^books anySatisfy: [ :book | aBook = book ]! !

!ShoppingCart methodsFor: 'accessing' stamp: 'TT 6/8/2021 18:44:00'!
unitsOf: aBook
	^books occurrencesOf: aBook! !


!ShoppingCart methodsFor: 'asserts' stamp: 'TT 6/8/2021 18:44:54'!
assertBookIsInCatalog: aBook

	(bookCatalog has: aBook) ifFalse: [self signalBookIsNotInCatalog ]! !

!ShoppingCart methodsFor: 'asserts' stamp: 'TT 6/8/2021 18:21:32'!
assertQuantityIsPositiveInteger: aQuantity

	((aQuantity isKindOf: Integer) and: (aQuantity >= 0)) ifFalse: [self signalUnitHasToBePositiveInteger ].! !


!ShoppingCart methodsFor: 'signal errors' stamp: 'TT 6/8/2021 18:45:06'!
signalBookIsNotInCatalog

	self error: ShoppingCart bookIsNotInCatalogErrorDescription! !

!ShoppingCart methodsFor: 'signal errors' stamp: 'TT 6/8/2021 18:45:10'!
signalUnitHasToBePositiveInteger

	self error: ShoppingCart unitsHasToBeAPositiveIntegerErrorDescription! !


!ShoppingCart methodsFor: 'actions' stamp: 'TT 6/8/2021 18:33:26'!
add: aBook units: aQuantity 
	self assertQuantityIsPositiveInteger: aQuantity.
	self assertBookIsInCatalog: aBook.
	
	aQuantity timesRepeat: [ books add: aBook ]! !


!ShoppingCart methodsFor: 'initialization' stamp: 'TT 6/8/2021 18:40:38'!
initializeWithBookCatalog: aBookCatalog 
	bookCatalog := aBookCatalog.
	books := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'Ejercicio-TusLibros.com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error description' stamp: 'TT 6/8/2021 00:05:22'!
bookIsNotInCatalogErrorDescription
	^'El libro no existe en el catalogo'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'TT 6/8/2021 18:19:40'!
unitsHasToBeAPositiveIntegerErrorDescription
	^'Solo se puede agregar una cantidad entera positiva de un libro'! !

!ShoppingCart class methodsFor: 'error description' stamp: 'TT 6/8/2021 00:08:26'!
withBookCatalog: aBookCatalog
	^self new initializeWithBookCatalog: aBookCatalog ! !
