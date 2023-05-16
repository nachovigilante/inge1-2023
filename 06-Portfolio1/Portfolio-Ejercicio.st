!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 20:47:32'!
test08EmptyPortfolioHasHasZeroAsBalance

	| emptyPortfolio |
	emptyPortfolio := Portfolio new.
	
	self assert: 0 equals: emptyPortfolio balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:23:03'!
test09PortfolioWithAccountsHasSumOfAccountsBalanceAsBalance

	| cuentaDeAlicia cuentaDeBeto portfolio |
	portfolio := Portfolio new.
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.
	
	cuentaDeAlicia register: (Deposit for: 10).
	cuentaDeBeto register: (Deposit for: 20).
	
	portfolio add: cuentaDeAlicia.
	portfolio add: cuentaDeBeto.

	self assert: 30 equals: portfolio balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:23:16'!
test10PortfolioWithPortfoliosHasSumOfPortfoliosBalanceAsBalance

	| cuentaDeAlicia cuentaDeBeto portfolio cuentaDeCarmen cuentaDeDamian portfolioFamiliar portfolioTrabajo totalDeCuentas |
	portfolio := Portfolio new.
	portfolioFamiliar := Portfolio new.
	portfolioTrabajo := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.
	
	cuentaDeCarmen := ReceptiveAccount new.
	cuentaDeDamian := ReceptiveAccount new.
	
	
	cuentaDeAlicia register: (Deposit for: 10);
				   register: (Withdraw for: 5).
	
	cuentaDeBeto register: (Withdraw for: 20);
				 register: (Deposit for: 10);
				 register: (Deposit for: 30).
	
	cuentaDeCarmen register: (Deposit for: 10);
				   register: (Withdraw for: 8);
				   register: (Withdraw for: 2).
	
	cuentaDeDamian register: (Withdraw for: 20).
	
	portfolioFamiliar add: cuentaDeAlicia.
	portfolioFamiliar add: cuentaDeBeto.
	
	portfolioTrabajo add: cuentaDeCarmen.
	portfolioTrabajo add: cuentaDeDamian.
	
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.

	totalDeCuentas := cuentaDeAlicia balance + cuentaDeBeto balance + cuentaDeCarmen balance + cuentaDeDamian balance.

	self assert: totalDeCuentas
		 equals: portfolio balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:23:16'!
test11PortfolioWithAccountsAndPortfoliosHasSumOfAccountsAndPortfoliosBalanceAsBalance

	| cuentaDeAlicia cuentaDeBeto portfolio cuentaDeCarmen cuentaDeDamian portfolioFamiliar portfolioTrabajo totalDeCuentas |
	portfolio := Portfolio new.
	portfolioFamiliar := Portfolio new.
	portfolioTrabajo := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.
	
	cuentaDeCarmen := ReceptiveAccount new.
	cuentaDeDamian := ReceptiveAccount new.
	
	
	cuentaDeAlicia register: (Deposit for: 10);
				   register: (Withdraw for: 5).
	
	cuentaDeBeto register: (Withdraw for: 20);
				 register: (Deposit for: 10);
				 register: (Deposit for: 30).
	
	cuentaDeCarmen register: (Deposit for: 10);
				   register: (Withdraw for: 8);
				   register: (Withdraw for: 2).
	
	cuentaDeDamian register: (Withdraw for: 20).
	
	portfolioFamiliar add: cuentaDeAlicia.
	portfolioFamiliar add: cuentaDeBeto.
	
	portfolioTrabajo add: cuentaDeCarmen.
	
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.
	portfolio add: cuentaDeDamian.

	totalDeCuentas := cuentaDeAlicia balance + cuentaDeBeto balance + cuentaDeCarmen balance + cuentaDeDamian balance.

	self assert: totalDeCuentas
		 equals: portfolio balance.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:23:03'!
test12PortfolioHasRegisteredATransactionThatsRegisteredInOneOfItsAccounts

	| cuentaDeAlicia cuentaDeBeto portfolio unaTransaccion |
	portfolio := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.
	
	unaTransaccion := Deposit for: 10.
	cuentaDeAlicia register: unaTransaccion;
				   register: (Withdraw for: 5).
	
	cuentaDeBeto register: (Withdraw for: 20);
				 register: (Deposit for: 10);
				 register: (Deposit for: 30).
	
	portfolio add: cuentaDeAlicia.
	portfolio add: cuentaDeBeto.
	
	self assert: (portfolio hasRegistered: unaTransaccion).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:23:16'!
test13PortfolioHasRegisteredATransactionThatsRegisteredInOneOfItsPortfolios

	| cuentaDeAlicia cuentaDeBeto portfolio depositoAAlicia portfolioFamiliar |
	portfolio := Portfolio new.
	portfolioFamiliar := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.
	
	depositoAAlicia := Deposit for: 10.
	cuentaDeAlicia register: depositoAAlicia;
				   register: (Withdraw for: 5).
	
	cuentaDeBeto register: (Withdraw for: 20);
				 register: (Deposit for: 10);
				 register: (Deposit for: 30).

	portfolioFamiliar add: cuentaDeAlicia.	
	portfolio add: portfolioFamiliar.
	portfolio add: cuentaDeBeto.
	
	self assert: (portfolio hasRegistered: depositoAAlicia).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:28:24'!
test14EmptyPortfolioDoesntHaveTransactions

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:35:07'!
test15PortfolioWithAccountsHasAllAccountsTransactions
	| cuentaDeAlicia cuentaDeBeto portfolio transaccionesDeAlicia transaccionesDeBeto |
	portfolio := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.

	transaccionesDeAlicia := { Deposit for: 10. Withdraw for: 5 }.
	transaccionesDeAlicia do: [:transaccion | 	cuentaDeAlicia register: transaccion].
	
	transaccionesDeBeto := { Withdraw for: 20. Deposit for: 10. Deposit for: 30 }.
	transaccionesDeBeto do: [:transaccion | cuentaDeBeto register: transaccion].

	portfolio add: cuentaDeAlicia.	
	portfolio add: cuentaDeBeto.
	
	self assert: portfolio transactions asSet
		 equals: (transaccionesDeAlicia , transaccionesDeBeto) asSet.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:34:46'!
test16PortfolioWithPortfoliosHasAllPortfoliosTransactions
	| cuentaDeAlicia cuentaDeBeto portfolio portfolioFamiliar transaccionesDeAlicia transaccionesDeBeto portfolioTrabajo |
	portfolio := Portfolio new.
	portfolioFamiliar := Portfolio new.
	portfolioTrabajo := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.

	transaccionesDeAlicia := { Deposit for: 10. Withdraw for: 5 }.
	transaccionesDeAlicia do: [:transaccion | 	cuentaDeAlicia register: transaccion].
	
	transaccionesDeBeto := { Withdraw for: 20. Deposit for: 10. Deposit for: 30 }.
	transaccionesDeBeto do: [:transaccion | cuentaDeBeto register: transaccion].

	portfolioFamiliar add: cuentaDeAlicia.	
	portfolioTrabajo add: cuentaDeBeto.
	portfolio add: portfolioFamiliar.
	portfolio add: portfolioTrabajo.
	
	self assert: portfolio transactions asSet
		 equals: (portfolioFamiliar transactions , portfolioTrabajo transactions) asSet.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'JT 5/15/2023 20:23:10'!
balanceFor: aReceptiveAccount

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


!Deposit methodsFor: 'balance' stamp: 'JT 5/15/2023 20:24:07'!
balanceFor: aReceptiveAccount

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


!Withdraw methodsFor: 'balance' stamp: 'JT 5/15/2023 20:24:26'!
balanceFor: aReceptiveAccount

	^ aReceptiveAccount withdrawBalanceValue: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BalancedAsset category: 'Portfolio-Ejercicio'!
Object subclass: #BalancedAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BalancedAsset methodsFor: 'transactions' stamp: 'JT 5/15/2023 21:25:41'!
transactions

	self subclassResponsibility ! !


!BalancedAsset methodsFor: 'testing' stamp: 'JT 5/15/2023 21:25:32'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BalancedAsset methodsFor: 'balance' stamp: 'JT 5/15/2023 21:20:03'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BalancedAsset subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios balancedAssets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'JT 5/15/2023 21:22:46'!
initialize
	balancedAssets := OrderedCollection new.
	! !


!Portfolio methodsFor: 'balance' stamp: 'JT 5/15/2023 21:22:16'!
balance
	
	^ balancedAssets sum: [:aBalancedAsset | aBalancedAsset balance] ifEmpty: 0! !


!Portfolio methodsFor: 'transactions' stamp: 'JT 5/15/2023 21:32:48'!
transactions

	^ balancedAssets inject: OrderedCollection new
					 into: [:allTransactions :aBalancedAsset | allTransactions addAll: aBalancedAsset transactions; yourself].! !


!Portfolio methodsFor: 'adding' stamp: 'JT 5/15/2023 21:21:10'!
add: aBalancedAsset
	balancedAssets add: aBalancedAsset.! !


!Portfolio methodsFor: 'testing' stamp: 'JT 5/15/2023 21:22:37'!
hasRegistered: aTransaction

	^ balancedAssets anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BalancedAsset subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:54:33'!
balance
	^ transactions sum: [:aTransaction | aTransaction balanceFor: self	] ifEmpty: 0.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:27:29'!
depositBalanceValue: aDepositTransaction

	^ aDepositTransaction value! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:34:24'!
withdrawBalanceValue: aWithdrawTransaction

	^ aWithdrawTransaction value negated! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
