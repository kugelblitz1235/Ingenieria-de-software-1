!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreInterfaceTest category: 'TusLibros'!
TestCase subclass: #StoreInterfaceTest
	instanceVariableNames: 'storeFactory clock clockDate debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterfaceTest methodsFor: 'create cart' stamp: 'BAG 6/24/2021 01:13:11'!
test01CanNotCreateCartWithInvalidUser
	| storeInterface |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	
	self should: [storeInterface createCartForUser: 'pepe' withPassword: '1234' ]
	 raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
			self assert: anError messageText = StoreInterface InvalidCredentialsErrorDescription.
		].
	! !

!StoreInterfaceTest methodsFor: 'create cart' stamp: 'BAG 6/24/2021 01:13:37'!
test02CanCreateCartWithValidCredentials
	| storeInterface cartID cartItems |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartItems := storeInterface listCart: cartID.
	
	self assert: 0 equals: cartItems size.
	! !

!StoreInterfaceTest methodsFor: 'create cart' stamp: 'BAG 6/24/2021 01:13:47'!
test03CanCreateMultipleCart
	| storeInterface cartID1 cartID2 cartItems1 cartItems2 |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartID2 := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartItems1 := storeInterface listCart: cartID1.
	cartItems2 := storeInterface listCart: cartID2.
	
	self assert: cartID1 ~= cartID2.
	self assert: 0 equals: cartItems1 size.
	self assert: 0 equals: cartItems2 size.
	! !


!StoreInterfaceTest methodsFor: 'add to cart' stamp: 'BAG 6/24/2021 01:36:34'!
test04AddBookToCart
	| storeInterface cartID cartItems item |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	item := storeFactory itemSellByTheStore. 
	
	storeInterface add: 1 of: item toCart: cartID  .
	cartItems := storeInterface listCart: cartID.
	
	self assert: 1 equals: cartItems size.
	self assert: 1 equals: (cartItems occurrencesOf: item).
	! !

!StoreInterfaceTest methodsFor: 'add to cart' stamp: 'BAG 6/24/2021 01:35:06'!
test05AddMultipleBooksToCart
	| storeInterface cartID cartItems item1 item2 |
	
	item1 := storeFactory itemSellByTheStore. 
	item2 := storeFactory anotherItemSellByTheStore.
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	
	storeInterface add: 1 of: item1 toCart: cartID  .
	storeInterface add: 1 of: item2 toCart: cartID  .
	cartItems := storeInterface listCart: cartID.
	
	self assert: 2 equals: cartItems size.
	self assert: 1 equals: (cartItems occurrencesOf: item1).
	self assert: 1 equals: (cartItems occurrencesOf: item2).
	! !

!StoreInterfaceTest methodsFor: 'add to cart' stamp: 'BAG 6/24/2021 01:14:23'!
test06CanNotAddBookToExpiredCart
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	
	self advanceMinutesBy: 31.
	
	self should: [storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (StoreInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].

	! !

!StoreInterfaceTest methodsFor: 'add to cart' stamp: 'BAG 6/24/2021 01:37:36'!
test07AddBookRefreshesTimeOfCart
	| storeInterface cartID cartItems item |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	item := storeFactory itemSellByTheStore.
	 
	self advanceMinutesBy: 15.
	storeInterface add: 1 of: item toCart: cartID.
	self advanceMinutesBy: 20.
	
	storeInterface add: 1 of: item toCart: cartID.
	
	cartItems := storeInterface listCart: cartID.
	 
	self assert: 2 equals: cartItems size.
	self assert: 2 equals: (cartItems occurrencesOf: item). 
	

	! !


!StoreInterfaceTest methodsFor: 'setup' stamp: 'BAG 6/22/2021 19:50:24'!
setUp
	storeFactory _ StoreTestObjectsFactory new.
	clock _ 0.
	clockDate _ DateAndTime now.
	debitBehavior _ [:amount : creditCard |].
	! !


!StoreInterfaceTest methodsFor: 'clock mocking' stamp: 'BAG 6/19/2021 12:04:15'!
actualTime
	^clock. 
	! !

!StoreInterfaceTest methodsFor: 'clock mocking' stamp: 'BAG 6/21/2021 19:07:47'!
advanceMinutesBy: aTimeSpan 
	clock _ clock +  aTimeSpan.! !

!StoreInterfaceTest methodsFor: 'clock mocking' stamp: 'BAG 6/19/2021 12:11:33'!
minutesElapsedSince: aTimeStamp
	^clock - aTimeStamp. 
	! !

!StoreInterfaceTest methodsFor: 'clock mocking' stamp: 'BAG 6/21/2021 19:08:02'!
today
	^clockDate.! !


!StoreInterfaceTest methodsFor: 'authentication mocking' stamp: 'BAG 6/21/2021 20:52:31'!
authenticate: aUsername with: aPassword
	^(storeFactory validUsername = aUsername and: storeFactory validPassword = aPassword) 
	or: (storeFactory anotherValidUsername = aUsername and: storeFactory anotherValidPassword = aPassword). 
	! !


!StoreInterfaceTest methodsFor: 'list cart' stamp: 'BAG 6/24/2021 01:15:15'!
test08CanNotListExpiredCart
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	
	self advanceMinutesBy: 31.
	
	self should: [storeInterface listCart: cartID]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: anError messageText equals: (StoreInterface cartDoesNotExistErrorDescription).
		].
	! !

!StoreInterfaceTest methodsFor: 'list cart' stamp: 'BAG 6/24/2021 01:35:59'!
test09ListCartRefreshesTime
	| storeInterface cartID cartItems |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self advanceMinutesBy: 15.
	cartItems := storeInterface listCart: cartID.
	
	self advanceMinutesBy: 20.
	cartItems := storeInterface listCart: cartID.
	 
	self assert: 1 equals: cartItems size.
	self assert: 1 equals: (cartItems occurrencesOf:(storeFactory itemSellByTheStore)).
	

	! !


!StoreInterfaceTest methodsFor: 'list purchases' stamp: 'BAG 6/24/2021 11:10:13'!
test15CanNotListPurchasesWithInvalidCredentials
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	
	self should: [ 	storeInterface listPurchases: 'invalid user' password: 'invalid password'. ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (StoreInterface InvalidCredentialsErrorDescription) equals: anError messageText.
		].
	! !


!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:07:45'!
test10CheckoutCartWithOneItem
	| storeInterface cartID purchases items |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
			
	purchases := storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	items := (purchases at: 'items').
	
	self assert: (storeFactory itemSellByTheStorePrice) equals: (purchases at: 'total').
	self assert: 1 equals: (items at: (storeFactory itemSellByTheStore)).
	
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:07:58'!
test11CheckoutTwoCartsForSameClient
	| storeInterface cartID1 cartID2 purchases items expectedTotal |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	cartID2 := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID1.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID2.
	
	storeInterface checkOut: cartID1 
			    creditCard: (storeFactory validCreditCardNumber)  
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	storeInterface checkOut: cartID2 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	purchases := storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	items := (purchases at: 'items').
	expectedTotal := 2* storeFactory itemSellByTheStorePrice.
	 
	self assert:  2 equals: (items at: storeFactory itemSellByTheStore).
	self assert: expectedTotal equals: (purchases at: 'total').
	
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:08:10'!
test12CheckoutWithMultipleItems
	| storeInterface cartID purchases expectedTotal items |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 5 of: (storeFactory itemSellByTheStore) toCart: cartID.
	storeInterface add: 5 of: (storeFactory anotherItemSellByTheStore) toCart: cartID.
	
	storeInterface checkOut: cartID
			    creditCard: (storeFactory validCreditCardNumber)  
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	purchases := storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	items := (purchases at: 'items').
	expectedTotal := 5*(storeFactory itemSellByTheStorePrice + storeFactory anotherItemSellByTheStorePrice).
	 
	self assert:  5 equals: (items at: storeFactory itemSellByTheStore).
	self assert:  5 equals: (items at: storeFactory anotherItemSellByTheStore).
	self assert: expectedTotal equals: (purchases at: 'total').
	
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:08:24'!
test13CheckoutCartsForTwoClient
	| storeInterface cartID1 cartID2 purchasesClient1 purchasesClient2 items1 items2 |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	cartID2 := storeInterface createCartForUser: storeFactory anotherValidUsername withPassword: storeFactory anotherValidPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID1.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID2.
	
	storeInterface checkOut: cartID1 
			    creditCard: (storeFactory validCreditCardNumber)  
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	storeInterface checkOut: cartID2 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory anotherValidUsername .
			
	purchasesClient1 := storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	items1 := (purchasesClient1 at: 'items').
	purchasesClient2 := storeInterface listPurchases: storeFactory anotherValidUsername password: storeFactory anotherValidPassword.
	items2 := (purchasesClient2 at: 'items').
	 
	self assert:  1 equals: (items1 at: storeFactory itemSellByTheStore).
	self assert:  1 equals: (items2 at: storeFactory itemSellByTheStore).
	self assert: storeFactory itemSellByTheStorePrice equals: (purchasesClient1 at: 'total').
	self assert: storeFactory itemSellByTheStorePrice equals: (purchasesClient2 at: 'total').
	
	
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:08:30'!
test14CanNotCheckoutExpiredCart
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self advanceMinutesBy: 31.
	
	self should: [storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber)  
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (StoreInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:09:42'!
test16CanNotCheckoutSameCartTwice
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
			
	
	self should: [storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber)
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (StoreInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:09:49'!
test17CanNotCheckoutWithInvalidExpirationDate
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self should: [storeInterface checkOut: cartID 
			    creditCard: (storeFactory validCreditCardNumber) 
			    expiredOnMonth: 13 
			    andYear: 202  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
			| purchases |
			self assert: (CreditCard invalidExpirationDateErrorDescription ) equals: anError messageText.
			purchases := (storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword).
			self assert: 0 equals: (purchases at: 'items') size.
			self assert: 0 equals: (purchases at: 'total').
		].
	! !

!StoreInterfaceTest methodsFor: 'checkout cart' stamp: 'BAG 6/24/2021 11:09:58'!
test18CanNotCheckoutWithInvalidCreditCardNumber
	| storeInterface cartID |
	
	storeInterface := StoreInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := storeInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	storeInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self should: [storeInterface checkOut: cartID 
			    creditCard: (storeFactory invalidCreditCardNumber) 
			    expiredOnMonth: 12 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
			| purchases |
			self assert: (StoreInterface canNotDebitErrorDescription ) equals: anError messageText.
			purchases := (storeInterface listPurchases: storeFactory validUsername password: storeFactory validPassword).
			self assert: 0 equals: (purchases at: 'items') size.
			self assert: 0 equals: (purchases at: 'total').
		].
	! !


!StoreInterfaceTest methodsFor: 'merchant processor mocking' stamp: 'BAG 6/21/2021 18:49:11'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'BAG 6/24/2021 01:20:39'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'BAG 6/22/2021 19:08:57'!
items
	^items ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'BAG 6/21/2021 20:19:08'!
createSale

	^ Sale of: total withBooks: cart items clientName: creditCard ownerName.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'BAG 6/21/2021 21:33:13'!
initializeExpiringOnMonth: aMonth andYear: aYear for: anOwnerName
	owner := anOwnerName .
	expiration := Month month: aMonth year: aYear ! !


!CreditCard methodsFor: 'accesing' stamp: 'BAG 6/21/2021 20:03:08'!
ownerName
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'BAG 6/21/2021 22:01:40'!
assertValidExpirationDateFor: aYear and: aMonth

	(aMonth asNumber between: 1 and: 12) ifFalse: [self error: self invalidExpirationDateErrorDescription].
	(aYear numberOfDigitsInBase: 10) = 4  ifFalse: [self error: self invalidExpirationDateErrorDescription]! !

!CreditCard class methodsFor: 'instance creation' stamp: 'BAG 6/21/2021 21:38:03'!
expiringOnMonth: aMonth andYear: aYear for: anOwnerName
	self assertValidExpirationDateFor: aYear and: aMonth.
	
	^self new initializeExpiringOnMonth: aMonth andYear: aYear for: anOwnerName ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'BAG 6/21/2021 21:36:57'!
invalidExpirationDateErrorDescription
	^'La fecha de expiración es inválida'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total books clientName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'BAG 6/21/2021 20:19:28'!
initializeTotal: aTotal books: anBooks clientName: aClientName  

	total := aTotal. 
	books := anBooks. 
	clientName := aClientName .! !


!Sale methodsFor: 'accesing' stamp: 'BAG 6/21/2021 20:19:41'!
books
	^books ! !

!Sale methodsFor: 'accesing' stamp: 'BAG 6/21/2021 20:19:51'!
clientName
	^clientName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'BAG 6/21/2021 20:19:18'!
of: aTotal withBooks: anBooks clientName: aClientName

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal books: anBooks clientName: aClientName ! !


!classDefinition: #StoreInterface category: 'TusLibros'!
Object subclass: #StoreInterface
	instanceVariableNames: 'userAuthenticator nextID nextTransactionID activeCarts catalog clock lastTimeUsedForCart merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterface methodsFor: 'cart creation' stamp: 'BAG 6/24/2021 01:59:47'!
createCartForUser: aUsername withPassword: aPassword 
	self assertAuthenticationForUser: aUsername password: aPassword. 
	
	nextID := nextID +1.
	activeCarts at: nextID put: (Cart acceptingItemsOf: catalog).
	lastTimeUsedForCart at: nextID put: clock actualTime.
	
	^nextID.
	! !


!StoreInterface methodsFor: 'private - operations' stamp: 'BAG 6/24/2021 01:56:20'!
purchasesForClientSales: aClientSales
	| purchases total items |
	
	items := aClientSales inject: Bag new into: [ :books :sale |		books addAll: (sale books). books				].
	total := aClientSales sum: [:sale | sale total ] ifEmpty: [0].
	
	purchases := Dictionary new.
	purchases at: 'items' put: items contents.
	purchases at: 'total' put: total.
	
	^purchases. 
	! !

!StoreInterface methodsFor: 'private - operations' stamp: 'BAG 6/19/2021 13:39:11'!
refreshLastTimeUsed: aCartID
	lastTimeUsedForCart at: aCartID put: clock actualTime.
	 
	! !

!StoreInterface methodsFor: 'private - operations' stamp: 'BAG 6/21/2021 21:15:20'!
removeCart: cartID

	activeCarts removeKey: cartID.
	lastTimeUsedForCart removeKey: cartID! !


!StoreInterface methodsFor: 'operations' stamp: 'BAG 6/24/2021 01:18:33'!
add: aQuantity of: aBookISBN toCart: aCartID
	self assertCartIsValid: aCartID. 
	self refreshLastTimeUsed: aCartID.
	
	(activeCarts at: aCartID) add: aQuantity of: aBookISBN. 
	 
	! !

!StoreInterface methodsFor: 'operations' stamp: 'BAG 6/24/2021 02:00:21'!
checkOut: aCartID creditCard: creditCardNumber expiredOnMonth: expirationMonth andYear: expirationYear owner: ownerName
	| cashier card |
	self assertValidCreditCardNumber: creditCardNumber. 
	self assertCartIsValid: aCartID. 
	self refreshLastTimeUsed: aCartID.
	
	card := CreditCard expiringOnMonth: expirationMonth andYear: expirationYear for: ownerName.
	cashier := Cashier toCheckout: (activeCarts at: aCartID) charging: card throught: merchantProcessor on: (clock today)  registeringOn: salesBook.
	cashier checkOut. 
	
	self removeCart: aCartID.
	
	nextTransactionID := nextTransactionID +1.
	^nextTransactionID 
	! !

!StoreInterface methodsFor: 'operations' stamp: 'BAG 6/24/2021 01:38:36'!
listCart: aCartID
	self assertCartIsValid: aCartID. 
	self refreshLastTimeUsed: aCartID.
	
	^(activeCarts at: aCartID) items.
	
	! !

!StoreInterface methodsFor: 'operations' stamp: 'BAG 6/24/2021 01:54:32'!
listPurchases: aUsername password: aPassword
	| clientSales |
	self assertAuthenticationForUser: aUsername password: aPassword. 
	
	clientSales := (salesBook select: [:sale | sale clientName = aUsername]).
	
	^self purchasesForClientSales: clientSales. 
	! !


!StoreInterface methodsFor: 'initialization' stamp: 'BAG 6/24/2021 01:58:33'!
initializeWithAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor   
	userAuthenticator := aUserAuthenticator.
	nextID := 0.
	nextTransactionID := 0.
	activeCarts := Dictionary new.
	lastTimeUsedForCart := Dictionary new.
	salesBook := OrderedCollection new.
	catalog := aCatalog. 
	clock := aClock.
	merchantProcessor := aMerchantProcessor. 
	
	! !


!StoreInterface methodsFor: 'assertions' stamp: 'BAG 6/22/2021 18:46:29'!
assertAuthenticationForUser: aUsername password: aPassword

	^ (userAuthenticator authenticate: aUsername with: aPassword) ifFalse:[self error: self class InvalidCredentialsErrorDescription]! !

!StoreInterface methodsFor: 'assertions' stamp: 'BAG 6/19/2021 13:39:11'!
assertCartExists: aCartID

	lastTimeUsedForCart at:  aCartID 
	ifAbsent: [
		self error: self class cartDoesNotExistErrorDescription
		]! !

!StoreInterface methodsFor: 'assertions' stamp: 'BAG 6/24/2021 00:56:30'!
assertCartExpired: aCartID
	lastTimeUsedForCart at: aCartID 
	ifPresent: [:lastTime | (clock minutesElapsedSince: lastTime) > 30 ifTrue: [ 
		self removeCart: aCartID.
		self error: self class cartDoesNotExistErrorDescription.
		]].
	

	! !

!StoreInterface methodsFor: 'assertions' stamp: 'BAG 6/24/2021 01:01:36'!
assertCartIsValid: aCartID

	self assertCartExpired: aCartID.
	self assertCartExists: aCartID! !

!StoreInterface methodsFor: 'assertions' stamp: 'BAG 6/24/2021 02:26:15'!
assertValidCreditCardNumber: aCreditCardNumber

	^ ((aCreditCardNumber asNumber numberOfDigitsInBase: 10) = 16) ifFalse: [self error: self class canNotDebitErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreInterface class' category: 'TusLibros'!
StoreInterface class
	instanceVariableNames: ''!

!StoreInterface class methodsFor: 'error descriptions' stamp: 'BAG 6/21/2021 21:03:16'!
InvalidCredentialsErrorDescription
	^'Las credenciales ingresadas son inválidas.'! !

!StoreInterface class methodsFor: 'error descriptions' stamp: 'BAG 6/24/2021 02:20:58'!
canNotDebitErrorDescription
	^'No se puede realizar el débito'! !

!StoreInterface class methodsFor: 'error descriptions' stamp: 'BAG 6/19/2021 11:35:21'!
cartDoesNotExistErrorDescription
	^'El ID ingresado no está asociado a ningún carrito existente'.! !


!StoreInterface class methodsFor: 'as yet unclassified' stamp: 'BAG 6/21/2021 18:15:40'!
withAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor   
	^self new initializeWithAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor. ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/19/2021 10:56:15'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/19/2021 10:56:38'!
anotherItemSellByTheStorePrice
	
	^20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/21/2021 20:51:18'!
anotherValidPassword 
	^ '4444'. 	! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/21/2021 20:51:28'!
anotherValidUsername 
 	^'pepe' . 
	! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/19/2021 10:56:22'!
itemSellByTheStore
	
	^ 'validBook1'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/21/2021 20:06:37'!
validPassword 
	^ '3333'. 	! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'BAG 6/21/2021 20:06:32'!
validUsername 
 	^'RupertoEl+Kpo' . 
	! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'BAG 6/19/2021 11:15:35'!
defaultCatalog
	
	^ Dictionary 
		with:	(Association key: self itemSellByTheStore value: self itemSellByTheStorePrice)
		with:	(Association key: self anotherItemSellByTheStore value: self anotherItemSellByTheStorePrice) ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BAG 6/21/2021 22:03:03'!
expiredCreditCard
	^CreditCard expiringOnMonth: today monthIndex  andYear: today yearNumber -1 for: (self validUsername).! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BAG 6/24/2021 11:07:05'!
invalidCreditCardNumber
	
	^'0034567891234567'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BAG 6/21/2021 21:59:01'!
notExpiredCreditCard
	
	^CreditCard expiringOnMonth: today monthIndex andYear: today yearNumber +1 for: (self validUsername).! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BAG 6/24/2021 11:06:31'!
validCreditCardNumber
	
	^'1234567891234567'.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
