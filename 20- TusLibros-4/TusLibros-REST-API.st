!classDefinition: #TusLibrosRestInterface category: 'TusLibros-REST-API'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'portNumber port webServer store factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-REST-API'!

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'BAG 6/28/2021 16:32:51'!
initializeStore
	factory := StoreTestObjectsFactory new.

	store := TusLibrosSystemFacade
		authenticatingWith: (Dictionary with: (Association key: 'ruperto' value: 'pasta')) 
		acceptingItemsOf: factory defaultCatalog 
		registeringOn: OrderedCollection new
		debitingThrought: TusLibrosSystemFacadeTest new
		measuringTimeWith: DateAndTime
! !

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'BAG 6/28/2021 16:31:03'!
initializeWithPort: aPortNumber 

	self initializeStore.

	port := aPortNumber.
	webServer := WebServer new listenOn: port.

	self addService: '/catalog' action: self catalogHandler.
	self addService: '/login' action: self loginHandler.
	self addService: '/addToCart' action: self addToCartHandler.
	self addService: '/removeFromCart' action: self removeFromCartHandler.
	self addService: '/checkOut' action: self checkOutHandler.
	self addService: '/listPurchases' action: self listPurchasesHandler.
	self addService: '/listCart' action: self listCartHandler.! !


!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 7/7/2021 18:34:15'!
addToCartHandler

	^ [ :request | | idCart book amount |
		amount := (request fields at:'amount').
		book := (request fields at:'book').
		idCart := (request fields at:'id').
		
		store add: (amount asNumber) of: book toCartIdentifiedAs: (idCart asNumber).
		
		Dictionary newFromPairs: {'status'.200.}
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 6/28/2021 20:53:01'!
catalogHandler

	^ [ :request | | titles prices catalog |
		
		prices := store catalog.
		titles := factory defaultTitlesCatalog.
		catalog := Dictionary new.
				
		prices keysDo: [:isbn | | value |
			value:= (Dictionary new 
				at: 'price'  put: (prices at: isbn);
				at: 'title'  put: (titles at: isbn);
				yourself).
			
			catalog at: isbn 			put: value
		].
		
		catalog.
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 7/6/2021 20:16:51'!
checkOutHandler

	^ [ :request | | idCart ticket |
		idCart := (request fields at:'id').
		
		ticket := store checkOutCartIdentifiedAs: (idCart asNumber)
			withCreditCardNumbered: factory notExpiredCreditCardNumber
			ownedBy: factory notExpiredCreditCardOwner
			expiringOn: factory notExpiredMonthOfYear.
		
		ticket
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 6/28/2021 16:29:16'!
listCartHandler

	^ [ :request | | idCart listCart |
		idCart := (request fields at:'id').
		
		listCart := store listCartIdentifiedAs: (idCart asNumber).
		
		listCart asArray 
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 6/28/2021 16:29:23'!
listPurchasesHandler

	^ [ :request | | username password purchases |
		username := (request fields at:'username').
		password := (request fields at:'password').
		
		purchases := store listPurchasesOf: username authenticatingWith: password. 
		
		purchases
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 6/28/2021 16:29:32'!
loginHandler

	^ [ :request | | username password idCart |
		username := (request fields at:'username').
		password := (request fields at:'password').
		
		idCart := store createCartFor: username  authenticatedWith: password.
		
		idCart
	]! !

!TusLibrosRestInterface methodsFor: 'service handler' stamp: 'BAG 7/7/2021 18:34:28'!
removeFromCartHandler

	^ [ :request | | idCart book amount |
		amount := (request fields at:'amount').
		book := (request fields at:'book').
		idCart := (request fields at:'id').
		
		store remove: (amount asNumber) of: book toCartIdentifiedAs: (idCart asNumber).
		
		Dictionary newFromPairs: {'status'.200.}
	]! !


!TusLibrosRestInterface methodsFor: 'services' stamp: 'BAG 6/28/2021 16:02:47'!
addService: aServiceName action: aBlock
	webServer addService: aServiceName action:[:request |
		[ | response |
			response := aBlock value: request.
			request send200Response: (WebUtils jsonEncode: response)
		] on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) 
		]
	]! !


!TusLibrosRestInterface methodsFor: 'finalization' stamp: 'TT 6/24/2021 21:17:27'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: 'TusLibros-REST-API'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'TT 6/24/2021 21:12:33'!
listeningOn: aPortNumber

	^self new initializeWithPort: aPortNumber! !
