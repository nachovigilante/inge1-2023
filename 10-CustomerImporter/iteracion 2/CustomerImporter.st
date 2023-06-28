!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 18:17:51'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 18:48:16'!
test02ImportDataCannotHaveEmptyLine
	
	self should: [ CustomerImporter valueFrom: self importDataWithEmptyLine into: session. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter streamCannotHaveEmptyLineErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 18:53:33'!
test03ImportDataCannotHaveLinesWithInvalidPrefix
	
	self should: [ CustomerImporter valueFrom: self importDataWithLineWithInvalidPrefix into: session. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter lineDoesntHaveValidPrefixErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 19:35:40'!
test04ImportDataCannotStartWithAddressLine
	
	self should: [ CustomerImporter valueFrom: self importDataStartingWithAddress into: session. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter streamCannotStartWithAddressErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 19:54:02'!
test05CustomerLineShouldHave5Fields
	
	self should: [CustomerImporter valueFrom: self importDataWithCustomerLineWith4Fields into: session]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: CustomerImporter customerLineShouldHave5FieldsErrorDescription! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 19:55:12'!
test06AddressLineShouldHave6Fields
	
	self should: [CustomerImporter valueFrom: self importDataWithAddressLineWith5Fields into: session]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: CustomerImporter addressLineShouldHave6FieldsErrorDescription! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 20:38:43'!
test07FirstFieldOfCustomerLineShouldBeExactlyC

	self should: [CustomerImporter valueFrom: self importDataWithCustomerWithInvalidFirstField into: session]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter customerShouldHaveExactlyCAsFirstFieldErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/28/2023 20:38:51'!
test08FirstFieldOfAddressLineShouldBeExactlyA

	self should: [CustomerImporter valueFrom: self importDataWithAddressWithInvalidFirstField into: session]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter addressShouldHaveExactlyAAsFirstFieldErrorDescription.! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 19:36:27'!
importDataStartingWithAddress
	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 19:55:15'!
importDataWithAddressLineWith5Fields
	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 20:34:23'!
importDataWithAddressWithInvalidFirstField
	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
Address,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 20:25:58'!
importDataWithCustomerLineWith4Fields
	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 20:33:45'!
importDataWithCustomerWithInvalidFirstField
	^ReadStream on: 'Customer,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 18:49:08'!
importDataWithEmptyLine
	^ ReadStream on: '
'.! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/28/2023 18:54:45'!
importDataWithLineWithInvalidPrefix
	^ ReadStream on: 'B,,,,'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!Address methodsFor: 'initialization' stamp: 'JT 6/28/2023 19:38:46'!
initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'JT 6/28/2023 19:38:34'!
streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	^self new initializeStreetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


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

!Customer methodsFor: 'initialization' stamp: 'JT 6/28/2023 19:46:52'!
initializeFirstName: aFirstName lastName: aLastName idType: anIdentificationType idNumber: anIdentificationNumber 
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'JT 6/28/2023 19:46:43'!
firstName: aFirstName lastName: aLastName idType: anIdentificationType idNumber: anIdentificationNumber
	^self new initializeFirstName: aFirstName lastName: aLastName idType: anIdentificationType idNumber: anIdentificationNumber ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer newAddress record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'JT 6/28/2023 20:42:30'!
value

	[ self nextLineIsNotEmpty ] whileTrue: [  
		self assertLineIsValid.
		self createRecord.
		self importRecord.
	].

	! !


!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/28/2023 19:56:20'!
assertAddressLineHas6Fields
	(self recordHasFields: 6) ifFalse: [self error: self class addressLineShouldHave6FieldsErrorDescription]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/28/2023 19:50:19'!
assertCustomerRecordHas5Fields

	(self recordHasFields: 5) ifFalse: [self signalCustomerLineShouldHave5Fields]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/28/2023 20:44:40'!
assertIsAddressRecord

	^ record first = 'A' ifFalse: [self error: self class addressShouldHaveExactlyAAsFirstFieldErrorDescription]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/28/2023 20:14:44'!
assertLineIsValid
	
	line isEmpty ifTrue: [self signalStreamCannotHaveEmptyLine].
	self lineHasInvalidPrefix ifTrue: [self signalLineDoesntHaveValidPrefix].! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/28/2023 19:40:11'!
assertStreamStartsWithCustomer

	newCustomer ifNil: [self signalStreamCannotStartWithAddress]! !


!CustomerImporter methodsFor: 'testing' stamp: 'JT 6/28/2023 20:40:53'!
isAddressRecord

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'testing' stamp: 'JT 6/28/2023 20:40:45'!
isCustomerRecord

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'testing' stamp: 'JT 6/28/2023 20:40:53'!
lineHasInvalidPrefix
	^ ((self isCustomerRecord) or: [self isAddressRecord]) not! !

!CustomerImporter methodsFor: 'testing' stamp: 'JT 6/28/2023 19:07:29'!
nextLineIsNotEmpty

	line := readStream nextLine.
	^ line notNil! !

!CustomerImporter methodsFor: 'testing' stamp: 'JT 6/28/2023 19:50:10'!
recordHasFields: aNumberOfFields

	^ record size = aNumberOfFields! !


!CustomerImporter methodsFor: 'importing' stamp: 'JT 6/28/2023 20:45:00'!
assertIsCustomerRecord

	^ record first = 'C' ifFalse: [self signalCustomerLineIsntExactlyC]! !

!CustomerImporter methodsFor: 'importing' stamp: 'JT 6/28/2023 19:15:06'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'importing' stamp: 'JT 6/28/2023 20:44:40'!
importAddressFromRecord

	self assertStreamStartsWithCustomer.
	self assertAddressLineHas6Fields.
	self assertIsAddressRecord.

	newAddress := Address
		streetName: record second
		streetNumber: record third asNumber 
		town: record fourth
		zipCode: record fifth asNumber
		province: record sixth.
	newCustomer addAddress: newAddress.! !

!CustomerImporter methodsFor: 'importing' stamp: 'JT 6/28/2023 20:45:00'!
importCustomerFromRecord
	self assertCustomerRecordHas5Fields.
	self assertIsCustomerRecord.
	
	newCustomer := Customer
		firstName: record second
		lastName: record third
		idType: record fourth
		idNumber: record fifth.
			
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'importing' stamp: 'JT 6/28/2023 20:42:30'!
importRecord

	self isCustomerRecord ifTrue: [ self importCustomerFromRecord ].
	self isAddressRecord ifTrue: [ self importAddressFromRecord ].! !


!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 20:35:11'!
signalCustomerLineIsntExactlyA

	self error: self class addressShouldHaveExactlyAAsFirstFieldErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 20:35:33'!
signalCustomerLineIsntExactlyC

	self error: self class customerShouldHaveExactlyCAsFirstFieldErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 19:54:02'!
signalCustomerLineShouldHave5Fields

	^ self error: self class customerLineShouldHave5FieldsErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 18:58:24'!
signalLineDoesntHaveValidPrefix

	^ self error: self class lineDoesntHaveValidPrefixErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 18:50:48'!
signalStreamCannotHaveEmptyLine

	^ self error: self class streamCannotHaveEmptyLineErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/28/2023 19:40:11'!
signalStreamCannotStartWithAddress

	^ self error: self class streamCannotStartWithAddressErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 19:53:40'!
addressLineShouldHave6FieldsErrorDescription
	^ 'Address line should have 6 fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 20:38:07'!
addressShouldHaveExactlyAAsFirstFieldErrorDescription
	^ 'Address line should have "A" as its first field'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 19:54:02'!
customerLineShouldHave5FieldsErrorDescription
	^ 'Customer line should have 5 items'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 20:38:12'!
customerShouldHaveExactlyCAsFirstFieldErrorDescription
	^ 'Customer line should have "C" as its first field'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 18:54:04'!
lineDoesntHaveValidPrefixErrorDescription
	^ 'Line does not have valid prefix'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 18:48:35'!
streamCannotHaveEmptyLineErrorDescription
	^ 'Stream cannot have an empty line'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/28/2023 19:35:58'!
streamCannotStartWithAddressErrorDescription
	^ 'Stream cannot start with address'! !


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
