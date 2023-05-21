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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/15/2023 21:37:35'!
test16PortfolioWithPortfoliosHasAllPortfoliosTransactions
	| cuentaDeAlicia cuentaDeBeto portfolio portfolioFamiliar2 transaccionesDeAlicia transaccionesDeBeto portfolioTrabajo |
	portfolio := Portfolio new.
	portfolioFamiliar2 := Portfolio new.
	portfolioTrabajo := Portfolio new.
	
	cuentaDeAlicia := ReceptiveAccount new.
	cuentaDeBeto := ReceptiveAccount new.

	transaccionesDeAlicia := { Deposit for: 10. Withdraw for: 5 }.
	transaccionesDeAlicia do: [:transaccion | 	cuentaDeAlicia register: transaccion].
	
	transaccionesDeBeto := { Withdraw for: 20. Deposit for: 10. Deposit for: 30 }.
	transaccionesDeBeto do: [:transaccion | cuentaDeBeto register: transaccion].

	portfolioFamiliar2 add: cuentaDeAlicia.	
	portfolioTrabajo add: cuentaDeBeto.
	portfolio add: portfolioFamiliar2.
	portfolio add: portfolioTrabajo.
	
	self assert: portfolio transactions asSet
		 equals: (portfolioFamiliar2 transactions , portfolioTrabajo transactions) asSet.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:25:36'!
test17AddAccountToPortfolioThatAlreadyHasItDirectly
	| cuentaRepetida portfolio |
	portfolio := Portfolio new.
	cuentaRepetida := ReceptiveAccount new.
	
	portfolio add: cuentaRepetida.

	self should: [ portfolio add: cuentaRepetida ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio cuentaRepetidaErrorDescription
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:40:56'!
test20AddPortfolioToPortfolioThatAlreadyHasItDirectly
	| portfolio portfolioRepetido |
	portfolio := Portfolio new.
	portfolioRepetido := Portfolio new.

	portfolio add: portfolioRepetido.

	self should: [ portfolio add: portfolioRepetido ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio portfolioRepetidoErrorDescription 
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:41:32'!
test21AddPortfolioToPortfolioThatAlreadyHasItIndirectly
	| portfolio portfolioRepetido otroPortfolio |
	portfolio := Portfolio new.
	otroPortfolio := Portfolio new.
	portfolioRepetido := Portfolio new.

	portfolio add: otroPortfolio.
	otroPortfolio add: portfolioRepetido.

	self should: [ portfolio add: portfolioRepetido ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio portfolioRepetidoErrorDescription 
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:42:13'!
test22AddPortfolioToPortfolioThatAlreadyHasItIndirectlyMultipleLevelsDown
	| portfolio portfolioLevel1 portfolioLevel2 portfolioLevel3 portfolioRepetido |
	portfolio := Portfolio new.
	portfolioLevel1 := Portfolio new.
	portfolioLevel2 := Portfolio new.
	portfolioLevel3 := Portfolio new.
	portfolioRepetido := Portfolio new.

	portfolio add: portfolioLevel1.
	portfolioLevel1 add: portfolioLevel2.
	portfolioLevel2 add: portfolioLevel3.
	portfolioLevel3 add: portfolioRepetido.

	self should: [ portfolio add: portfolioRepetido ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio cuentaRepetidaErrorDescription
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:48:07'!
test23AddAccountToPortfolioThatBelongsToPortfolioThatAlreadyHasItDirectly
	| portfolio cuentaRepetida portfolioRaiz |
	portfolioRaiz := Portfolio new.
	portfolio := Portfolio new.
	cuentaRepetida := ReceptiveAccount new.

	portfolioRaiz add: cuentaRepetida.
	portfolioRaiz add: portfolio.
	

	self should: [ portfolio add: cuentaRepetida ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio cuentaRepetidaErrorDescription
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:49:08'!
test24AddAccountToPortfolioThatBelongsToPortfolioThatAlreadyHasItIndirectly
	| cuentaRepetida portfolioRaiz portfolioRamaA portfolioRamaB |
	portfolioRaiz := Portfolio new.
	portfolioRamaA := Portfolio new.
	portfolioRamaB := Portfolio new.
	cuentaRepetida := ReceptiveAccount new.

	portfolioRaiz add: portfolioRamaA.
	portfolioRaiz add: portfolioRamaB.
	portfolioRamaA add: cuentaRepetida.

	self should: [ portfolioRamaB add: cuentaRepetida ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio cuentaRepetidaErrorDescription
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:51:45'!
test25AddAccountToPortfolioThatBelongsToPortfolioThatAlreadyHasItIndirectlyMultipleLevelsDown
	| cuentaRepetida portfolioRaiz portfolioRamaA portfolioRamaB portfolioLevel1 portfolioLevel2 portfolioLevel3 |
	portfolioRaiz := Portfolio new.
	portfolioRamaA := Portfolio new.
	portfolioRamaB := Portfolio new.
	portfolioLevel1 := Portfolio new.
	portfolioLevel2 := Portfolio new.
	portfolioLevel3 := Portfolio new.
	cuentaRepetida := ReceptiveAccount new.

	portfolioRaiz add: portfolioRamaA.
	portfolioRaiz add: portfolioRamaB.
	portfolioRamaA add: portfolioLevel1.
	portfolioLevel1 add: portfolioLevel2.
	portfolioLevel2 add: portfolioLevel3.
	portfolioLevel3 add: cuentaRepetida.

	self should: [ portfolioRamaB add: cuentaRepetida ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio cuentaRepetidaErrorDescription
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:58:23'!
test26AddPortfolioToPortfolioThatBelongsToPortfolioThatAlreadyHasItDirectly
	| portfolioRaiz portfolioRepetido otroPortfolio |
	portfolioRaiz := Portfolio new.
	otroPortfolio := Portfolio new.
	portfolioRepetido := Portfolio new.

	portfolioRaiz add: portfolioRepetido.
	portfolioRaiz add: otroPortfolio.

	self should: [ otroPortfolio add: portfolioRepetido ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio portfolioRepetidoErrorDescription 
		 ].! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JT 5/21/2023 18:59:32'!
test27AddPortfolioToPortfolioThatBelongsToPortfolioThatAlreadyHasItIndirectly
	| portfolioRaiz portfolioRepetido portfolioRamaB portfolioRamaA |
	portfolioRaiz := Portfolio new.
	portfolioRamaA := Portfolio new.
	portfolioRamaB := Portfolio new.
	portfolioRepetido := Portfolio new.

	portfolioRaiz add: portfolioRamaB.
	portfolioRaiz add: portfolioRamaA.
	portfolioRamaA add: portfolioRepetido.

	self should: [ portfolioRamaB add: portfolioRepetido ]
		 raise: Error
		 withExceptionDo: [:anError |
			anError messageText = Portfolio portfolioRepetidoErrorDescription 
		 ].! !


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


!classDefinition: #Asset category: 'Portfolio-Ejercicio'!
Object subclass: #Asset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Asset methodsFor: 'transactions' stamp: 'JT 5/15/2023 21:25:41'!
transactions

	self subclassResponsibility ! !


!Asset methodsFor: 'assertions' stamp: 'JT 5/21/2023 17:01:55'!
assertCanBeAddedTo: aPortfolio

	self subclassResponsibility ! !


!Asset methodsFor: 'testing' stamp: 'JT 5/21/2023 18:34:52'!
hasAccount: anAccount

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
	instanceVariableNames: 'assets cachedAccounts parentPortfolios cachedPortfolios'
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


!Portfolio methodsFor: 'testing' stamp: 'JT 5/21/2023 18:33:55'!
hasAccount: anAccount

	^ assets anySatisfy: [: anAsset | anAsset hasAccount: anAccount].! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/21/2023 18:38:28'!
hasPortfolio: aPortfolio

	^ self = aPortfolio or: [assets anySatisfy: [:asset | asset hasPortfolio: aPortfolio]].! !

!Portfolio methodsFor: 'testing' stamp: 'JT 5/21/2023 16:40:02'!
hasRegistered: aTransaction

	^ assets anySatisfy: [:asset | asset hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'adding' stamp: 'JT 5/21/2023 17:10:20'!
add: anAsset
	anAsset addTo: self.! !

!Portfolio methodsFor: 'adding' stamp: 'JT 5/21/2023 18:32:36'!
addAccount: anAccount

	self assertDoesntHaveAccount: anAccount.
	
	assets add: anAccount.! !

!Portfolio methodsFor: 'adding' stamp: 'JT 5/21/2023 19:08:35'!
addPortfolio: aPortfolio

	"chequeamos que el portfolio no este repetido porque en caso de agregar uno vacio (A) dos veces,
	 al agregar una cuenta a A no se puede verificar que este repetido"
	self rootPortfolios do: [:rootPortfolio | rootPortfolio assertDoesntHavePortfolio: aPortfolio].
	
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


!Portfolio methodsFor: 'private - assertions' stamp: 'JT 5/21/2023 18:47:41'!
assertDoesntHaveAccount: anAccount

	(self rootPortfolios anySatisfy: [:rootPortfolio | rootPortfolio hasAccount: anAccount]) ifTrue: [self error: self cuentaRepetidaErrorDescription]! !

!Portfolio methodsFor: 'private - assertions' stamp: 'JT 5/21/2023 18:38:58'!
assertDoesntHavePortfolio: aPortfolio

	(self hasPortfolio: aPortfolio) ifTrue: [self error: self portfolioRepetidoErrorDescription].! !


!Portfolio methodsFor: 'private - accessing' stamp: 'JT 5/21/2023 17:23:05'!
cachedAccounts

	^ cachedAccounts ! !

!Portfolio methodsFor: 'private - accessing' stamp: 'JT 5/21/2023 18:02:36'!
cachedPortfolios

	^ cachedPortfolios ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'JT 5/21/2023 17:27:40'!
cuentaRepetidaErrorDescription
	^ 'Cuenta repetida'! !

!Portfolio class methodsFor: 'error descriptions' stamp: 'JT 5/21/2023 18:04:30'!
portfolioRepetidoErrorDescription
	^ 'Portfolio repetido'! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:54:33'!
balance
	^ transactions sum: [:aTransaction | aTransaction balanceFor: self	] ifEmpty: 0.! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:27:29'!
depositBalanceValue: aDepositTransaction

	^ aDepositTransaction value! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JT 5/15/2023 20:34:24'!
withdrawBalanceValue: aWithdrawTransaction

	^ aWithdrawTransaction value negated! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'JT 5/21/2023 18:34:15'!
hasAccount: anAccount

	^ self = anAccount! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'JT 5/21/2023 18:37:49'!
hasPortfolio: aPortfolio

	^ false.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'portfolio' stamp: 'JT 5/21/2023 17:10:45'!
addTo: aPortfolio

	aPortfolio addAccount: self.! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'JT 5/21/2023 17:03:10'!
assertCanBeAddedTo: aPortfolio

	aPortfolio assertCanAddReceptiveAccount: self.! !
