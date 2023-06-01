!classDefinition: #PortfolioTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'accountA accountB accountC accountD externalAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReportTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 00:48:15'!
assertAccountSummaryFor: anAccount equals: anAccountSummary

	self assertArray: anAccountSummary
	 	 equalsCollection: (AccountSummary for: anAccount) generate! !

!ReportTest methodsFor: 'assertions' stamp: 'JT 5/31/2023 11:26:48'!
assertArray: anArray equalsCollection: aCollection

	self assert: anArray size equals: aCollection size.
	
	anArray with: aCollection do: [:arrayElement :collectionElement |
		self assert: arrayElement equals: collectionElement
	].! !

!ReportTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 00:51:49'!
assertPortfolioHierarchyFor: aPortfolio equals: aPortfolioHierarchy

	self assertArray: aPortfolioHierarchy 
	 	 equalsCollection: (PortfolioHierarchy for: aPortfolio) generate! !

!ReportTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 00:49:56'!
assertTransferNetFor: anAccount equals: anAmount

	self assert: anAmount
	 	 equals: (TransferNet for: anAccount) generate! !


!ReportTest methodsFor: 'setup' stamp: 'JT 6/1/2023 00:57:11'!
setUp

	accountA := ReceptiveAccount named: 'Account A'.
	accountB := ReceptiveAccount named: 'Account B'.
	accountC := ReceptiveAccount named: 'Account C'.
	accountD := ReceptiveAccount named: 'Account D'.
	externalAccount := ReceptiveAccount new.! !


!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:48:06'!
test01SummaryForEmptyAccountShowsBalanceEqualsZero

	| account |
	account := ReceptiveAccount new.
	
	 self assertAccountSummaryFor: account equals: { 'Balance = 0' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test02SummaryForAccountWithTransactionHasTransaction

	accountA register: (Deposit for: 100).
	accountB register: (Withdraw for: 200).
	Transfer from: accountC to: accountD of: 50.
	
	 self assertAccountSummaryFor: accountA equals: { 'Deposito por 100'. 'Balance = 100' }.
		
	 self assertAccountSummaryFor: accountB equals: { 'Extraccion por 200'. 'Balance = -200' }.
		
	 self assertAccountSummaryFor: accountC equals: { 'Salida por transferencia de 50'. 'Balance = -50' }.

	 self assertAccountSummaryFor: accountD equals: { 'Entrada por transferencia de 50'. 'Balance = 50' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test03SummaryForAccountWithMultipleTransactionsHasAllTransactions

	accountA register: (Deposit for: 100);
			 register: (Withdraw for: 50).
	accountB register: (Withdraw for: 200);
			 register: (Deposit for: 300).
	
	Transfer from: accountA to: accountB of: 50.
	
	 self assertAccountSummaryFor: accountA equals: {
			'Deposito por 100'.
			'Extraccion por 50'.
			'Salida por transferencia de 50'.
			'Balance = 0' }.
		
	 self assertAccountSummaryFor: accountB equals: {
			'Extraccion por 200'.
			'Deposito por 300'.
			'Entrada por transferencia de 50'.
			'Balance = 150' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:48:45'!
test04SummaryForEmptyPortfolioIsEmpty

	self assertAccountSummaryFor: Portfolio new equals: { 'Balance = 0' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test05SummaryForPortfolioWithAccountsHasAllAccountsTransactions

	| portfolio |
	portfolio := Portfolio with: accountA with: accountB.

	accountA register: (Deposit for: 10);
			 register: (Withdraw for: 5).
			
	accountB register: (Withdraw for: 10).
	
	Transfer from: accountA to: accountB of: 10.
	
	 self assertAccountSummaryFor: portfolio equals: {
		 'Deposito por 10'.
		 'Extraccion por 5'.
		 'Salida por transferencia de 10'.
		 'Extraccion por 10'.
		 'Entrada por transferencia de 10'.
		 'Balance = -5' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test06SummaryForPortfolioWithPortfoliosHasAllPortfoliosTransactions

	| portfolio portfolioFamiliar portfolioTrabajo |
	portfolioFamiliar := Portfolio with: accountA with: accountB.
	portfolioTrabajo := Portfolio with: accountC with: accountD.
	portfolio := Portfolio with: portfolioFamiliar with: portfolioTrabajo.

	accountA register: (Deposit for: 10);
			 register: (Withdraw for: 5).
			
	accountB register: (Withdraw for: 10).
	
	accountC register: (Deposit for: 10).
	
	accountD register: (Deposit for: 20).
	
	Transfer from: accountC to: accountD of: 10.
	
	 self assertAccountSummaryFor: portfolio equals: {
		 'Deposito por 10'.
		 'Extraccion por 5'.
		 'Extraccion por 10'.
		 'Deposito por 10'.
		 'Salida por transferencia de 10'.
		 'Deposito por 20'.
		 'Entrada por transferencia de 10'.
		 'Balance = 25' }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test07TransferNetForEmptyAccountReturnsZero

	self assertTransferNetFor: accountA equals: 0! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test08TransferNetForAccountWithTransfersReturnsNetOfTransferValues

	accountA register: (Deposit for: 10).
	accountB register: (Deposit for: 20).
	Transfer from: accountA to: accountB of: 100.
	Transfer from: accountB to: accountA of: 50.
	
	self assertTransferNetFor: accountA equals: -50.
	self assertTransferNetFor: accountB equals: 50.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:50:10'!
test09TransferNetForEmptyPortfolioReturnsZero

	self assertTransferNetFor: Portfolio new equals: 0.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:57:11'!
test10TransferNetForPortfolioWithAccountsReturnsSumOfTransferNetsOfItsAccounts

	| portfolio |
	portfolio := Portfolio with: accountA with: accountB.

	accountA register: (Deposit for: 10).
	accountB register: (Withdraw for: 20).	
	Transfer from: accountA to: externalAccount of: 100.
	Transfer from: externalAccount to: accountB of: 200.

	self assertTransferNetFor: portfolio equals: 100! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:57:11'!
test11TransferNetForPortfolioWithPortfoliosReturnsSumOfTransferNetsOfItsPortfolios

	| portfolio portfolioFamiliar portfolioTrabajo |
	portfolioFamiliar := Portfolio with: accountA with: accountB.
	portfolioTrabajo := Portfolio with: accountC with: accountD.
	portfolio := Portfolio with: portfolioFamiliar with: portfolioTrabajo.

	accountA register: (Withdraw for: 5).		
	accountB register: (Withdraw for: 10).
	accountC register: (Deposit for: 10).
	accountD register: (Deposit for: 20).
	
	Transfer from: accountA to: externalAccount of: 100.
	Transfer from: accountC to: externalAccount of: 200.
	Transfer from: externalAccount to: accountD of: 50.
	Transfer from: accountB to: accountD of: 100.
	Transfer from: externalAccount to: accountB of: 150.
	
	self assertTransferNetFor: portfolio equals: -100.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:52:26'!
test12HierarchyForEmptyPortfolioShowsItsName

	| name |
	name := 'Vacio'.
	
	self assertPortfolioHierarchyFor: (Portfolio named: name)
		 equals: { name }.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test13HierarchyForPortfolioWithPortfoliosShowsTheirNamesIndented

	|workPortfolio homePortfolio rootPortfolio |
	workPortfolio := Portfolio named: 'Work Portfolio' with: accountB with: accountC.
	homePortfolio := Portfolio named: 'Home Portfolio' with: accountD.
	rootPortfolio := Portfolio named: 'Root' with: accountA with: workPortfolio with: homePortfolio.
	
	self assertPortfolioHierarchyFor: rootPortfolio 
		 equals: {
			'Root'.
			'   Account A'.
			'   Work Portfolio'.
			'      Account B'.
			'      Account C'.
			'   Home Portfolio'.
			'      Account D'
		}.! !

!ReportTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:55:01'!
test14HierarchySummaryForPortfolioWithPortfoliosShowsHierarchyForItsPortfoliosAndSummaryForItsAccounts

	|workPortfolio homePortfolio rootPortfolio |
	workPortfolio := Portfolio named: 'Work Portfolio' with: accountB with: accountC.
	homePortfolio := Portfolio named: 'Home Portfolio' with: accountD.
	rootPortfolio := Portfolio named: 'Root' with: accountA with: workPortfolio with: homePortfolio.
	
	accountA register: (Deposit for: 100);
			 register: (Withdraw for: 50).
			
	Transfer from: accountA to: accountC of: 20.

	accountB register: (Deposit for: 120);
			 register: (Withdraw for: 10).
			
	accountC register: (Deposit for: 100).
	
	accountD register: (Withdraw for: 10).
	
	Transfer from: accountB to: accountD of: 110.
	
	self assertArray: {
		'Root'.
		'   Account A'.
		'      Deposito por 100'.
		'      Extraccion por 50'.
		'      Salida por transferencia de 20'.
		'      Balance = 30'.
		'   Work Portfolio'.
		'      Account B'.
		'         Deposito por 120'.
		'         Extraccion por 10'.
		'         Salida por transferencia de 110'.
		'         Balance = 0'.
		'      Account C'.
		'         Entrada por transferencia de 20'.
		'         Deposito por 100'.
		'         Balance = 120'.
		'      Balance = 120'.
		'   Home Portfolio'.
		'      Account D'.
		'         Extraccion por 10'.
		'         Entrada por transferencia de 110'.
		'         Balance = 100'.
		'      Balance = 100'.
		'   Balance = 250' }
		 equalsCollection: (PortfolioHierarchySummary for: rootPortfolio) generate! !


!classDefinition: #TransferTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountA accountB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 00:29:28'!
assertCannotTransfer: aNonPositiveAmount

	self should: [ Transfer from: accountA to: accountB of: aNonPositiveAmount ]
		 raiseErrorWith: Transfer cannotTransferNonPositiveAmountErrorDescription! !

!TransferTest methodsFor: 'assertions' stamp: 'JT 6/1/2023 00:29:28'!
should: aBlockDoingATransfer raiseErrorWith: anErrorDescription

	self should: aBlockDoingATransfer 
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError |
			self assert: anErrorDescription
				 equals: anError messageText ]! !


!TransferTest methodsFor: 'setup' stamp: 'JT 6/1/2023 00:20:00'!
setUp

	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.! !


!TransferTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:20:00'!
test01TransferFromAToBAffectsBothBalancesAccordignly

	accountA register: (Deposit for: 100).
	accountB register: (Deposit for: 200).
	
	Transfer from: accountA to: accountB of: 50.
	
	self assert: 50  equals: (accountA balance).
	self assert: 250 equals: (accountB balance).! !

!TransferTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:20:00'!
test02WithdrawLegCanReachDepositLegThroughTransfer

	| depositLeg transfer withdrawLeg |
	transfer := Transfer from: accountA to: accountB of: 50.
	depositLeg := transfer depositLeg.
	withdrawLeg := transfer withdrawLeg.
	
	self assert: transfer equals: depositLeg transfer.
	self assert: transfer equals: withdrawLeg transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:29:28'!
test03CannotTransferToSameAccount
	
	self should: [ Transfer from: accountA to: accountA of: 10 ]
		 raiseErrorWith: Transfer cannotTransferToSameAccountErrorDescription! !

!TransferTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:26:48'!
test04CannotTransferAnAmountOfZero

	self assertCannotTransfer: 0.! !

!TransferTest methodsFor: 'tests' stamp: 'JT 6/1/2023 00:26:48'!
test05CannotTransferNegativeAmount

	self assertCannotTransfer: -10.! !


!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'JT 5/31/2023 13:22:56'!
generateReportFor: aReport

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'JT 5/31/2023 15:06:44'!
itemFor: aReport

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'JT 5/31/2023 15:32:31'!
initializeNamed: aName

	name := aName.! !


!Account methodsFor: 'accessing' stamp: 'JT 5/31/2023 15:40:45'!
name

	^ name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio2-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 15:33:45'!
named: aName

	^self new initializeNamed: aName ! !


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Portfolio methodsFor: 'printing' stamp: 'JT 5/31/2023 16:07:52'!
printOn: aStream

	^ aStream nextPutAll: 'a Portfolio "';
			  nextPutAll: name;
			  nextPut: $"! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'JT 6/1/2023 00:09:07'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := ''.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'reports' stamp: 'JT 5/31/2023 15:06:23'!
generateReportFor: aReport
	|items|

	items := accounts collect: [:account | account itemFor: aReport].
	
	^ aReport joinItemsForPortfolio: items.! !

!Portfolio methodsFor: 'reports' stamp: 'JT 5/31/2023 15:06:59'!
itemFor: aReport

	^ aReport itemForPortfolio: self! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 15:35:54'!
named: aName with: anAccount

	^ (self named: aName)		add: anAccount; yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 15:35:39'!
named: aName with: anAccount with: anotherAccount

	^ (self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 15:48:52'!
named: aName with: firstAccount with: secondAccount with: thirdAccount 

	^(self named: aName)
		add: firstAccount;
		add: secondAccount;
		add: thirdAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JT 6/1/2023 00:09:02'!
initialize

	transactions := OrderedCollection new.
	name := ''.! !


!ReceptiveAccount methodsFor: 'printing' stamp: 'JT 5/31/2023 16:08:20'!
printOn: aStream

	^ aStream nextPutAll: 'a ReceptiveAccount "';
			  nextPutAll: name;
			  nextPut: $"! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'JT 5/31/2023 13:37:24'!
generateReportFor: aReport

	|items|
	items := transactions collect: [:transaction | transaction itemFor: aReport].
	
	^ aReport joinItemsForReceptiveAccount: items.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'JT 5/31/2023 15:07:17'!
itemFor: aReport

	^ aReport itemForReceptiveAccount: self! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:02'!
itemFor: aReport

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:16'!
itemFor: aReport

	^ aReport itemForDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferLeg methodsFor: 'accessing' stamp: 'JT 5/31/2023 11:21:44'!
transfer

	^ transfer! !

!TransferLeg methodsFor: 'accessing' stamp: 'JT 5/31/2023 11:22:40'!
value

	^ transfer amount! !


!TransferLeg methodsFor: 'initialization' stamp: 'JT 5/31/2023 11:21:06'!
initializeOf: aTransfer
	transfer := aTransfer.! !


!TransferLeg methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:02'!
itemFor: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'Portfolio2-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 11:20:16'!
of: aTransfer 

	^self new initializeOf: aTransfer! !


!classDefinition: #DepositLeg category: 'Portfolio2-Ejercicio'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!DepositLeg methodsFor: 'balance' stamp: 'JT 5/31/2023 11:23:29'!
affectBalance: aBalance

	^ aBalance + self value! !


!DepositLeg methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:31'!
itemFor: aReport

	^ aReport itemForDepositLeg: self! !


!classDefinition: #WithdrawLeg category: 'Portfolio2-Ejercicio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!WithdrawLeg methodsFor: 'balance' stamp: 'JT 5/31/2023 11:23:24'!
affectBalance: aBalance

	^ aBalance - self value! !


!WithdrawLeg methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:42'!
itemFor: aReport

	^ aReport itemForWithdrawLeg: self! !


!classDefinition: #Withdraw category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'JT 5/31/2023 13:18:51'!
itemFor: aReport

	^ aReport itemForWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Report methodsFor: 'joining items' stamp: 'JT 5/31/2023 13:38:53'!
joinItemsForPortfolio: aCollectionOfItems

	self subclassResponsibility ! !

!Report methodsFor: 'joining items' stamp: 'JT 5/31/2023 13:41:30'!
joinItemsForReceptiveAccount: aCollectionOfItems

	self subclassResponsibility ! !


!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:16'!
itemForDeposit: aDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:31'!
itemForDepositLeg: aDepositLeg

	self subclassResponsibility ! !

!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 15:21:38'!
itemForPortfolio: aPortfolio

	self subclassResponsibility ! !

!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 15:21:44'!
itemForReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !

!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:51'!
itemForWithdraw: aWithdraw

	self subclassResponsibility ! !

!Report methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:42'!
itemForWithdrawLeg: aWithdrawLeg

	self subclassResponsibility ! !


!Report methodsFor: 'generate' stamp: 'JT 5/31/2023 13:00:11'!
generate

	^ account generateReportFor: self. ! !


!Report methodsFor: 'initialization' stamp: 'JT 5/31/2023 13:44:15'!
initializeFor: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio2-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'JT 5/31/2023 15:37:18'!
for: anAccount

	^self new initializeFor: anAccount ! !


!classDefinition: #AccountSummary category: 'Portfolio2-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummary methodsFor: 'item description' stamp: 'JT 6/1/2023 01:02:30'!
itemForAccount: anAccount

	| report |
	"Lo correcto seria usar un nuevo reporte: `report := (self class for: anAccount) generate`
	 para que genere correctamente el balance de `anAccount`, pero como al final lo descartamos
	 (en `report removeLast`) optamos por esta version que reutiliza la misma instancia de reporte	"
	report := anAccount generateReportFor: self.
	report removeLast.
	
	^ report! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:16'!
itemForDeposit: aDeposit

	^ 'Deposito por ' , aDeposit value asString! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:31'!
itemForDepositLeg: aDepositLeg

	^ 'Entrada por transferencia de ' , aDepositLeg value asString! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 15:20:41'!
itemForPortfolio: aPortfolio

	^ self itemForAccount: aPortfolio! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 15:20:33'!
itemForReceptiveAccount: aReceptiveAccount

	^ self itemForAccount: aReceptiveAccount ! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:51'!
itemForWithdraw: aWithdraw

	^ 'Extraccion por ' , aWithdraw value asString! !

!AccountSummary methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:42'!
itemForWithdrawLeg: aWithdrawLeg

	^ 'Salida por transferencia de ' , aWithdrawLeg value asString! !


!AccountSummary methodsFor: 'joining items' stamp: 'JT 5/31/2023 13:49:48'!
joinItemsForPortfolio: aCollectionOfItems

	| flattenItems |
	flattenItems := aCollectionOfItems
		inject: OrderedCollection new 
		into: [:allItems :accountItems | allItems addAll: accountItems; yourself].

	flattenItems add: 'Balance = ' , account balance asString.
	
	^ flattenItems! !

!AccountSummary methodsFor: 'joining items' stamp: 'JT 5/31/2023 13:37:41'!
joinItemsForReceptiveAccount: aCollectionOfItems

	aCollectionOfItems add: 'Balance = ' , account balance asString.
	
	^ aCollectionOfItems! !


!classDefinition: #PortfolioHierarchy category: 'Portfolio2-Ejercicio'!
Report subclass: #PortfolioHierarchy
	instanceVariableNames: 'indentPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioHierarchy methodsFor: 'initialization' stamp: 'JT 6/1/2023 01:09:01'!
initializeFor: aPortfolio 

	account := aPortfolio.
	indentPrefix := '   '.! !


!PortfolioHierarchy methodsFor: 'item description' stamp: 'JT 5/31/2023 16:39:30'!
itemForPortfolio: aPortfolio

	^ (self class for: aPortfolio) generate! !

!PortfolioHierarchy methodsFor: 'item description' stamp: 'JT 5/31/2023 16:39:48'!
itemForReceptiveAccount: aReceptiveAccount

	^ { aReceptiveAccount name }.! !


!PortfolioHierarchy methodsFor: 'joining items' stamp: 'JT 5/31/2023 16:27:12'!
joinItemsForPortfolio: aCollectionOfItems

	^ aCollectionOfItems
		inject: (OrderedCollection with: account name)
		into: [:allLines :items | allLines addAll: (self indent: items); yourself].! !


!PortfolioHierarchy methodsFor: 'private - indentation' stamp: 'JT 5/31/2023 15:36:47'!
indent: anItem

	(anItem isKindOf: CharacterSequence) ifTrue: [ ^ indentPrefix , anItem ].
	
	^ anItem collect: [:item | self indent: item].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioHierarchy class' category: 'Portfolio2-Ejercicio'!
PortfolioHierarchy class
	instanceVariableNames: ''!

!PortfolioHierarchy class methodsFor: 'error description' stamp: 'JT 6/1/2023 01:11:01'!
notAPortfolioErrorDescription

	^ 'Not a portfolio'! !


!PortfolioHierarchy class methodsFor: 'preconditions' stamp: 'JT 6/1/2023 01:10:37'!
verifyItsAPortfolio: aPossiblePortfolio

	(aPossiblePortfolio isKindOf: Portfolio) ifFalse: [ self error: self notAPortfolioErrorDescription ].! !


!PortfolioHierarchy class methodsFor: 'instance creation' stamp: 'JT 6/1/2023 01:11:27'!
for: aPortfolio

	self verifyItsAPortfolio: aPortfolio.

	^ self new initializeFor: aPortfolio.! !


!classDefinition: #PortfolioHierarchySummary category: 'Portfolio2-Ejercicio'!
PortfolioHierarchy subclass: #PortfolioHierarchySummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioHierarchySummary methodsFor: 'joining items' stamp: 'JT 5/31/2023 17:00:32'!
joinItemsForPortfolio: aCollectionOfItems

	aCollectionOfItems add: { 'Balance = ' , account balance asString }.
	
	^ aCollectionOfItems
		inject: (OrderedCollection with: account name)
		into: [:allLines :items | allLines addAll: (self indent: items); yourself]! !


!PortfolioHierarchySummary methodsFor: 'item description' stamp: 'JT 5/31/2023 16:39:07'!
itemForPortfolio: aPortfolio

	^ (self class for: aPortfolio) generate! !

!PortfolioHierarchySummary methodsFor: 'item description' stamp: 'JT 5/31/2023 16:40:56'!
itemForReceptiveAccount: aReceptiveAccount

	| report |
	report := self indent: (AccountSummary for: aReceptiveAccount) generate.
	report addFirst: aReceptiveAccount name.
	
	^ report! !


!classDefinition: #TransferNet category: 'Portfolio2-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 15:24:13'!
itemForAccount: anAccount

	^ anAccount generateReportFor: self! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:16'!
itemForDeposit: aDepositTransaction

	^ 0! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:31'!
itemForDepositLeg: aDepositLeg

	^ aDepositLeg value! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 15:22:33'!
itemForPortfolio: aPortfolio

	^ self itemForAccount: aPortfolio! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 15:22:48'!
itemForReceptiveAccount: aReceptiveAccount

	^ self itemForAccount: aReceptiveAccount! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:51'!
itemForWithdraw: aWithdrawTransaction

	^ 0! !

!TransferNet methodsFor: 'item description' stamp: 'JT 5/31/2023 13:18:42'!
itemForWithdrawLeg: aWithdrawLeg

	^ aWithdrawLeg value negated! !


!TransferNet methodsFor: 'joining items' stamp: 'JT 6/1/2023 01:03:36'!
joinItemsForAccount: aCollectionOfItems

	^ aCollectionOfItems inject: 0 into: [:net :item | net + item].! !

!TransferNet methodsFor: 'joining items' stamp: 'JT 6/1/2023 01:03:46'!
joinItemsForPortfolio: aCollectionOfItems

	^ self joinItemsForAccount: aCollectionOfItems.! !

!TransferNet methodsFor: 'joining items' stamp: 'JT 6/1/2023 01:03:51'!
joinItemsForReceptiveAccount: aCollectionOfItems

	^ self joinItemsForAccount: aCollectionOfItems.! !


!classDefinition: #Transfer category: 'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transfer methodsFor: 'accessing' stamp: 'JT 5/31/2023 11:22:52'!
amount

	^ amount! !

!Transfer methodsFor: 'accessing' stamp: 'JT 5/31/2023 11:08:55'!
depositLeg

	^ depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'JT 5/31/2023 11:08:48'!
withdrawLeg

	^ withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'JT 6/1/2023 00:58:26'!
initializeFrom: anAccountToWithdrawFrom to: anAccountToDepositTo of: anAmount 
	amount := anAmount.
	withdrawLeg := WithdrawLeg of: self.
	depositLeg := DepositLeg of: self.

	anAccountToWithdrawFrom register: withdrawLeg.
	anAccountToDepositTo register: depositLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error description' stamp: 'JT 6/1/2023 00:02:35'!
cannotTransferNonPositiveAmountErrorDescription

	^ 'Cannot transfer a non positive amount'! !

!Transfer class methodsFor: 'error description' stamp: 'JT 6/1/2023 00:01:17'!
cannotTransferToSameAccountErrorDescription

	^ 'Cannot transfer to same account'! !


!Transfer class methodsFor: 'preconditions' stamp: 'JT 6/1/2023 00:00:54'!
verify: anAccount isDifferentFrom: anotherAccount

	anAccount = anotherAccount ifTrue: [self error: self cannotTransferToSameAccountErrorDescription].! !

!Transfer class methodsFor: 'preconditions' stamp: 'JT 6/1/2023 00:02:08'!
verifyIsValidAmount: anAmount

	anAmount <= 0 ifTrue: [self error: self cannotTransferNonPositiveAmountErrorDescription].! !


!Transfer class methodsFor: 'instance creation' stamp: 'JT 6/1/2023 00:14:46'!
from: anAccountToWithdrawFrom to: anAccountToDepositTo of: anAmount 

	self verify: anAccountToWithdrawFrom isDifferentFrom: anAccountToDepositTo.
	self verifyIsValidAmount: anAmount.
	
	^ self new initializeFrom: anAccountToWithdrawFrom to: anAccountToDepositTo of: anAmount.! !
