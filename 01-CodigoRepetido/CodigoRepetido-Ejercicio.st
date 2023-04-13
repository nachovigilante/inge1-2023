!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JT 4/11/2023 00:15:03'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThat: [ customerBook addCustomerNamed: 'John Lennon'. ]
		 takesLessThan: (50 * millisecond)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:12'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook withCustomerNamed: paulMcCartney.
	
	self assertThat: [ customerBook removeCustomerNamed: paulMcCartney. ]
		 takesLessThan: 100 * millisecond! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JT 4/10/2023 23:38:38'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: [ customerBook addCustomerNamed: '' ]
		 throws: Error
		 andDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:19'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := CustomerBook withCustomerNamed: johnLennon.
	
	self assertThat: customerBook
		 after: [ :book | book removeCustomerNamed: 'Paul McCartney' ]
		 throws: NotFound
		 andHasSingleCustomerNamed: johnLennon.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook withSuspendedCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook hasActive: 0 andSuspended: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	

	paulMcCartney := 'Paul McCartney'.
	customerBook := CustomerBook withSuspendedCustomerNamed: paulMcCartney.	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThat: customerBook hasActive: 0 andSuspended: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:35'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := CustomerBook withCustomerNamed: johnLennon.
	
	self assertThat: customerBook
		 cantSuspendACustomerNamed: 'George Harrison'
		 andHasSingleCustomerNamed: johnLennon.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IV 4/13/2023 15:33:40'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook withSuspendedCustomerNamed: johnLennon.

	self assertThat: customerBook
		 cantSuspendACustomerNamed: johnLennon
		 andHasSingleCustomerNamed: johnLennon.! !


!CustomerBookTest methodsFor: 'aux methods' stamp: 'JT 4/11/2023 00:00:07'!
assertThat: aCustomerBook after: aBlock throws: anError andHasSingleCustomerNamed: aName
	self assertThat: [ aBlock value: aCustomerBook ]
		 throws: anError
		 andDo: [ self assert: (aCustomerBook hasSingleCustomerNamed: aName) ].! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'JT 4/11/2023 00:06:35'!
assertThat: aCustomerBook cantSuspendACustomerNamed: aNameToSuspend andHasSingleCustomerNamed: aName

	self assertThat: aCustomerBook
		 after: [ :book | book suspendCustomerNamed: aNameToSuspend ]
		 throws: CantSuspend 
		 andHasSingleCustomerNamed: aName.! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'JT 4/11/2023 00:13:41'!
assertThat: aCustomerBook hasActive: numberOfActiveCustomers andSuspended: numberOfSuspendedCustomers

	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (numberOfActiveCustomers + numberOfSuspendedCustomers ) 
		 equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'JT 4/10/2023 23:54:01'!
assertThat: aBlock takesLessThan: aTimeMeasure
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeMeasure.! !

!CustomerBookTest methodsFor: 'aux methods' stamp: 'JT 4/10/2023 23:54:06'!
assertThat: aBlock throws: anError andDo: errorHandler
	[ aBlock value. self fail ] on: anError do: errorHandler.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'JT 4/11/2023 00:16:13'!
addSuspendedCustomerNamed: aName
	self addCustomerNamed: aName;
		 suspendCustomerNamed: aName.! !

!CustomerBook methodsFor: 'testing' stamp: 'JT 4/11/2023 00:20:48'!
hasSingleCustomerNamed: aName

	^ (self numberOfCustomers = 1) and: [ self includesCustomerNamed: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'aux methods' stamp: 'JT 4/11/2023 00:36:40'!
removeFrom: aCollection aCustomerNamed: aName ifFound: aBlock
	1 to: aCollection size do:
		[ :index |
			aName = (aCollection at: index)
				ifTrue: [ aCollection removeAt: index.
						  aBlock value ]
		]! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JT 4/11/2023 00:23:34'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JT 4/11/2023 00:37:43'!
removeCustomerNamed: aName 

	self removeFrom: active aCustomerNamed: aName ifFound: [^ aName].	
	
	self removeFrom: suspended aCustomerNamed: aName ifFound: [^ aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !


!CustomerBook class methodsFor: 'initialization' stamp: 'IV 4/13/2023 15:32:08'!
withCustomerNamed: aName
	^ self new addCustomerNamed: aName.! !

!CustomerBook class methodsFor: 'initialization' stamp: 'IV 4/13/2023 15:32:40'!
withSuspendedCustomerNamed: aName
	^ self new addSuspendedCustomerNamed: aName.! !
