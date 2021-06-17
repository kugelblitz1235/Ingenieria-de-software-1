!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:04:28'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:04:50'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [ cart add: testObjectFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:04:57'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: testObjectFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:05:05'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:05:12'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:10:15'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: testObjectFactory itemSellByTheStore.
	self assert: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:10:23'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	self deny: (cart includes: testObjectFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'BAG 6/14/2021 23:10:38'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectFactory createCart.
	
	cart add: 2 of: testObjectFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'BAG 6/14/2021 23:03:48'!
setUp
	testObjectFactory := StoreTestObjectFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'storeFactory cart cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'BAG 6/17/2021 00:29:45'!
setUp
	storeFactory := StoreTestObjectFactory new.
	cart := storeFactory createCart.
	cashier := storeFactory createCashier.
	! !


!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:17:48'!
test01CanNotCheckoutAnEmptyCart
	| salesBook |
	salesBook := storeFactory createSalesBook.
	
	self 
		should: [cashier checkout: cart charging: storeFactory validCreditCard on: storeFactory today registeredOn: salesBook ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier invalidCartErrorMessage.
			self assert: cart isEmpty.
			self assert: salesBook isEmpty. 
		].! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:19:15'!
test02CheckoutCartWithOneItemReturnsTotal
	| catalog salesBook |
	salesBook := storeFactory createSalesBook .
	catalog := storeFactory  defaultCatalog.
	 
	cart add: storeFactory itemSellByTheStore. 
	self assert: (catalog at: storeFactory itemSellByTheStore) equals: (cashier checkout: 
														cart charging: storeFactory validCreditCard  
														on: storeFactory today 
														registeredOn: salesBook ). 
	self assert: 1 equals: salesBook size. 
	self assert:  (storeFactory itemSellByTheStorePrice) equals: salesBook first.
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:24:33'!
test03CheckoutCartWithManyItemsReturnsTotal
	| salesBook |
	salesBook := storeFactory createSalesBook.
	
	cart add: 5 of: storeFactory itemSellByTheStore.
	
	self assert: cart total equals: (cashier checkout: cart 
								  charging:  storeFactory validCreditCard 
								  on: storeFactory today 
								  registeredOn: salesBook). 
	self assert: 1 equals: salesBook size. 
	self assert: (5 * storeFactory itemSellByTheStorePrice) equals: salesBook first.
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:25:31'!
test04CanNotCheckoutWithExpiredCard
	| salesBook |
	salesBook := storeFactory createSalesBook. 
	
	cart add:storeFactory itemSellByTheStore. 
	
	self should:[cashier checkout: cart charging: storeFactory expiredCreditCard  on: storeFactory today  registeredOn: salesBook] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :error | 
			self assert: error messageText = cashier invalidCardErrorMessage.
			self assert: salesBook isEmpty.
		].
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:26:10'!
test05CanNotCheckoutWithStolenCard
	| salesBook |
	salesBook := storeFactory createSalesBook. 
	
	cart add:storeFactory itemSellByTheStore. 
	
	self should:[cashier checkout: cart charging: storeFactory stolenCreditCard  on:storeFactory today  registeredOn: salesBook ] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :error | 
			self assert: error messageText = MerchantProcessorSimulator stolenCreditCardErrorDescription.
			self assert: salesBook isEmpty.
		].
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:26:37'!
test06CanNotCheckoutWithFakeCard
	| salesBook |
	salesBook := storeFactory createSalesBook.

	cart add:storeFactory itemSellByTheStore. 
	
	self should:[cashier checkout: cart charging: storeFactory fakeCreditCard  on:storeFactory today  registeredOn: salesBook ] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :error | 
			self assert: error messageText = MerchantProcessorSimulator fakeCreditCardErrorDescription.
			self assert: salesBook isEmpty.
		].
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:26:50'!
test07CanNotCheckoutWithoutEnoughBalance
	| salesBook |
	salesBook := storeFactory createSalesBook.
	
	cart add: 80 of:storeFactory itemSellByTheStore. 
	
	self should:[cashier checkout: cart charging: storeFactory validCreditCard  on:storeFactory today  registeredOn: salesBook ] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :error | 
			self assert: error messageText = MerchantProcessorSimulator notEnoughBalanceErrorDescription.
			self assert: salesBook isEmpty.
		].
	
		! !

!CashierTest methodsFor: 'tests' stamp: 'BAG 6/17/2021 00:28:18'!
test08CanNotCheckoutSecondTimeWithoutEnoughBalance
	| salesBook validCreditCard |
	validCreditCard  := storeFactory validCreditCard. 
	salesBook := storeFactory createSalesBook.
	
	cart add: 5 of:storeFactory itemSellByTheStore. 
	
	cashier checkout: cart charging: validCreditCard  on: storeFactory today  registeredOn: salesBook.
	 
	self should:[cashier checkout: cart charging: validCreditCard  on: storeFactory today  registeredOn: salesBook ] 
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [ :error | 
			self assert: error messageText = MerchantProcessorSimulator notEnoughBalanceErrorDescription.
			self assert: 1 equals: salesBook size.
			self assert: 5 * (storeFactory itemSellByTheStorePrice) equals: salesBook first.
		].
	
		! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'BAG 6/10/2021 20:39:46'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'BAG 6/10/2021 21:40:45'!
total

	^items sum:[:item | catalog at: item] ifEmpty:[0].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'BAG 6/16/2021 23:49:59'!
checkout: aCart charging: aCreditCard on: aDate registeredOn: salesBook
	| sale |
	self assertCartIsNotEmpty: aCart.
	self assertCreditCard: aCreditCard IsNotExpiredOn: aDate.
	
	sale := aCart total.
	merchantProcessor debitFor: aCreditCard amount: sale.
	salesBook add: sale.
	
	^sale.! !


!Cashier methodsFor: 'error descriptions' stamp: 'BAG 6/10/2021 21:52:27'!
invalidCardErrorMessage
	^'No se puede cobrar con una tarjeta vencida.'! !

!Cashier methodsFor: 'error descriptions' stamp: 'BAG 6/10/2021 19:52:33'!
invalidCartErrorMessage
	^'No se puede cobrar con un carrito inválido.'! !


!Cashier methodsFor: 'initialization' stamp: 'BAG 6/14/2021 19:41:15'!
initializeFor: aMerchantProcessor 
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'assertion' stamp: 'BAG 6/16/2021 23:46:53'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self invalidCartErrorMessage]! !

!Cashier methodsFor: 'assertion' stamp: 'BAG 6/16/2021 23:49:06'!
assertCreditCard: aCreditCard IsNotExpiredOn: aDate

	^ (aCreditCard isExpiredOn: aDate) ifTrue:[self error: self invalidCardErrorMessage]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'BAG 6/14/2021 19:40:31'!
for: aMerchantProcessor
	^self new initializeFor: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'expiration date' stamp: 'BAG 6/14/2021 18:56:34'!
isExpiredOn: aDate
	^expirationDate < aDate.! !


!CreditCard methodsFor: 'accesing' stamp: 'BAG 6/16/2021 23:28:11'!
number
	^number ! !


!CreditCard methodsFor: 'initializing' stamp: 'BAG 6/14/2021 18:39:13'!
initializeCardNumbered: aNumber owner: anOwner expiredOn: anExpirationMonthOfYear .
	number := aNumber.
	owner := anOwner.
	expirationDate := anExpirationMonthOfYear .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'BAG 6/14/2021 19:04:45'!
numbered: aNumber owner: anOwner expiredOn: anExpirationMonthOfYear
	(aNumber decimalDigitLength = 16) ifFalse: [self error: ''].
	anOwner withBlanksTrimmed isEmpty ifTrue: [self error: ''].
	
	^ self new initializeCardNumbered: aNumber owner: anOwner expiredOn: anExpirationMonthOfYear .! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'stolenCardNumber validCardNumber accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'BAG 6/16/2021 23:56:36'!
assertAccountFor: aCreditCard canDebit: anAmount

	^ (anAmount > accounts at: aCreditCard number) ifTrue: [self error: self class notEnoughBalanceErrorDescription]! !

!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'BAG 6/16/2021 23:52:11'!
assertCreditCardIsNotStolen: aCreditCard

	^ (stolenCardNumber = aCreditCard number) ifTrue: [self error: self class stolenCreditCardErrorDescription]! !

!MerchantProcessorSimulator methodsFor: 'assertions' stamp: 'BAG 6/16/2021 23:52:36'!
assertCreditCardIsValid: aCreditCard

	^ (validCardNumber = aCreditCard number) ifFalse: [self error: self class fakeCreditCardErrorDescription]! !


!MerchantProcessorSimulator methodsFor: 'auxiliar' stamp: 'BAG 6/17/2021 00:36:03'!
substract: anAmount from: anAccountNumber
	| balance |
	
	balance := accounts at: anAccountNumber .
	balance := balance - anAmount .
	accounts at: anAccountNumber put: balance.! !


!MerchantProcessorSimulator methodsFor: 'transactions' stamp: 'BAG 6/17/2021 00:36:27'!
debitFor: aCreditCard amount: anAmount
	
	self assertCreditCardIsNotStolen: aCreditCard.
	self assertCreditCardIsValid: aCreditCard.
	self assertAccountFor: aCreditCard canDebit: anAmount.
	
	self substract: anAmount from: aCreditCard number.
	! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'BAG 6/16/2021 23:31:45'!
initializeWithStolenCardNumber: aStolenCardNumber andValidCardNumber: aValidCardNumber andAccount: anAccount
	stolenCardNumber := aStolenCardNumber .
	validCardNumber := aValidCardNumber.
	accounts := anAccount .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'error description' stamp: 'BAG 6/14/2021 21:39:56'!
fakeCreditCardErrorDescription
	^'No puede realizarse el débito porque la tarjeta es falsa'.! !

!MerchantProcessorSimulator class methodsFor: 'error description' stamp: 'BAG 6/14/2021 21:58:13'!
notEnoughBalanceErrorDescription
	^'No puede realizarse el débito porque la tarjeta no tiene saldo suficiente'.! !

!MerchantProcessorSimulator class methodsFor: 'error description' stamp: 'BAG 6/14/2021 19:57:54'!
stolenCreditCardErrorDescription
	^'No puede realizarse el débito porque la tarjeta es robada'.! !


!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'BAG 6/16/2021 23:31:28'!
withStolenCardNumber: aStolenCardNumber andValidCardNumber: aValidCardNumber andAccount: account
	^self new initializeWithStolenCardNumber: aStolenCardNumber andValidCardNumber: aValidCardNumber andAccount: account. ! !


!classDefinition: #StoreTestObjectFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectFactory methodsFor: 'sales book' stamp: 'BAG 6/14/2021 21:05:23'!
createSalesBook
	^OrderedCollection new.! !


!StoreTestObjectFactory methodsFor: 'sell item' stamp: 'BAG 6/14/2021 21:01:00'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectFactory methodsFor: 'sell item' stamp: 'BAG 6/14/2021 21:00:07'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectFactory methodsFor: 'sell item' stamp: 'BAG 6/14/2021 22:05:59'!
itemSellByTheStorePrice
	
	^ 5! !


!StoreTestObjectFactory methodsFor: 'cashier' stamp: 'BAG 6/14/2021 21:17:48'!
createCashier
	^Cashier for: self createMerchantProcessor .! !


!StoreTestObjectFactory methodsFor: 'date' stamp: 'BAG 6/14/2021 21:02:29'!
today
	^today! !


!StoreTestObjectFactory methodsFor: 'merchant processor' stamp: 'BAG 6/16/2021 23:42:21'!
createMerchantProcessor
	| stolenCardNumber validCardNumber account |
	stolenCardNumber := self stolenCreditCard number.
	validCardNumber := self validCreditCard number.
	account := Dictionary with: (Association key: validCardNumber value: (self itemSellByTheStorePrice)*5 ).
	
	^MerchantProcessorSimulator withStolenCardNumber: stolenCardNumber andValidCardNumber: validCardNumber andAccount: account.! !


!StoreTestObjectFactory methodsFor: 'initialization' stamp: 'BAG 6/16/2021 23:37:35'!
initialize
	today:= FixedGregorianDate today.! !


!StoreTestObjectFactory methodsFor: 'credit card' stamp: 'BAG 6/16/2021 23:36:08'!
expiredCreditCard
	^CreditCard numbered: 1234567812345678  owner: 'Ruperto'  expiredOn: FixedGregorianDate yesterday.! !

!StoreTestObjectFactory methodsFor: 'credit card' stamp: 'BAG 6/16/2021 23:37:45'!
fakeCreditCard
	^ CreditCard numbered: 1234567812345690  owner: 'Carlos'  expiredOn: FixedGregorianDate tomorrow .! !

!StoreTestObjectFactory methodsFor: 'credit card' stamp: 'BAG 6/16/2021 23:36:51'!
stolenCreditCard
	^CreditCard numbered: 1234567812345679  owner: 'Pepe'  expiredOn: FixedGregorianDate tomorrow .! !

!StoreTestObjectFactory methodsFor: 'credit card' stamp: 'BAG 6/16/2021 23:37:22'!
validCreditCard
	^CreditCard numbered: 1234567812345689  owner: 'Roberto'  expiredOn: FixedGregorianDate tomorrow.! !


!StoreTestObjectFactory methodsFor: 'catalog' stamp: 'BAG 6/14/2021 22:05:46'!
defaultCatalog
	
	^ Dictionary with: (Association key: self itemSellByTheStore  value: self itemSellByTheStorePrice).! !


!StoreTestObjectFactory methodsFor: 'cart' stamp: 'BAG 6/14/2021 21:00:33'!
createCart
	^Cart acceptingItemsOf: self defaultCatalog.
	
	! !
