!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio portfolioFamiliar portfolioTrabajo emptyPortfolio cuentaVacia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'portfolios' stamp: 'JT 5/22/2023 13:45:08'!
fromRoot: aPortfolio createPortfolioChainOfSize: aNumberOfPortfolios

	| lastPortfolio |
	lastPortfolio := aPortfolio.
	
	1 to: aNumberOfPortfolios do: [:i | |newPortfolio|
		newPortfolio := Portfolio new.
		lastPortfolio add: newPortfolio.
		lastPortfolio := newPortfolio.
	].

	^ lastPortfolio! !


!PortfolioTest methodsFor: 'accounts' stamp: 'JT 5/22/2023 13:02:35'!
accountWith: transactions

	| account |
	account := ReceptiveAccount new.
	
	transactions do: [:transaction | account register: transaction].
	
	^ account.! !


!PortfolioTest methodsFor: 'setUp/tearDown' stamp: 'JT 5/22/2023 13:57:43'!
setUp

	portfolio := Portfolio new.
	portfolioFamiliar := Portfolio new.
	portfolioTrabajo := Portfolio new.
	emptyPortfolio := Portfolio new.
	cuentaVacia := ReceptiveAccount new.! !


!PortfolioTest methodsFor: 'assertions' stamp: 'IV 5/22/2023 15:17:55'!
should: aPortfolio afterAdding: anAsset throwErrorWithMessage: anErrorMessage

	^ self should: [ aPortfolio add: anAsset. ]
		 raise: Error
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: anErrorMessage
		 ]! !


!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:22'!
test00EmptyPortfolioHasHasZeroAsBalance
	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:22'!
test01PortfolioWithAccountsHasSumOfAccountsBalanceAsBalance

	portfolio add: (self accountWith: { Deposit for: 10 }).
	portfolio add: (self accountWith: { Deposit for: 20 }).

	self assert: 30 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:31'!
test02PortfolioWithPortfoliosHasSumOfPortfoliosBalanceAsBalance

	| cuentaDeAlicia cuentaDeBeto cuentaDeCarmen cuentaDeDamian totalDeCuentas |
	cuentaDeAlicia := self accountWith: {Deposit for: 10. Withdraw for: 5}.
	cuentaDeBeto := self accountWith: {Withdraw for: 20. Deposit for: 10. Deposit for: 30}.
	
	cuentaDeCarmen := self accountWith: {Deposit for: 10. Withdraw for: 8. Withdraw for: 2}.
	cuentaDeDamian := self accountWith: {Withdraw for: 20}.
	
	portfolioFamiliar add: cuentaDeAlicia.
	portfolioFamiliar add: cuentaDeBeto.
	
	portfolioTrabajo add: cuentaDeCarmen.
	portfolioTrabajo add: cuentaDeDamian.
	
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.

	totalDeCuentas := cuentaDeAlicia balance + cuentaDeBeto balance + cuentaDeCarmen balance + cuentaDeDamian balance.

	self assert: totalDeCuentas
		 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:31'!
test03PortfolioWithAccountsAndPortfoliosHasSumOfAccountsAndPortfoliosBalanceAsBalance

	| cuentaDeAlicia cuentaDeBeto cuentaDeCarmen cuentaDeDamian totalDeCuentas |
	cuentaDeAlicia := self accountWith: {Deposit for: 10. Withdraw for: 5}.
	cuentaDeBeto := self accountWith: {Withdraw for: 20. Deposit for: 10. Deposit for: 30}.
	
	cuentaDeCarmen := self accountWith: {Deposit for: 10. Withdraw for: 8. Withdraw for: 2}.
	cuentaDeDamian := self accountWith: {Withdraw for: 20}.
	
	portfolioFamiliar add: cuentaDeAlicia.
	portfolioFamiliar add: cuentaDeBeto.
	
	portfolioTrabajo add: cuentaDeCarmen.
	
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.
	portfolio add: cuentaDeDamian.

	totalDeCuentas := cuentaDeAlicia balance + cuentaDeBeto balance + cuentaDeCarmen balance + cuentaDeDamian balance.

	self assert: totalDeCuentas
		 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:22'!
test04PortfolioHasRegisteredATransactionThatsRegisteredInOneOfItsAccounts

	| cuentaDeAlicia cuentaDeBeto unaTransaccion |
	unaTransaccion := Deposit for: 10.
	cuentaDeAlicia := self accountWith: {unaTransaccion. Withdraw for: 5}.
	cuentaDeBeto := self accountWith: {Withdraw for: 20. Deposit for: 10. Deposit for: 30}.
	
	portfolio add: cuentaDeAlicia.
	portfolio add: cuentaDeBeto.
	
	self assert: (portfolio hasRegistered: unaTransaccion).! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:28'!
test05PortfolioHasRegisteredATransactionThatsRegisteredInOneOfItsPortfolios

	| cuentaDeAlicia cuentaDeBeto depositoAAlicia |
	depositoAAlicia := Deposit for: 10.
	cuentaDeAlicia := self accountWith: {depositoAAlicia. Withdraw for: 5}.
	cuentaDeBeto := self accountWith: {Withdraw for: 20. Deposit for: 10. Deposit for: 30}.

	portfolioFamiliar add: cuentaDeAlicia.	
	portfolio add: portfolioFamiliar.
	portfolio add: cuentaDeBeto.
	
	self assert: (portfolio hasRegistered: depositoAAlicia).! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:22'!
test06EmptyPortfolioDoesntHaveTransactions

	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 14:00:47'!
test07PortfolioWithAccountsHasAllAccountsTransactions

	| cuentaDeAlicia cuentaDeBeto |
	cuentaDeAlicia := self accountWith: { Deposit for: 10. Withdraw for: 5 }.	
	cuentaDeBeto := self accountWith: { Withdraw for: 20. Deposit for: 10. Deposit for: 30 }.	

	portfolio add: cuentaDeAlicia.	
	portfolio add: cuentaDeBeto.
	
	self assert: portfolio transactions asSet
		 equals: (cuentaDeAlicia transactions , cuentaDeBeto transactions) asSet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 14:01:05'!
test08PortfolioWithPortfoliosHasAllPortfoliosTransactions
	| cuentaDeAlicia cuentaDeBeto |
	cuentaDeAlicia := self accountWith: { Deposit for: 10. Withdraw for: 5 }.	
	cuentaDeBeto := self accountWith: { Withdraw for: 20. Deposit for: 10. Deposit for: 30 }.

	portfolioFamiliar add: cuentaDeAlicia.	
	portfolioTrabajo add: cuentaDeBeto.
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.
	
	self assert: portfolio transactions asSet
		 equals: (cuentaDeAlicia transactions , cuentaDeBeto transactions) asSet.! !

!PortfolioTest methodsFor: 'tests' stamp: 'IV 5/22/2023 15:21:29'!
test09CannotAddAccountToPortfolioThatAlreadyHasItDirectly
	
	portfolio add: cuentaVacia.
	
	self should: portfolio
		 afterAdding: cuentaVacia
		 throwErrorWithMessage: Portfolio cuentaRepetidaErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'IV 5/22/2023 15:19:46'!
test10CannotAddEmptyPortfolioToPortfolioThatAlreadyHasIt
	
	portfolio add: emptyPortfolio.

	self should: portfolio
		 afterAdding: emptyPortfolio
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription ! !

!PortfolioTest methodsFor: 'tests' stamp: 'IV 5/22/2023 15:20:27'!
test11CannotAddPortfolioWithAnAccountToAnotherPortfolioThatAlreadyHasThatAccount

	portfolio add: cuentaVacia.
	portfolioFamiliar add: cuentaVacia.
	
	self should: portfolio
		 afterAdding: portfolioFamiliar
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:45:22'!
test12CannotAddEmptyPortfolioToItself

	self should: portfolio
		 afterAdding: portfolio
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'IV 5/22/2023 15:22:01'!
test13CannotAddNonEmptyPortfolioToItself

	portfolio add: cuentaVacia.
	
	self should: portfolio 
	  	 afterAdding: cuentaVacia
		 throwErrorWithMessage: Portfolio cuentaRepetidaErrorDescription ! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:57:29'!
test14CannotAddEmptyPortfolioToPortfolioThatHasItMultipleLevelsDown

	| portfolioLevel3 |
	portfolioLevel3 := self fromRoot: portfolio createPortfolioChainOfSize: 3.
	
	portfolioLevel3 add: emptyPortfolio.
	
	self should: portfolio
	 	 afterAdding: emptyPortfolio
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:57:29'!
test15CannotAddEmptyPortfolioToPortfolioThatHasItMultipleLevelsUp

	| portfolioLevel3 |
	portfolioLevel3 := self fromRoot: portfolio createPortfolioChainOfSize: 3.
	
	portfolio add: emptyPortfolio.
	
	self should: portfolioLevel3
	 	 afterAdding: emptyPortfolio
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:59:17'!
test16CannotAddPortfolioWithAccountToPortfolioThatHasItMultipleLevelsDown

	| portfolioLevel3 |
	portfolioLevel3 := self fromRoot: portfolio createPortfolioChainOfSize: 3.
	
	portfolioFamiliar add: cuentaVacia.
	portfolioLevel3 add: cuentaVacia.
	
	self should: portfolio
		 afterAdding: portfolioFamiliar
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription! !

!PortfolioTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:59:28'!
test17CannotAddPortfolioWithAccountToPortfolioThatHasItMultipleLevelsUp

	| portfolioBranchA portfolioBranchB |
	portfolioBranchA := self fromRoot: portfolio createPortfolioChainOfSize: 3.
	portfolioBranchB := self fromRoot: portfolio createPortfolioChainOfSize: 1.
	
	portfolioBranchB add: cuentaVacia.
	portfolioFamiliar add: cuentaVacia.

	self should: portfolioBranchA
		 afterAdding: portfolioFamiliar
		 throwErrorWithMessage: Portfolio portfolioRepetidoOConCuentasEnComunErrorDescription.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'setUp/tearDown' stamp: 'JT 5/22/2023 13:51:16'!
setUp

	account := ReceptiveAccount new.! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test02DepositIncreasesBalanceOnTransactionValue 

	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test04WithdrawValueMustBePositive 

	self assert: (Withdraw register: 50 on: account) value positive! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/22/2023 13:51:16'!
test07AccountKnowsItsTransactions 

	| deposit |
	deposit := Deposit register: 50 on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'IV 5/22/2023 15:32:50'!
affectBalanceOf: aReceptiveAccount

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'IV 5/22/2023 15:32:50'!
affectBalanceOf: aReceptiveAccount

	^ aReceptiveAccount depositBalanceValue: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'IV 5/22/2023 15:32:50'!
affectBalanceOf: aReceptiveAccount

	^ aReceptiveAccount withdrawBalanceValue: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'transactions' stamp: 'JT 5/15/2023 21:25:41'!
transactions

	self subclassResponsibility ! !


!Asset methodsFor: 'testing' stamp: 'JT 5/21/2023 18:34:52'!
hasAccount: anAccount

	self subclassResponsibility ! !

!Asset methodsFor: 'testing' stamp: 'JT 5/22/2023 12:07:43'!
hasAccountInCommonWith: aPortfolio

	self subclassResponsibility ! !

!Asset methodsFor: 'testing' stamp: 'JT 5/21/2023 18:37:44'!
hasPortfolio: aPortfolio

	self subclassResponsibility! !

!Asset methodsFor: 'testing' stamp: 'JT 5/15/2023 21:25:32'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!Asset methodsFor: 'portfolio' stamp: 'JT 5/21/2023 16:46:19'!
addTo: aPortfolio

	self subclassResponsibility ! !


!Asset methodsFor: 'balance' stamp: 'JT 5/15/2023 21:20:03'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Asset subclass: #Portfolio
	instanceVariableNames: 'assets parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'JT 5/21/2023 18:32:00'!
initialize
	assets := OrderedCollection new.
	parentPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'JT 5/21/2023 16:39:16'!
balance
	
	^ assets sum: [:asset | asset balance] ifEmpty: 0! !


!Portfolio methodsFor: 'transactions' stamp: 'JT 5/21/2023 16:39:36'!
transactions

	^ assets inject: OrderedCollection new
					 into: [:allTransactions :asset | allTransactions addAll: asset transactions; yourself].! !


!Portfolio methodsFor: 'testing' stamp: 'JT 5/22/2023 12:11:36'!
accountCannotBeAdded: anAccount

	^ self rootPortfolios anySatisfy: [:rootPortfolio | rootPortfolio hasAccount: anAccount]! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/21/2023 18:33:55'!
hasAccount: anAccount

	^ assets anySatisfy: [: anAsset | anAsset hasAccount: anAccount].! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/22/2023 12:18:39'!
hasAccountInCommonWith: aPortfolio

	"Chequeamos por igualdad por si se quiere agregar un portfolio vacio.
	 Si un portfolio vacio (A) se quiere agregar a otro portfolio (B), estos
	 no tienen cuentas en comun y se puede	 agregar (A) 2 veces a (B). Luego
	 si se agrega una cuenta a (A), no se puede detectar la cuenta repetida."
	^ self = aPortfolio or: [assets anySatisfy: [:asset | asset hasAccountInCommonWith: aPortfolio]].! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/21/2023 16:40:02'!
hasRegistered: aTransaction

	^ assets anySatisfy: [:asset | asset hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/22/2023 12:11:49'!
portfolioCannotBeAdded: aPortfolio

	^ self rootPortfolios anySatisfy: [:rootPortfolio | rootPortfolio hasAccountInCommonWith: aPortfolio]! !


!Portfolio methodsFor: 'adding' stamp: 'JT 5/21/2023 17:10:20'!
add: anAsset
	anAsset addTo: self.! !

!Portfolio methodsFor: 'adding' stamp: 'JT 5/22/2023 11:51:46'!
addAccount: anAccount

	self assertAccountCanBeAdded: anAccount.
	
	assets add: anAccount.! !

!Portfolio methodsFor: 'adding' stamp: 'JT 5/22/2023 11:55:29'!
addPortfolio: aPortfolio

	self assertPortfolioCanBeAdded: aPortfolio.
	
	assets add: aPortfolio.
	
	aPortfolio registerParent: self.! !

!Portfolio methodsFor: 'adding' stamp: 'JT 5/21/2023 17:10:32'!
addTo: aPortfolio

	aPortfolio addPortfolio: self.! !


!Portfolio methodsFor: 'parents' stamp: 'JT 5/21/2023 17:47:39'!
registerParent: aPortfolio

	parentPortfolios add: aPortfolio.! !

!Portfolio methodsFor: 'parents' stamp: 'JT 5/21/2023 17:56:21'!
rootPortfolios

	^ parentPortfolios
		collect: [:parentPortfolio | parentPortfolio rootPortfolios]
		andFold: [:allRootPortfolios :rootPortfolios | allRootPortfolios addAll: rootPortfolios; yourself ]
		ifEmpty: [OrderedCollection with: self].! !


!Portfolio methodsFor: 'private - assertions' stamp: 'IV 5/22/2023 15:18:19'!
assertAccountCanBeAdded: anAccount

	(self accountCannotBeAdded: anAccount) ifTrue: [self error: self class cuentaRepetidaErrorDescription]! !

!Portfolio methodsFor: 'private - assertions' stamp: 'IV 5/22/2023 15:18:23'!
assertPortfolioCanBeAdded: aPortfolio

	(self portfolioCannotBeAdded: aPortfolio) ifTrue: [self error: self class portfolioRepetidoOConCuentasEnComunErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'JT 5/22/2023 12:22:58'!
cuentaRepetidaErrorDescription
	^ 'Cuenta repetida'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'JT 5/22/2023 12:22:12'!
portfolioRepetidoOConCuentasEnComunErrorDescription
	^ 'Portfolio repetido o con cuentas en comun'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Asset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'IV 5/22/2023 15:32:51'!
balance
	^ transactions sum: [:aTransaction | aTransaction affectBalanceOf: self	] ifEmpty: 0.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:27:29'!
depositBalanceValue: aDepositTransaction

	^ aDepositTransaction value! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:34:24'!
withdrawBalanceValue: aWithdrawTransaction

	^ aWithdrawTransaction value negated! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'JT 5/21/2023 18:34:15'!
hasAccount: anAccount

	^ self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'JT 5/22/2023 12:08:07'!
hasAccountInCommonWith: aPortfolio

	^ aPortfolio hasAccount: self.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'portfolio' stamp: 'JT 5/21/2023 17:10:45'!
addTo: aPortfolio

	aPortfolio addAccount: self.! !
