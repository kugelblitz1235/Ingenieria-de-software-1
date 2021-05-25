!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 deposit1 deposit2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/23/2021 16:50:21'!
test06ShouldNotAddAPortfolioTwice

	portfolio1 add: portfolio2.
	
	self should: [portfolio1 add: portfolio2 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/23/2021 16:50:20'!
test07ShouldNotAddTwoPortfoliosToEachOther

	portfolio1 add: portfolio2.
	
	self should: [portfolio2 add: portfolio1 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/25/2021 12:57:56'!
test08ShouldNotAddAPortfolioChildThatCanReachTheParent

	portfolio1 add: portfolio2.
	portfolio2 add: portfolio3.
	
	self should: [portfolio3 add: portfolio1 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/25/2021 12:58:06'!
test09ShouldNotAddAPortfolioChildThatIsReachableByParent

	portfolio1 add: portfolio2.
	portfolio2 add: portfolio3.
	
	self should: [portfolio1 add: portfolio3 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/25/2021 13:11:42'!
test10ShouldNotAddAPortfolioThatHasPortfoliosInCommon

	portfolio1 add: portfolio3.
	portfolio2 add: portfolio3.
	
	self should: [portfolio1 add: portfolio2 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/23/2021 16:50:35'!
test11ShouldNotAddAnAccountTwice

	portfolio1 add: account1.
	
	self should: [portfolio1 add: account1 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/23/2021 16:50:36'!
test12ShouldNotAddAPortfolioWithTheSameAccount

	portfolio1 add: account1.
	portfolio2 add: account1.
	
	self should: [portfolio1 add: portfolio2 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !

!PortfolioTest methodsFor: 'add' stamp: 'TT 5/25/2021 13:12:11'!
test13ShouldNotAddAPortfolioThatHasAccountsInCommon

	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio3 add: portfolio4.
	portfolio4 add: account1.
	
	self should: [portfolio2 add: portfolio3 ] raise: Error description: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription! !


!PortfolioTest methodsFor: 'balance' stamp: 'TT 5/23/2021 16:50:14'!
test01EmptyPortfolioHasZeroBalance

	self assert: 0 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'balance' stamp: 'TT 5/23/2021 16:50:36'!
test02PortfolioWithOneAccountGivesCorrectBalance

	portfolio1 add: account1 .
	
	self assert: 100 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'balance' stamp: 'TT 5/23/2021 16:50:38'!
test03PortfolioWithTwoAccountsGivesCorrectBalance

	portfolio1 add: account1.
	portfolio1 add: account2.
	
	self assert: 150 equals: portfolio1 balance.! !

!PortfolioTest methodsFor: 'balance' stamp: 'TT 5/23/2021 16:50:35'!
test04OneDepthPortfolioWithAnAccountGivesCorrectBalance

	portfolio2 add: account1.
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 balance) equals: 100.! !

!PortfolioTest methodsFor: 'balance' stamp: 'TT 5/23/2021 16:50:35'!
test05TwoDepthPortfolioWithAnAccountGivesCorrectBalance

	portfolio3 add: account1.
	portfolio2 add: portfolio3.
	portfolio1 add: portfolio2.
	
	self assert: portfolio1 balance equals: 100.! !


!PortfolioTest methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:50:15'!
test14EmptyPortfolioHasNoTransactions

	self assert: (portfolio1 transactions size = 0)! !

!PortfolioTest methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:50:42'!
test15PortfolioWithOneAccountHasOneTransaction
	| transactions |
	
	portfolio1 add: account1.
	
	transactions := OrderedCollection with: deposit1.
	
	self assert: (portfolio1 transactions) = transactions.! !

!PortfolioTest methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:50:45'!
test16PortfolioWithTwoAccountsHasTwoTransactions
	| transactions |
	
	portfolio1 add: account1.
	portfolio1 add: account2.
	
	transactions := OrderedCollection with: deposit1 with: deposit2.
	
	self assert: (portfolio1 transactions) = transactions.! !

!PortfolioTest methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:50:43'!
test17OneDepthPortfolioWithAnAccountHasOneTransaction
	| transactions |
	
	portfolio2 add: account1.
	portfolio1 add: portfolio2.
	
	transactions := OrderedCollection with: deposit1.
	
	self assert: portfolio1 transactions equals: transactions .! !

!PortfolioTest methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:50:42'!
test18TwoDepthPortfolioWithAnAccountHasOneTransaction
	| transactions |
	
	portfolio3 add: account1.
	portfolio2 add: portfolio3.
	portfolio1 add: portfolio2.
	
	transactions := OrderedCollection with: deposit1.
	
	self assert: portfolio1 transactions equals: transactions .! !


!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 16:50:45'!
test19PortfolioWithOneAccountDoesNotHaveATransactionRegistered
	
	portfolio1 add: account1.
	
	self deny: (portfolio1 hasRegistered: deposit2)! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 16:50:42'!
test20EmptyPortfolioDoesNotHaveTransactionsRegistered

	self deny: (portfolio1 hasRegistered: deposit1)! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 17:01:24'!
test21PortfolioWithOneAccountHasOneOfItsTransactionsRegistered

	portfolio1 add: account1.
	
	self assert: (portfolio1 hasRegistered: deposit1)! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 17:01:20'!
test22PortfolioWithTwoAccountsHasOneOfItsTransactionsRegistered
	
	portfolio1 add: account1.
	portfolio1 add: account2.
	
	self assert: (portfolio1 hasRegistered: deposit1)! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 17:01:17'!
test23OneDepthPortfolioWithAnAccountHasOneOfItsTransactionsRegistered

	portfolio2 add: account1.
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 hasRegistered: deposit1)! !

!PortfolioTest methodsFor: 'hasRegistered' stamp: 'TT 5/23/2021 17:01:13'!
test24TwoDepthPortfolioWithAnAccountHasOneOfItsTransactionsRegistered

	portfolio3 add: account1.
	portfolio2 add: portfolio3.
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 hasRegistered: deposit1)! !


!PortfolioTest methodsFor: 'setup' stamp: 'TT 5/23/2021 16:50:45'!
setUp
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	deposit1 := Deposit for: 100.
	deposit2 := Deposit for: 50.
	
	account1 register: deposit1.
	account2 register: deposit2.
	
	
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:32:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:32:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:33:00'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:33:05'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:33:12'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:33:17'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TT 5/25/2021 13:33:25'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'TT 5/17/2021 21:53:26'!
addTo: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'TT 5/25/2021 13:24:46'!
value

	^ value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'TT 5/25/2021 13:23:44'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'TT 5/17/2021 20:25:15'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'TT 5/17/2021 21:56:57'!
addTo: aBalance

	^aBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'TT 5/17/2021 21:54:22'!
addTo: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'actions - private' stamp: 'TT 5/23/2021 13:14:06'!
addAsPortfolioParent: aFinancialAsset
	
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'actions - private' stamp: 'TT 5/22/2021 01:56:27'!
containsFinancialAsset: aFinancialAsset

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'assertions' stamp: 'TT 5/23/2021 13:52:59'!
assertFinancialAssetIsNotReachable: aFinancialAsset
	
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'testing' stamp: 'TT 5/20/2021 21:33:52'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'balance' stamp: 'TT 5/20/2021 21:34:25'!
balance

	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions - private' stamp: 'TT 5/23/2021 16:08:22'!
addAllTransactionsTo: aCollectionOfTransactions
	self subclassResponsibility ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'TT 5/20/2021 21:34:06'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'actions - private' stamp: 'TT 5/23/2021 13:14:26'!
addAsPortfolioParent: aFinancialAsset 
	
	parents add: aFinancialAsset ! !

!Portfolio methodsFor: 'actions - private' stamp: 'TT 5/23/2021 13:15:27'!
containsFinancialAsset: aFinancialAsset

	^aFinancialAsset = self or: (financialAssets anySatisfy: [ :aFinancialAssetChild | aFinancialAssetChild containsFinancialAsset: aFinancialAsset]).! !


!Portfolio methodsFor: 'initialization' stamp: 'TT 5/21/2021 00:58:19'!
initialize
	financialAssets := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'TT 5/23/2021 14:32:26'!
balance
	
	^financialAssets sum: [ :aFinancialAssetChild | aFinancialAssetChild balance ] ifEmpty: [^0]
	! !


!Portfolio methodsFor: 'testing' stamp: 'TT 5/23/2021 14:32:14'!
hasRegistered: aTransaction 

	^financialAssets anySatisfy: [ :aFinancialAssetChild | aFinancialAssetChild hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'transactions - private' stamp: 'TT 5/23/2021 16:07:29'!
addAllTransactionsTo: aCollectionOfTransactions
	financialAssets do: [ :aFinancialAssetChild | aFinancialAssetChild addAllTransactionsTo: aCollectionOfTransactions ]. 
	! !


!Portfolio methodsFor: 'transactions' stamp: 'TT 5/23/2021 16:07:41'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	
	self addAllTransactionsTo: transactions.
	
	^transactions ! !


!Portfolio methodsFor: 'actions' stamp: 'TT 5/23/2021 14:00:29'!
add: aFinancialAsset 

	self assertNoFinancialAssetIsSharedWith: aFinancialAsset .
	
	financialAssets add: aFinancialAsset.
	aFinancialAsset addAsPortfolioParent: self.! !


!Portfolio methodsFor: 'assertions' stamp: 'TT 5/23/2021 14:03:48'!
assertNoFinancialAssetIsReachableFrom: aFinancialAsset
	
	(aFinancialAsset containsFinancialAsset: self) ifTrue: [self error: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription ].
	
	financialAssets do: [ :aFinancialAssetChild | aFinancialAssetChild assertNoFinancialAssetIsReachableFrom: aFinancialAsset]
	! !

!Portfolio methodsFor: 'assertions' stamp: 'TT 5/23/2021 14:04:10'!
assertNoFinancialAssetIsSharedWith: aFinancialAsset

	parents size = 0 ifTrue: [
		aFinancialAsset assertNoFinancialAssetIsReachableFrom: self
	] ifFalse: [
		parents do: [ :parent | (parent assertNoFinancialAssetIsSharedWith: aFinancialAsset) ]
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'exceptions' stamp: 'TT 5/23/2021 13:50:09'!
canNotAddSameFinancialAssetTwiceErrorDescription
	^'Account is already in portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TT 5/25/2021 13:27:52'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions - private' stamp: 'TT 5/23/2021 16:07:58'!
addAllTransactionsTo: aCollectionOfTransactions
	aCollectionOfTransactions addAll: self transactions.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TT 5/25/2021 13:32:18'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TT 5/20/2021 23:57:02'!
transactions

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TT 5/17/2021 21:56:09'!
balance

	^transactions inject: 0 into: [ :acumBalance :aTransaction | 
		aTransaction addTo: acumBalance 
	] ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'TT 5/25/2021 13:28:30'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !


!ReceptiveAccount methodsFor: 'actions - private' stamp: 'TT 5/23/2021 13:06:53'!
addAsPortfolioParent: aFinancialEntity 
	! !

!ReceptiveAccount methodsFor: 'actions - private' stamp: 'TT 5/22/2021 00:39:59'!
containsFinancialAsset: aFinancialAsset 
	^self = aFinancialAsset ! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'TT 5/23/2021 14:09:23'!
assertNoFinancialAssetIsReachableFrom: aFinancialAsset 
	(aFinancialAsset containsFinancialAsset: self) ifTrue: [^self error: Portfolio canNotAddSameFinancialAssetTwiceErrorDescription ]! !
