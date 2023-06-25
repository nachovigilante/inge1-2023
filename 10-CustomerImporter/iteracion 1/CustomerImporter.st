!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/22/2023 21:08:42'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'JT 6/22/2023 21:09:06'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'tests' stamp: 'IV 6/25/2023 17:15:19'!
importCustomers

	^ (CustomerImporter from: self dataStream into: session) value! !

!ImportTest methodsFor: 'tests' stamp: 'IV 6/25/2023 17:15:19'!
test01ImportCustomerHasCorrectNumberOfCustomers

	self importCustomers.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.! !

!ImportTest methodsFor: 'tests' stamp: 'IV 6/25/2023 17:15:25'!
test02EachCustomerHasCorrectInformation

	| firstCustomer secondCustomer |	
	self importCustomers.
	
	firstCustomer := self findCustomerIdentifiedBy: '22333444' ofType: 'D'.
	secondCustomer := self findCustomerIdentifiedBy: '23-25666777-9' ofType: 'C'.
	
	self assert: 'Pepe' equals: firstCustomer firstName.
	self assert: 'Sanchez' equals: firstCustomer lastName.
	
	self assert: 'Juan' equals: secondCustomer firstName.
	self assert: 'Perez' equals: secondCustomer lastName.! !

!ImportTest methodsFor: 'tests' stamp: 'IV 6/25/2023 17:14:36'!
test03EachCustomerHasItsAddresses

    | customerA firstAddressOfCustomerA secondAddressOfCustomerA customerB addressOfCustomerB |
    self importCustomers.
    
    customerA := self findCustomerIdentifiedBy: '22333444' ofType: 'D'.
    customerB := self findCustomerIdentifiedBy: '23-25666777-9' ofType: 'C'.
    firstAddressOfCustomerA := Address at: 'San Martin' number: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
    secondAddressOfCustomerA := Address at: 'Maipu' number: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.
    addressOfCustomerB := Address at: 'Alem' number: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.

    self assert: 2 equals: customerA numberOfAddresses.
    self assert: (customerA hasAddress: firstAddressOfCustomerA).
    self assert: (customerA hasAddress: secondAddressOfCustomerA).
    
    self assert: 1 equals: customerB numberOfAddresses.
    self assert: (customerB hasAddress: addressOfCustomerB)! !


!ImportTest methodsFor: 'customers' stamp: 'JT 6/22/2023 21:20:06'!
findCustomerIdentifiedBy: anIdentificationNumber ofType: anIdentificationType 

	| results |
	results := session select: [:aCustomer |  aCustomer isIdentifiedBy: anIdentificationNumber ofType: anIdentificationType.] 
					   ofType: Customer.

	^ results anyOne! !


!ImportTest methodsFor: 'data' stamp: 'IV 6/25/2023 16:17:07'!
dataStream

	^ReadStream on: 
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'initialization' stamp: 'IV 6/25/2023 17:14:00'!
initializeAt: aStreetName number: aStreetNumber town: aTownName zipCode: aZipCode province: aProvinceName 

    streetName := aStreetName.
    streetNumber := aStreetNumber.
    town := aTownName.
    zipCode := aZipCode.
    province := aProvinceName.! !


!Address methodsFor: 'comparing' stamp: 'IV 6/25/2023 17:13:08'!
= anObject

    ^ (anObject isKindOf: (self class))
        and: [ streetName = anObject streetName and: streetNumber = anObject streetNumber ]
        and: [ town = anObject town ]
        and: [ zipCode = anObject zipCode ]
        and: [ province = anObject province ]! !

!Address methodsFor: 'comparing' stamp: 'IV 6/25/2023 17:13:26'!
hash

    ^ streetName hash + streetNumber hash + town hash + zipCode hash + province hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'IV 6/25/2023 17:14:47'!
at: aStreetName number: aStreetNumber town: aTownName zipCode: aZipCode province: aProvinceName 
    ^self new initializeAt: aStreetName number: aStreetNumber town: aTownName zipCode: aZipCode province: aProvinceName! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'IV 6/25/2023 17:15:41'!
hasAddress: anAddress

    ^ addresses includes: anAddress! !

!Customer methodsFor: 'addresses' stamp: 'IV 6/25/2023 17:15:49'!
numberOfAddresses

    ^ addresses size! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'testing' stamp: 'JT 6/22/2023 21:21:52'!
isIdentifiedBy: anIdentificationNumber ofType: anIdentificationType 
	^ identificationType = anIdentificationType and: [identificationNumber = anIdentificationNumber].! !


!Customer methodsFor: 'identification' stamp: 'IV 6/25/2023 17:15:59'!
hasIdOfType: anIdentificationType withNumber: anIdentificationNumber
    ^ identificationType = anIdentificationType and: [identificationNumber = anIdentificationNumber].! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'evaluating' stamp: 'IV 6/25/2023 17:21:07'!
value

	| newCustomer line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	inputStream close
! !


!CustomerImporter methodsFor: 'initialization' stamp: 'IV 6/25/2023 16:07:52'!
initializeFrom: anInputStream into: aDataBaseSession

	session := aDataBaseSession.
	inputStream := anInputStream.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'IV 6/25/2023 16:08:04'!
from: anInputStream into: aDataBaseSession

	^self new initializeFrom: anInputStream into: aDataBaseSession.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
