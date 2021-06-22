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


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'storeFactory clock debitBehavior clockDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 21:03:02'!
test01CanNotCreateCartWithInvalidUser
	| restInterface |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	
	self should: [restInterface createCartForUser: 'pepe' withPassword: '1234' ]
	 raise:  Error - MessageNotUnderstood
	withExceptionDo: [:anError | 
			self assert: anError messageText = RestInterface InvalidCredentialsErrorDescription.
		].
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:07:10'!
test02CanCreateCartWithValidCredentials
	| restInterface cartID cartItems |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartItems := restInterface listCart: cartID.
	
	self assert: 0 equals: cartItems size.
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:07:24'!
test03CanCreateMultipleCart
	| restInterface cartID1 cartID2 cartItems1 cartItems2 |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartID2 := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	cartItems1 := restInterface listCart: cartID1.
	cartItems2 := restInterface listCart: cartID2.
	
	self assert: cartID1 ~= cartID2.
	self assert: 0 equals: cartItems1 size.
	self assert: 0 equals: cartItems2 size.
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:07:40'!
test04AddBookToCart
	| restInterface cartID cartItems |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID  .
	cartItems := restInterface listCart: cartID.
	
	
	self assert: 2 equals: cartItems size.
	self assert: (storeFactory itemSellByTheStore) equals: cartItems first.
	self assert: 1 equals: cartItems second.
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:07:48'!
test05AddMultipleBooksToCart
	| restInterface cartID cartItems item1 item2 |
	
	item1 := storeFactory itemSellByTheStore. 
	item2 := storeFactory anotherItemSellByTheStore.
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword. 
	
	restInterface add: 1 of: item1 toCart: cartID  .
	restInterface add: 1 of: item2 toCart: cartID  .
	cartItems := restInterface listCart: cartID.
	
	self assert: 4 equals: cartItems size.
	self assert: item1 equals: (cartItems at: 1).
	self assert: 1 equals: (cartItems at: 2).
	self assert: item2 equals: (cartItems at: 3).
	self assert: 1 equals: (cartItems at: 4).
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:07:58'!
test06CanNotAddBookToExpiredCart
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	
	self advanceMinutesBy: 31.
	
	self should: [restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (RestInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].

	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:08:07'!
test07AddBookRefreshesTimeOfCart
	| restInterface cartID cartItems |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	
	self advanceMinutesBy: 15.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	self advanceMinutesBy: 20.
	
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	cartItems := restInterface listCart: cartID.
	 
	self assert: 2 equals: cartItems size.
	self assert: (storeFactory itemSellByTheStore) equals: cartItems first.
	self assert: 2 equals: cartItems second. 
	

	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:08:14'!
test08CanNotListExpiredCart
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	
	self advanceMinutesBy: 31.
	
	self should: [restInterface listCart: cartID]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: anError messageText equals: (RestInterface cartDoesNotExistErrorDescription).
		].
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:08:22'!
test09ListCartRefreshesTime
	| restInterface cartID cartItems |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self advanceMinutesBy: 15.
	cartItems := restInterface listCart: cartID.
	
	self advanceMinutesBy: 20.
	cartItems := restInterface listCart: cartID.
	 
	self assert: 2 equals: cartItems size.
	self assert: (storeFactory itemSellByTheStore) equals: cartItems first.
	self assert: 1 equals: cartItems second. 
	

	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:44:52'!
test10CheckoutCartWithOneItem
	| restInterface cartID expectedPurchases purchases |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
			
	purchases := restInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	expectedPurchases := OrderedCollection with: storeFactory itemSellByTheStore with: 1 with: storeFactory itemSellByTheStorePrice.
	 
	self assert: expectedPurchases size equals: purchases size.
	self assert: expectedPurchases equals: purchases.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:10:26'!
test11CheckoutTwoCartsForSameClient
	| restInterface cartID1 cartID2 expectedPurchases purchases |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	cartID2 := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID1.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID2.
	
	restInterface checkOut: cartID1 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	restInterface checkOut: cartID2 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	purchases := restInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	expectedPurchases := OrderedCollection with: storeFactory itemSellByTheStore 
										with: 2
										with: 2* storeFactory itemSellByTheStorePrice.
	 
	self assert: expectedPurchases size equals: purchases size.
	self assert: expectedPurchases equals: purchases.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:10:05'!
test12CheckoutWithMultipleItems
	| restInterface cartID expectedPurchases purchases |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 5 of: (storeFactory itemSellByTheStore) toCart: cartID.
	restInterface add: 5 of: (storeFactory anotherItemSellByTheStore) toCart: cartID.
	
	restInterface checkOut: cartID
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	purchases := restInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	expectedPurchases := OrderedCollection with: storeFactory itemSellByTheStore 
										with: 5 
										with: storeFactory anotherItemSellByTheStore 
										with: 5
										with: 5*(storeFactory itemSellByTheStorePrice + storeFactory anotherItemSellByTheStorePrice).
	 
	self assert: expectedPurchases size equals: purchases size.
	self assert: expectedPurchases equals: purchases.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:50:40'!
test13CheckoutCartsForTwoClient
	| restInterface cartID1 cartID2 expectedPurchases purchasesClient1 purchasesClient2 |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID1 := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	cartID2 := restInterface createCartForUser: storeFactory anotherValidUsername withPassword: storeFactory anotherValidPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID1.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID2.
	
	restInterface checkOut: cartID1 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername .
			
	restInterface checkOut: cartID2 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory anotherValidUsername .
			
	purchasesClient1 := restInterface listPurchases: storeFactory validUsername password: storeFactory validPassword.
	purchasesClient2 := restInterface listPurchases: storeFactory anotherValidUsername password: storeFactory anotherValidPassword.
	
	
	expectedPurchases := OrderedCollection with: storeFactory itemSellByTheStore 
										with: 1
										with: storeFactory itemSellByTheStorePrice.
	
	 
	self assert: expectedPurchases equals: purchasesClient2.
	self assert: expectedPurchases equals: purchasesClient1.
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 20:57:47'!
test14CanNotCheckoutExpiredCart
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self advanceMinutesBy: 31.
	
	self should: [restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (RestInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 21:03:02'!
test15CanNotListPurchasesWithInvalidCredentials
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	
	self should: [ 	restInterface listPurchases: 'invalid user' password: 'invalid password'. ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (RestInterface InvalidCredentialsErrorDescription) equals: anError messageText.
		].
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 21:13:16'!
test16CanNotCheckoutSameCartTwice
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
			
	
	self should: [restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 06 
			    andYear: 2021  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
		self assert: (RestInterface cartDoesNotExistErrorDescription) equals: anError messageText.
		].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'BAG 6/21/2021 22:03:40'!
test17CanNotCheckoutWithInvalidExpirationDate
	| restInterface cartID |
	
	restInterface := RestInterface withAuthenticator: self catalog: storeFactory defaultCatalog clock: self merchantProcessor: self.
	cartID := restInterface createCartForUser: storeFactory validUsername withPassword: storeFactory validPassword.
	restInterface add: 1 of: (storeFactory itemSellByTheStore) toCart: cartID.
	
	self should: [restInterface checkOut: cartID 
			    creditCard: '123456789123456' 
			    expiredOnMonth: 13 
			    andYear: 202  
			    owner: storeFactory validUsername.
	 ]  
	raise: Error - MessageNotUnderstood  
	withExceptionDo: [:anError |
			self assert: (CreditCard invalidExpirationDateErrorDescription ) equals: anError messageText.
		self assert: (restInterface listPurchases: storeFactory validUsername password: storeFactory validPassword) equals: (OrderedCollection with: 0)
		].
	! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'BAG 6/21/2021 20:09:42'!
setUp
	storeFactory _ StoreTestObjectsFactory new.
	clock _ 0.
	clockDate _ DateAndTime now.
	debitBehavior _ [:amount : creditCard |].! !


!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/19/2021 12:04:15'!
actualTime
	^clock. 
	! !

!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/21/2021 19:07:47'!
advanceMinutesBy: aTimeSpan 
	clock _ clock +  aTimeSpan.! !

!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/21/2021 20:52:31'!
authenticate: aUsername with: aPassword
	^(storeFactory validUsername = aUsername and: storeFactory validPassword = aPassword) 
	or: (storeFactory anotherValidUsername = aUsername and: storeFactory anotherValidPassword = aPassword). 
	! !

!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/21/2021 18:49:11'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/19/2021 12:11:33'!
minutesElapsedSince: aTimeStamp
	^clock - aTimeStamp. 
	! !

!RestInterfaceTest methodsFor: 'mocking' stamp: 'BAG 6/21/2021 19:08:02'!
today
	^clockDate.! !


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


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'BAG 6/21/2021 20:01:04'!
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


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'userAuthenticator nextID activeCarts catalog clock lastTimeUsedForCart merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'cart creation' stamp: 'BAG 6/21/2021 21:03:02'!
createCartForUser: aUsername withPassword: aPassword 
	(userAuthenticator authenticate: aUsername with: aPassword) ifFalse:[self error: self class InvalidCredentialsErrorDescription] . 
	
	nextID := nextID +1.
	activeCarts at: nextID put: (Cart acceptingItemsOf: catalog).
	lastTimeUsedForCart at: nextID put: clock actualTime.
	
	^nextID.
	! !


!RestInterface methodsFor: 'operations' stamp: 'BAG 6/19/2021 13:29:52'!
add: aQuantity of: aBookISBN toCart: aCartID
	self removeIfCartExpired: aCartID.
	self assertCartExists: aCartID. 
	self refreshLastTimeUsed: aCartID.
	
	(activeCarts at: aCartID ifAbsent: [self error: self class cartDoesNotExistErrorDescription]) add: aQuantity of: aBookISBN. 
	 
	! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/19/2021 13:39:11'!
assertCartExists: aCartID

	lastTimeUsedForCart at:  aCartID 
	ifAbsent: [
		self error: self class cartDoesNotExistErrorDescription
		]! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/21/2021 21:39:38'!
checkOut: cartID creditCard: creditCardNumber expiredOnMonth: expirationMonth andYear: expirationYear owner: ownerName
	| cashier card |
	self removeIfCartExpired: cartID.
	self assertCartExists: cartID. 
	self refreshLastTimeUsed: cartID.
	
	card := CreditCard expiringOnMonth: expirationMonth andYear: expirationYear for: ownerName.
	cashier := Cashier toCheckout: (activeCarts at: cartID) charging: card throught: merchantProcessor on: (clock today)  registeringOn: salesBook.
	cashier checkOut. 
	
	self removeCart: cartID.
	
	^1
	! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/19/2021 13:37:58'!
listCart: aCartID
	| cart listCart |
	
	self removeIfCartExpired: aCartID.
	self assertCartExists: aCartID. 
	self refreshLastTimeUsed: aCartID.
	
	listCart := OrderedCollection new. 
	cart _ activeCarts at: aCartID ifAbsent: [ self error: self class cartDoesNotExistErrorDescription].
	
	catalog keys do:[ :book | 	
		| quantity |
		
		quantity := cart occurrencesOf: book.
		quantity > 0 ifTrue:[
			listCart add: book.
			listCart add: quantity 
			].
		].

	^listCart.
	! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/21/2021 21:03:49'!
listPurchases: aUsername password: aPassword
	| purchases1 purchasesByClient total |
	(userAuthenticator authenticate: aUsername with: aPassword) ifFalse:[self error: self class InvalidCredentialsErrorDescription] . 
	
	purchases1:= OrderedCollection new.
	purchasesByClient := Bag new.
	total := 0.
	salesBook do: [ :sale |
			sale clientName = aUsername ifTrue: [ 
				total := total + sale total.
				purchasesByClient addAll: (sale books) ].
		].
	
	
	(purchasesByClient contents) associationsDo: [:item |
			purchases1 add: item key.
			purchases1 add: item value.
			
			].
	
	purchases1 add: total.
	
	^purchases1.! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/19/2021 13:39:11'!
refreshLastTimeUsed: aCartID
	lastTimeUsedForCart at: aCartID put: clock actualTime.
	 
	! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/21/2021 21:15:20'!
removeCart: cartID

	activeCarts removeKey: cartID.
	lastTimeUsedForCart removeKey: cartID! !

!RestInterface methodsFor: 'operations' stamp: 'BAG 6/21/2021 21:15:38'!
removeIfCartExpired: aCartID
	lastTimeUsedForCart at:  aCartID 
	ifPresent: [:lastTime | (clock minutesElapsedSince: lastTime) > 30 ifTrue: [ 
		self removeCart: aCartID.
		]] 

	! !


!RestInterface methodsFor: 'initialization' stamp: 'BAG 6/21/2021 20:39:49'!
initializeWithAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor   
	userAuthenticator := aUserAuthenticator.
	nextID := 0.
	activeCarts := Dictionary new.
	lastTimeUsedForCart := Dictionary new.
	salesBook := OrderedCollection new.
	catalog := aCatalog. 
	clock := aClock.
	merchantProcessor := aMerchantProcessor. 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'error descriptions' stamp: 'BAG 6/21/2021 21:03:16'!
InvalidCredentialsErrorDescription
	^'Las credenciales ingresadas son inválidas.'! !

!RestInterface class methodsFor: 'error descriptions' stamp: 'BAG 6/19/2021 11:35:21'!
cartDoesNotExistErrorDescription
	^'El ID ingresado no está asociado a ningún carrito existente'.! !


!RestInterface class methodsFor: 'as yet unclassified' stamp: 'BAG 6/21/2021 18:15:40'!
withAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor   
	^self new initializeWithAuthenticator: aUserAuthenticator catalog: aCatalog clock: aClock merchantProcessor: aMerchantProcessor. ! !


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

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'BAG 6/21/2021 21:59:01'!
notExpiredCreditCard
	
	^CreditCard expiringOnMonth: today monthIndex andYear: today yearNumber +1 for: (self validUsername).! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
