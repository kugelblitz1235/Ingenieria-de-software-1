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


!classDefinition: #ReportTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'pedroPortfolio rupertoPortfolio jimmyAccount carlosAccount summaryReportEmpty summaryReportWithDeposit summaryReportWithdraw summaryReportWithTransferOrigin summaryReportWithTransferDestination summaryReportWithMultipleTransactions summaryReportWithPortfolio netTransferReportEmpty netTransferReportWithTrasnferOrigin netTransferReportWithTrasnferDestination netTransferReportWithMultipleTransactions netTransferReportPortfolio ricardoAccount ramonPortfolio specialSummaryForOneDepthPortfolios specialSummaryForPortfolioWithAccounts specialSummaryForTwoDepthPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportTest methodsFor: 'auxiliar' stamp: 'BAG 6/1/2021 23:09:35'!
generateMultipleTransactions

	jimmyAccount register: (Deposit for: 100).
	jimmyAccount register: (Withdraw for: 40).
	Transfer value: 20 from: jimmyAccount to: carlosAccount.
	Transfer value: 30 from: carlosAccount to: jimmyAccount! !


!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:22:37'!
test01EmptyAccountReportsAccountSummaryCorrectly
	| report |
	
	report := ReportAccountSummary for: jimmyAccount.
	
	self assert:  summaryReportEmpty equals: report generateReport.! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:22:52'!
test02AccountWithDepositReportAccountSummaryCorrectly
	| report |
	
	jimmyAccount register: (Deposit for: 100).
	report := ReportAccountSummary for: jimmyAccount.
	
	self assert: summaryReportWithDeposit equals: report generateReport.! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:22:56'!
test03AccountWithdrawReportAccountSummaryCorrectly
	| report |
	
	jimmyAccount register: (Withdraw for: 40).
	report := ReportAccountSummary for: jimmyAccount .
	
	self assert: summaryReportWithdraw equals: report generateReport .! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:23:00'!
test04AccountWithTransferLegOriginReportAccountSummaryCorrectly
	| report |
	
	Transfer value: 20 from: jimmyAccount to: carlosAccount.
	report := ReportAccountSummary for: jimmyAccount.
	
	self assert: summaryReportWithTransferOrigin equals: report generateReport .! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:23:05'!
test05AccountWithTransferLegDestinationReportAccountSummaryCorrectly
	| report |
	
	Transfer value: 30 from: jimmyAccount to: carlosAccount.
	report := ReportAccountSummary for: carlosAccount.
	
	self assert: summaryReportWithTransferDestination equals: report generateReport .! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:23:10'!
test06AccountWithMultipleTransactionsReportAccountSummaryCorrectly
	| report |
	
	self generateMultipleTransactions.
	report := ReportAccountSummary for: jimmyAccount.
	
	self assert: summaryReportWithMultipleTransactions equals: report generateReport .! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:23:14'!
test13EmptyPortfolioReportsAccountSummaryCorrectly
	| report |
	
	report := ReportAccountSummary for: pedroPortfolio .
	
	self assert:  summaryReportEmpty equals: report generateReport .! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:23:19'!
test14PortfolioWithAccountsReportAccountSummaryCorrectly
	| report |
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	pedroPortfolio add: carlosAccount.
	
	report := ReportAccountSummary for: pedroPortfolio .
	
	self assert: summaryReportWithPortfolio equals: report generateReport.! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:41:20'!
test15OneDepthPortfolioWithMultipleTransactionReportAccountSummaryCorrectly
	| report |
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio.
	
	report := ReportAccountSummary for: pedroPortfolio .
	
	self assert: summaryReportWithPortfolio equals: report generateReport.! !

!ReportTest methodsFor: 'account summary' stamp: 'BAG 6/3/2021 00:43:19'!
test27TwoDepthPortfolioWithMultipleTransactionReportAccountSummaryCorrectly
	| report |
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio.
	rupertoPortfolio add: ramonPortfolio.
	ramonPortfolio add: ricardoAccount. 
	
	report := ReportAccountSummary for: pedroPortfolio .
	
	self assert: summaryReportWithPortfolio equals: report generateReport.! !


!ReportTest methodsFor: 'setUp' stamp: 'BAG 6/3/2021 00:56:50'!
setUp
	pedroPortfolio := Portfolio named: 'Portfolio de Pedro'.
	rupertoPortfolio := Portfolio named: 'Portfolio de Ruperto'.
	ramonPortfolio := Portfolio named: 'Portfolio de Ramon'.
	
	jimmyAccount := ReceptiveAccount named: 'Cuenta de Jimmy'.
	carlosAccount := ReceptiveAccount named: 'Cuenta de Carlos'.
	ricardoAccount := ReceptiveAccount named: 'Cuenta de Ricardo'.
	
	summaryReportEmpty := OrderedCollection with: 'Balance = 0'.
	summaryReportWithDeposit := OrderedCollection with: 'Depósito por 100'
											     with: 'Balance = 100'.
											
	summaryReportWithdraw := OrderedCollection with: 'Extracción por 40'
											 with: 'Balance = -40'.
	summaryReportWithTransferOrigin := OrderedCollection with: 'Salida por transferencia de 20'
												         with: 'Balance = -20'.
	summaryReportWithTransferDestination := OrderedCollection with: 'Entrada por transferencia de 30'
													          with: 'Balance = 30'.
													
	summaryReportWithMultipleTransactions := OrderedCollection with: 'Depósito por 100'
														    with: 'Extracción por 40'
														    with: 'Salida por transferencia de 20'
														    with: 'Entrada por transferencia de 30'
														    with: 'Balance = 70'.
	
	summaryReportWithPortfolio := OrderedCollection withAll: #('Depósito por 100'
												    'Extracción por 40'
												    'Salida por transferencia de 20'
												    'Entrada por transferencia de 30'
												    'Entrada por transferencia de 20'
												    'Salida por transferencia de 30'
												    'Balance = 60').
	netTransferReportEmpty := netTransferReportPortfolio := 0.
	netTransferReportWithTrasnferOrigin := -20.
	netTransferReportWithTrasnferDestination := 20.
	netTransferReportWithMultipleTransactions := 10.
	
	specialSummaryForOneDepthPortfolios := OrderedCollection withAll: #('Portfolio de Pedro'
									 ' Cuenta de Ricardo'
									 '  Depósito por 50'
									 '  Extracción por 10'
									 '  Balance = 40'
									 ' Portfolio de Ruperto'
									 '  Cuenta de Jimmy'
									 '   Depósito por 100'
									 '   Extracción por 40'
									 '   Balance = 60'
									 '  Cuenta de Carlos'
									 '   Salida por transferencia de 30'
									 '   Balance = -30'
									 ' Balance = 30'
									 'Balance = 70').
	specialSummaryForTwoDepthPortfolio := OrderedCollection withAll: #('Portfolio de Pedro'
									 ' Cuenta de Ricardo'
									 '  Depósito por 50'
									 '  Extracción por 10'
									 '  Balance = 40'
									 ' Portfolio de Ruperto'
									 '  Cuenta de Jimmy'
									 '   Depósito por 100'
									 '   Extracción por 40'
									 '   Balance = 60'
									 '  Portfolio de Ramon'
									 '   Cuenta de Carlos'
									 '    Salida por transferencia de 30'
									 '    Balance = -30'
									 '  Balance = -30'
									 ' Balance = 30'
									 'Balance = 70').
	specialSummaryForPortfolioWithAccounts := OrderedCollection withAll: #('Portfolio de Pedro'
									 ' Cuenta de Jimmy'
									 '  Depósito por 100'
									 '  Extracción por 40'
									 '  Balance = 60'
									 ' Cuenta de Carlos'
									 '  Balance = 0'
									 'Balance = 60').
	
	! !


!ReportTest methodsFor: 'special account summary' stamp: 'BAG 6/3/2021 00:24:54'!
test24EmptyPortfolioReportsSpecialAccountSummaryCorrectly
	| report structureReport |
	
	report := ReportSpecialAccountSummary for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro' with: 'Balance = 0'.
	
	self assert:  structureReport equals: report generateReport.! !

!ReportTest methodsFor: 'special account summary' stamp: 'BAG 6/3/2021 00:24:49'!
test25PortfolioWithAccountsReportsSpecialAccountSummaryCorrectly
	| report |
	
	pedroPortfolio add: jimmyAccount.
	jimmyAccount register: (Deposit for: 100).
	jimmyAccount register: (Withdraw for: 40).
	pedroPortfolio add: carlosAccount.
	report := ReportSpecialAccountSummary for: pedroPortfolio .
	
	self assert:  specialSummaryForPortfolioWithAccounts equals: report generateReport.! !

!ReportTest methodsFor: 'special account summary' stamp: 'BAG 6/3/2021 00:56:51'!
test26OneDepthPortfolioWithAccountsReportsSpecialAccountSummaryCorrectly
	| report |
	
	ricardoAccount register: (Deposit for: 50);
			        register: (Withdraw for: 10).
	
	pedroPortfolio add: ricardoAccount;
				add:rupertoPortfolio.
				
	rupertoPortfolio add: jimmyAccount; 
				 add: carlosAccount.
				
	jimmyAccount register: (Deposit for: 100);
				 register: (Withdraw for: 40).
				
	Transfer value: 30 from: carlosAccount to: (ReceptiveAccount new). 
	
	
	report := ReportSpecialAccountSummary for: pedroPortfolio .
	
	self assert:  specialSummaryForOneDepthPortfolios equals: report generateReport.! !

!ReportTest methodsFor: 'special account summary' stamp: 'BAG 6/3/2021 00:57:27'!
test29TwoDepthPortfolioWithAccountsReportsSpecialAccountSummaryCorrectly
	| report |
	
	ricardoAccount register: (Deposit for: 50);
			        register: (Withdraw for: 10).
	
	pedroPortfolio add: ricardoAccount;
				add:rupertoPortfolio.
				
	rupertoPortfolio add: jimmyAccount; 
				 add: ramonPortfolio.
	
	ramonPortfolio add: carlosAccount.
				
	jimmyAccount register: (Deposit for: 100);
				 register: (Withdraw for: 40).
				
	Transfer value: 30 from: carlosAccount to: (ReceptiveAccount new). 
	
	
	report := ReportSpecialAccountSummary for: pedroPortfolio .
	
	self assert:  specialSummaryForTwoDepthPortfolio equals: report generateReport.! !


!ReportTest methodsFor: 'portfolio structure' stamp: 'BAG 6/3/2021 00:24:34'!
test19EmptyPortfolioReportsPortfolioStructureCorrectly
	| report structureReport |
	
	report := ReportPortfolioStructure for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro'.
	
	self assert:  structureReport equals: report generateReport .! !

!ReportTest methodsFor: 'portfolio structure' stamp: 'BAG 6/3/2021 00:24:31'!
test20PortfolioWithAccountsReportsPortfolioStructureCorrectly
	| report structureReport |
	
	pedroPortfolio add: jimmyAccount.
	pedroPortfolio add: carlosAccount.
	report := ReportPortfolioStructure for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro'
									with: ' Cuenta de Jimmy'
									with: ' Cuenta de Carlos'.
	
	self assert:  structureReport equals: report generateReport .! !

!ReportTest methodsFor: 'portfolio structure' stamp: 'BAG 6/3/2021 00:49:09'!
test21OneDepthPortfolioWithAccountsReportsPortfolioStructureCorrectly
	| report structureReport |
	
	pedroPortfolio add: jimmyAccount.
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio .
	
	report := ReportPortfolioStructure for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro'
									with: ' Cuenta de Jimmy'
									with: ' Portfolio de Ruperto'
									with: '  Cuenta de Carlos'.
	
	self assert:  structureReport equals: report generateReport .! !

!ReportTest methodsFor: 'portfolio structure' stamp: 'BAG 6/3/2021 00:49:59'!
test22PortfoliosWithDifferentDepthsReportPortfolioStructureCorrectly
	| report structureReport |
	
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio .
	pedroPortfolio add: jimmyAccount.
	
	report := ReportPortfolioStructure for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro'
									with: ' Portfolio de Ruperto'
									with: '  Cuenta de Carlos'
									with: ' Cuenta de Jimmy'.
	
	self assert:  structureReport equals: report generateReport .! !

!ReportTest methodsFor: 'portfolio structure' stamp: 'BAG 6/3/2021 00:50:08'!
test23MultiplePortfoliosWithAccountsReportPortfolioStructureCorrectly
	| report structureReport |
	
	rupertoPortfolio add: carlosAccount.
	ramonPortfolio add: jimmyAccount.
	pedroPortfolio add: rupertoPortfolio .
	pedroPortfolio add: ramonPortfolio .
	
	
	report := ReportPortfolioStructure for: pedroPortfolio .
	structureReport := OrderedCollection with: 'Portfolio de Pedro'
									with: ' Portfolio de Ruperto'
									with: '  Cuenta de Carlos'
									with: ' Portfolio de Ramon'
									with: '  Cuenta de Jimmy'.
	
	self assert:  structureReport equals: report generateReport .! !


!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:35'!
test07EmptyAccountReportsTransferNetCorrectly
	| report |
	
	report := ReportTransferNet for: jimmyAccount.
	
	self assert:  netTransferReportEmpty equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:40'!
test08AccountWithDepositReportTransferNetCorrectly
	| report |
	
	jimmyAccount register: (Deposit for: 100).
	report := ReportTransferNet for: jimmyAccount.
	
	self assert: netTransferReportEmpty equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:45'!
test09AccountWithdrawReportTransferNetCorrectly
	| report |
	
	jimmyAccount register: (Withdraw for: 40).
	report := ReportTransferNet for: jimmyAccount .
	
	self assert: netTransferReportEmpty equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:50'!
test10AccountWithTransferLegOriginReportTransferNetCorrectly
	| report |
	
	Transfer value: 20 from: jimmyAccount to: carlosAccount.
	report := ReportTransferNet for: jimmyAccount.
	
	self assert: netTransferReportWithTrasnferOrigin equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:55'!
test11AccountWithTransferLegDestinationReportTransferNetCorrectly
	| report |
	
	Transfer value: 20 from: jimmyAccount to: carlosAccount.
	report := ReportTransferNet for: carlosAccount.
	
	self assert: netTransferReportWithTrasnferDestination equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:23:59'!
test12AccountWithMultipleTransactionsReportTransferNetCorrectly
	| report |
	
	self generateMultipleTransactions.
	report := ReportTransferNet for: jimmyAccount.
	
	self assert: netTransferReportWithMultipleTransactions equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:24:03'!
test16EmptyPortfolioReportsTransferNetCorrectly
	| report |
	
	report := ReportTransferNet for: pedroPortfolio .
	
	self assert:  netTransferReportEmpty equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:24:07'!
test17PortfolioWithAccountsReportTransferNetCorrectly
	| report |
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	pedroPortfolio add: carlosAccount.
	
	report := ReportTransferNet for: pedroPortfolio .
	
	self assert: netTransferReportPortfolio equals: report generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:45:22'!
test18OneDepthPortfolioWithMultipleTransactionReportTransferNetCorrectly
	| report1 report2|
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio.
	
	report1 := ReportTransferNet for: pedroPortfolio .
	report2 := ReportTransferNet for: rupertoPortfolio .
	
	self assert: netTransferReportPortfolio equals: report1 generateReport .
	self assert: (netTransferReportWithMultipleTransactions negated) equals: report2 generateReport .! !

!ReportTest methodsFor: 'net transfer' stamp: 'BAG 6/3/2021 00:46:03'!
test28TwoDepthPortfolioWithMultipleTransactionReportTransferNetCorrectly
	| report1 report2|
	
	self generateMultipleTransactions. 
	pedroPortfolio add: jimmyAccount.
	rupertoPortfolio add: carlosAccount.
	pedroPortfolio add: rupertoPortfolio.
	rupertoPortfolio add: ramonPortfolio.
	ramonPortfolio add: ricardoAccount. 
	
	report1 := ReportTransferNet for: pedroPortfolio .
	report2 := ReportTransferNet for: rupertoPortfolio .
	
	self assert: netTransferReportPortfolio equals: report1 generateReport .
	self assert: (netTransferReportWithMultipleTransactions negated) equals: report2 generateReport .! !


!classDefinition: #TransferTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTest methodsFor: 'apply transfer' stamp: 'BAG 5/28/2021 00:23:25'!
test01TransferOperationAppliesCorrectly
	| originAccount destinationAccount transfer |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	transfer := Transfer value: 100 from: originAccount to: destinationAccount.
	
	self assert: transfer value equals: 100.
	self assert: originAccount balance equals: -100.
	self assert: destinationAccount balance equals: 100.
	! !


!TransferTest methodsFor: 'same account' stamp: 'BAG 6/3/2021 01:05:03'!
test06CanNotTransferUsingTheSameAccount
	| account |
	
	account := ReceptiveAccount new.
	
	self should:  [Transfer value: 100 from: account to: account ] 
	raise: Error
	withMessageText: Transfer canNotTransferUsingTheSameAccount.
	
	
	! !


!TransferTest methodsFor: 'invalid value' stamp: 'BAG 6/3/2021 01:03:49'!
test07CanNotTransferAnInvalidValue
	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self should:  [Transfer value: -100 from: originAccount to: destinationAccount ] 
	raise: Error
	withMessageText: Transfer canNotTransferAValueEqualOrLowerThanZero .
	
	
	! !


!TransferTest methodsFor: 'navigation' stamp: 'BAG 5/28/2021 00:24:25'!
test02TransferOriginHasCorrectValue
	| originAccount destinationAccount transfer transferOrigin |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer value: 100 from: originAccount to: destinationAccount.
	transferOrigin := transfer origin.
	
	self assert: transferOrigin value equals: 100. 
	
	! !

!TransferTest methodsFor: 'navigation' stamp: 'BAG 5/28/2021 00:24:45'!
test03TransferDestinationHasCorrectValue
	| originAccount destinationAccount transfer transferDestination |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer value: 100 from: originAccount to: destinationAccount.
	transferDestination := transfer origin.
	
	self assert: transferDestination value equals: 100. 
	
	! !

!TransferTest methodsFor: 'navigation' stamp: 'BAG 5/28/2021 00:45:06'!
test04TransferCanGoBackAndForthOrigin
	| originAccount destinationAccount transfer transferOrigin |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer value: 100 from: originAccount to: destinationAccount.
	transferOrigin := transfer origin.
	
	self assert: transferOrigin transfer equals: transfer. 
	
	! !

!TransferTest methodsFor: 'navigation' stamp: 'BAG 5/28/2021 00:45:15'!
test05TransferCanGoBackAndForthDestination
	| originAccount destinationAccount transfer transferDestination |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	transfer := Transfer value: 100 from: originAccount to: destinationAccount.
	transferDestination := transfer destination.
	
	self assert: transferDestination transfer equals: transfer. 
	
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


!AccountTransaction methodsFor: 'reports' stamp: 'BAG 6/1/2021 22:07:03'!
generateReport: aReport
	self subclassResponsibility ! !

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


!Deposit methodsFor: 'reports' stamp: 'BAG 6/1/2021 22:06:30'!
generateReport: aReport
	aReport operationForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegDestination category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferLegDestination
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferLegDestination methodsFor: 'transfer' stamp: 'BAG 5/28/2021 00:35:19'!
transfer
	^transfer! !


!TransferLegDestination methodsFor: 'initialization' stamp: 'BAG 5/28/2021 00:38:44'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferLegDestination methodsFor: 'value' stamp: 'BAG 5/28/2021 01:36:04'!
addTo: aBalance

	^aBalance + (self value)! !

!TransferLegDestination methodsFor: 'value' stamp: 'BAG 5/28/2021 00:37:20'!
value
	^transfer value.! !


!TransferLegDestination methodsFor: 'reports' stamp: 'BAG 6/3/2021 00:18:38'!
generateReport: aReport
	aReport operationForTransferLegDestination: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegDestination class' category: 'Portfolio-Ejercicio'!
TransferLegDestination class
	instanceVariableNames: ''!

!TransferLegDestination class methodsFor: 'instance creation' stamp: 'BAG 5/28/2021 00:37:58'!
for: aTransfer 
	^self new initializeFor: aTransfer ! !


!classDefinition: #TransferLegOrigin category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferLegOrigin
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferLegOrigin methodsFor: 'transfer' stamp: 'BAG 5/28/2021 00:27:55'!
transfer
	^transfer! !


!TransferLegOrigin methodsFor: 'initialization' stamp: 'BAG 5/28/2021 00:31:52'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferLegOrigin methodsFor: 'value' stamp: 'BAG 5/28/2021 01:35:27'!
addTo: aBalance

	^aBalance - (self value)! !

!TransferLegOrigin methodsFor: 'value' stamp: 'BAG 5/28/2021 00:33:21'!
value
	^transfer value.! !


!TransferLegOrigin methodsFor: 'reports' stamp: 'BAG 6/3/2021 00:15:01'!
generateReport: aReport
	aReport operationForTransferLegOrigin: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegOrigin class' category: 'Portfolio-Ejercicio'!
TransferLegOrigin class
	instanceVariableNames: ''!

!TransferLegOrigin class methodsFor: 'instance creation' stamp: 'BAG 5/28/2021 00:30:30'!
for: aTransfer 
	^self new initializeFor: aTransfer. ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'TT 5/17/2021 21:54:22'!
addTo: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'BAG 6/1/2021 22:07:41'!
generateReport: aReport
	aReport operationForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: 'name'
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


!FinancialAsset methodsFor: 'initialization' stamp: 'BAG 6/1/2021 23:07:20'!
initializeWithName: aName
	name := aName .
	self initialize.! !


!FinancialAsset methodsFor: 'actions' stamp: 'BAG 6/1/2021 23:08:51'!
name
	^name copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialAsset class' category: 'Portfolio-Ejercicio'!
FinancialAsset class
	instanceVariableNames: ''!

!FinancialAsset class methodsFor: 'as yet unclassified' stamp: 'BAG 6/1/2021 23:07:52'!
named: aName
	^self new initializeWithName: aName.! !


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


!Portfolio methodsFor: 'reports' stamp: 'BAG 6/2/2021 00:59:07'!
generateReport: aReport
	aReport operationForPortfolioOnEntering: self.
	
	financialAssets do: [:financialAsset | financialAsset generateReport: aReport].
	
	aReport operationForPortfolioOnLeaving: self.! !


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


!ReceptiveAccount methodsFor: 'reports' stamp: 'BAG 6/2/2021 00:59:24'!
generateReport: aReport
	aReport operationForAccountOnEntering: self.
	transactions do: [:transaction | transaction generateReport: aReport].
	aReport operationForAccountOnLeaving: self.! !


!classDefinition: #Report category: 'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'financialAsset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Report methodsFor: 'initialization' stamp: 'BAG 6/1/2021 21:34:30'!
initializeFor: aFinancialAsset
	financialAsset := aFinancialAsset.! !


!Report methodsFor: 'generator' stamp: 'BAG 6/3/2021 00:20:54'!
generateReport
	^self subclassResponsibility ! !


!Report methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:36'!
operationForAccountOnEntering: anAccount
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:16'!
operationForAccountOnLeaving: anAccount
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/3/2021 11:59:32'!
operationForDeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:51:01'!
operationForPortfolioOnEntering: aPortfolio
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:47'!
operationForPortfolioOnLeaving: aPortfolio
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/3/2021 11:59:44'!
operationForTransferLegDestination: aTransferLegDestination
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/3/2021 11:59:55'!
operationForTransferLegOrigin: aTransferLegOrigin
	self subclassResponsibility ! !

!Report methodsFor: 'operations' stamp: 'BAG 6/3/2021 12:00:01'!
operationForWithdraw: aWithdraw
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'BAG 6/1/2021 21:34:03'!
for: aFinancialAsset
	^self new initializeFor: aFinancialAsset. ! !


!classDefinition: #ReportAccountSummary category: 'Portfolio-Ejercicio'!
Report subclass: #ReportAccountSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportAccountSummary methodsFor: 'generator' stamp: 'BAG 6/3/2021 00:21:17'!
generateReport
	summary := OrderedCollection new.
	
	financialAsset generateReport: self.
	summary add: ('Balance = ', financialAsset balance asString).
	
	^summary copy.
	
	! !


!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:35'!
operationForAccountOnEntering: anAccount
	! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:16'!
operationForAccountOnLeaving: anAccount
	! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:29:02'!
operationForDeposit: aDeposit
	summary add: ('Depósito por ', aDeposit value asString).! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:51:01'!
operationForPortfolioOnEntering: aPortfolio
	
	! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:47'!
operationForPortfolioOnLeaving: aPortfolio
	
	! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:29:52'!
operationForTransferLegDestination: aTransferLegDestination
	summary add: ('Entrada por transferencia de ', aTransferLegDestination value asString).! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:04'!
operationForTransferLegOrigin: aTransferLegOrigin
	summary add: ('Salida por transferencia de ', aTransferLegOrigin value asString).! !

!ReportAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:17'!
operationForWithdraw: aWithdraw
	summary add: ('Extracción por ', aWithdraw value asString).! !


!classDefinition: #ReportPortfolioStructure category: 'Portfolio-Ejercicio'!
Report subclass: #ReportPortfolioStructure
	instanceVariableNames: 'structure depthBlanks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportPortfolioStructure methodsFor: 'generator' stamp: 'BAG 6/3/2021 00:21:32'!
generateReport
	structure := OrderedCollection new.
	depthBlanks := ''.
	
	financialAsset generateReport: self.
	
	^structure copy.
	
	! !


!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:35'!
operationForAccountOnEntering: anAccount
	structure add: (depthBlanks , anAccount name).
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:16'!
operationForAccountOnLeaving: anAccount
	
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:55'!
operationForDeposit: aDeposit
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:51:01'!
operationForPortfolioOnEntering: aPortfolio
	structure add: (depthBlanks , aPortfolio name).
	depthBlanks := (depthBlanks,' ').	
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:47'!
operationForPortfolioOnLeaving: aPortfolio
	depthBlanks := depthBlanks allButLast.
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:46'!
operationForTransferLegDestination: aTransferLegDestination
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:34'!
operationForTransferLegOrigin: aTransferLegOrigin
	! !

!ReportPortfolioStructure methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:30:25'!
operationForWithdraw: aWithdraw
	! !


!classDefinition: #ReportSpecialAccountSummary category: 'Portfolio-Ejercicio'!
Report subclass: #ReportSpecialAccountSummary
	instanceVariableNames: 'summary depthBlanks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportSpecialAccountSummary methodsFor: 'generator' stamp: 'BAG 6/3/2021 00:21:47'!
generateReport
	summary := OrderedCollection new.
	depthBlanks := ''.
	
	financialAsset generateReport: self.
	
	^summary copy.! !


!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:36'!
operationForAccountOnEntering: anAccount
	summary add: (depthBlanks , anAccount name).
	depthBlanks := depthBlanks,' '.
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:16'!
operationForAccountOnLeaving: anAccount
	summary add: (depthBlanks,'Balance = ', anAccount balance asString).
	depthBlanks := depthBlanks allButLast .
	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:32:11'!
operationForDeposit: aDeposit
	summary add: (depthBlanks, 'Depósito por ', aDeposit value asString).
	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:51:01'!
operationForPortfolioOnEntering: aPortfolio
	summary add: (depthBlanks , aPortfolio name).
	depthBlanks := (depthBlanks,' ').	
	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:47'!
operationForPortfolioOnLeaving: aPortfolio
	depthBlanks := depthBlanks allButLast. 
	summary add: (depthBlanks,'Balance = ', aPortfolio balance asString).

	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:31:53'!
operationForTransferLegDestination: aTransferLegDestination
	summary add: (depthBlanks, 'Entrada por transferencia de ', aTransferLegDestination value asString).
	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:31:36'!
operationForTransferLegOrigin: aTransferLegOrigin
	summary add: (depthBlanks, 'Salida por transferencia de ', aTransferLegOrigin value asString).
	
	! !

!ReportSpecialAccountSummary methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:31:21'!
operationForWithdraw: aWithdraw
	summary add: (depthBlanks, 'Extracción por ', aWithdraw value asString).
	
	! !


!classDefinition: #ReportTransferNet category: 'Portfolio-Ejercicio'!
Report subclass: #ReportTransferNet
	instanceVariableNames: 'netTransferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:36'!
operationForAccountOnEntering: anAccount! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:16'!
operationForAccountOnLeaving: anAccount! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:33:07'!
operationForDeposit: aDeposit
	! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:51:01'!
operationForPortfolioOnEntering: aPortfolio! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/2/2021 00:50:47'!
operationForPortfolioOnLeaving: aPortfolio! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:32:53'!
operationForTransferLegDestination: aTransferLegDestination
	netTransferValue := netTransferValue + (aTransferLegDestination value).! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:32:35'!
operationForTransferLegOrigin: aTransferLegOrigin
	netTransferValue := netTransferValue - (aTransferLegOrigin value).! !

!ReportTransferNet methodsFor: 'operations' stamp: 'BAG 6/3/2021 00:32:24'!
operationForWithdraw: aWithdraw
	! !


!ReportTransferNet methodsFor: 'generator' stamp: 'BAG 6/3/2021 00:22:00'!
generateReport
	netTransferValue := 0.
	
	financialAsset generateReport: self.
	
	^netTransferValue.! !


!classDefinition: #Transfer category: 'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'origin destination value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'BAG 6/3/2021 00:07:22'!
initializeWith: aValue from: anOriginAccount to: aDestinationAccount 
	
	value := aValue.
	origin := TransferLegOrigin for: self.
	destination := TransferLegDestination for: self.
	
	anOriginAccount register: origin.
	aDestinationAccount register: destination.
	! !


!Transfer methodsFor: 'transaction' stamp: 'BAG 5/28/2021 00:17:25'!
origin
	^origin! !


!Transfer methodsFor: 'accessing' stamp: 'BAG 5/28/2021 00:34:40'!
destination
	^destination! !

!Transfer methodsFor: 'accessing' stamp: 'BAG 5/27/2021 23:46:31'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'BAG 6/3/2021 01:01:48'!
value: aValue from: anOriginAccount to: aDestinationAccount 
	self assertTheValueIsHigherThanZero: aValue.
	self assertCanBeTransferBetween: anOriginAccount and: aDestinationAccount		.
	
	^self new initializeWith: aValue from: anOriginAccount to: aDestinationAccount ! !


!Transfer class methodsFor: 'error description' stamp: 'BAG 6/3/2021 00:05:36'!
canNotTransferAValueEqualOrLowerThanZero
	^'No se puede transferir un monto menor o igual a cero'! !

!Transfer class methodsFor: 'error description' stamp: 'BAG 6/3/2021 01:04:35'!
canNotTransferUsingTheSameAccount
	^'No se puede transferir usando la misma cuenta como origen y destino'! !


!Transfer class methodsFor: 'asserts' stamp: 'BAG 6/3/2021 01:04:35'!
assertCanBeTransferBetween: anOriginAccount and: aDestinationAccount		.
	(anOriginAccount = aDestinationAccount) ifTrue:[ self error: self canNotTransferUsingTheSameAccount]	! !

!Transfer class methodsFor: 'asserts' stamp: 'BAG 6/3/2021 01:01:48'!
assertTheValueIsHigherThanZero: aValue.
	aValue < 0 ifTrue:[ self error: self canNotTransferAValueEqualOrLowerThanZero ]	! !
