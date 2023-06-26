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

!ImportTest methodsFor: 'tests' stamp: 'JT 6/26/2023 19:54:56'!
test02AllLinesAreValid
	
	self should: [ CustomerImporter valueFrom: self importDataWithInvalidLines into: session. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter streamHasInvalidLinesErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/26/2023 19:55:31'!
test03StreamCannotStartWithAddress
	
	self should: [ CustomerImporter valueFrom: self importDataStartingWithAddress into: session. ]
		 raise: Error - MessageNotUnderstood
		 withMessageText: CustomerImporter streamCannotStartWithAddressErrorDescription.! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/26/2023 19:56:02'!
test04CustomerLineShouldHave5Items
	
	self should: [CustomerImporter valueFrom: self importDataWithCustomerLineWith4Items into: session]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: CustomerImporter customerLineShouldHave5ItemsErrorDescription! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/26/2023 19:58:30'!
test05AddressLineShouldHave6Items
	
	self should: [CustomerImporter valueFrom: self importDataWithAddressLineWith5Items into: session]
		 raise: Error - MessageNotUnderstood 
		 withMessageText: CustomerImporter addressLineShouldHave6ItemsErrorDescription! !

!ImportTest methodsFor: 'tests' stamp: 'JT 6/26/2023 20:09:51'!
test06
	
	CustomerImporter valueFrom: (ReadStream on: 'C,,Pepe,Sanchez,D') into: session! !


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


!ImportTest methodsFor: 'test data' stamp: 'JT 6/26/2023 19:55:13'!
importDataStartingWithAddress

	^ ReadStream on: 'A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/26/2023 19:57:13'!
importDataWithAddressLineWith5Items

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/26/2023 19:55:59'!
importDataWithCustomerLineWith4Items

	^ ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'JT 6/26/2023 19:54:35'!
importDataWithInvalidLines

	^ ReadStream on: ',,,,

'! !

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


!Address methodsFor: 'initialization' stamp: 'JT 6/26/2023 19:14:57'!
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

!Address class methodsFor: 'instance creation' stamp: 'JT 6/26/2023 19:14:41'!
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

!Customer methodsFor: 'initialization' stamp: 'JT 6/26/2023 19:09:37'!
initializeFirstName: aFirstName lastName: aLastName identificationType: anIdType identificationNumber: anIdNumber 
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdType.
	identificationNumber := anIdNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'JT 6/26/2023 19:08:03'!
firstName: aString lastName: aString2 identificationType: aString3 identificationNumber: aString4 
	^self new initializeFirstName: aString lastName: aString2 identificationType: aString3 identificationNumber: aString4 ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'JT 6/26/2023 20:06:02'!
value

	self withLinesOf: readStream do: [:line | | data |
		data := line findTokens: $,.
		
		self parse: line ifBeginsWith: 'C' then: [
			newCustomer := self createCustomerFrom: data.
			session persist: newCustomer
		].
	
		self parse: line ifBeginsWith: 'A' then: [
			self assertStreamDoesntStartWithAddress.
			newAddress := self createAddressFrom: data.
			newCustomer addAddress: newAddress. ].
	].! !


!CustomerImporter methodsFor: 'parsing' stamp: 'JT 6/26/2023 20:06:08'!
assertStreamDoesntStartWithAddress

	newCustomer ifNil: [self signalStreamCannotStartWithAddress]! !

!CustomerImporter methodsFor: 'parsing' stamp: 'JT 6/26/2023 19:48:37'!
createAddressFrom: anAddressDataArray

	self assert: anAddressDataArray hasSize: 6 ifNotRaiseErrorWith: self class addressLineShouldHave6ItemsErrorDescription.

	^ Address
		streetName: anAddressDataArray second
		streetNumber: anAddressDataArray third asNumber
		town: anAddressDataArray fourth
		zipCode: anAddressDataArray fifth asNumber
		province: anAddressDataArray sixth! !

!CustomerImporter methodsFor: 'parsing' stamp: 'JT 6/26/2023 19:48:45'!
createCustomerFrom: aCustomerDataArray

	self assert: aCustomerDataArray hasSize: 5 ifNotRaiseErrorWith: self class customerLineShouldHave5ItemsErrorDescription.

	^ Customer
		firstName: aCustomerDataArray second
		lastName: aCustomerDataArray third
		identificationType: aCustomerDataArray fourth
		identificationNumber: aCustomerDataArray fifth! !

!CustomerImporter methodsFor: 'parsing' stamp: 'JT 6/26/2023 19:59:59'!
parse: aLine ifBeginsWith: aCharacter then: aBlockToRun

	(aLine beginsWith: aCharacter) ifTrue: [ 
			aBlockToRun value.
	]! !

!CustomerImporter methodsFor: 'parsing' stamp: 'JT 6/26/2023 20:04:42'!
withLinesOf: aReadStream do: aBlockThatUsesLine

	| line |
	line := aReadStream nextLine.
	
	[ line notNil ] whileTrue: [
		self assertIsNotInvalidLine: line.
		aBlockThatUsesLine value: line.
		line := aReadStream nextLine.
	].! !


!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/26/2023 19:46:33'!
assert: aCustomerDataArray hasSize: anExpectedSize ifNotRaiseErrorWith: anErrorDescription  

	aCustomerDataArray size = anExpectedSize ifFalse: [self error: anErrorDescription]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'JT 6/26/2023 19:36:01'!
assertIsNotInvalidLine: aLine

	((aLine beginsWith: 'C') not and: [(aLine beginsWith: 'A') not]) ifTrue: [self signalStreamHasInvalidLines].! !


!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/26/2023 19:50:28'!
signalStreamCannotStartWithAddress

	^ self error: self class streamCannotStartWithAddressErrorDescription! !

!CustomerImporter methodsFor: 'error signaling' stamp: 'JT 6/26/2023 19:36:01'!
signalStreamHasInvalidLines

	^ self error: self class streamHasInvalidLinesErrorDescription! !

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


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/26/2023 19:48:37'!
addressLineShouldHave6ItemsErrorDescription
	^ 'Address line should have 6 items'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/26/2023 19:48:45'!
customerLineShouldHave5ItemsErrorDescription
	^ 'Customer line should have 5 items'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/26/2023 19:38:28'!
streamCannotStartWithAddressErrorDescription
	^ 'Read stream cannot start with address'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'JT 6/26/2023 19:31:49'!
streamHasInvalidLinesErrorDescription
	^ 'Read stream has invalid line'! !


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
