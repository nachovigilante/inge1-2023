!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/18/2023 18:56:29'!
addToEntero: anEntero
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:21:28'!
addToFraccion: aFraccion
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:26:24'!
divideEntero: anEntero
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:21:36'!
divideFraccion: aFraccion
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/18/2023 19:07:36'!
multiplyByEntero: anEntero
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:21:46'!
multiplyByFraccion: aFraccion
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:26:20'!
subtractFromEntero: anEntero
	self subclassResponsibility ! !

!Numero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:21:55'!
subtractFromFraccion: aFraccion
	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:17:39'!
addToEntero: anEntero
	^self class with: value + anEntero integerValue.! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:41:25'!
addToFraccion: aFraccion

	^ (aFraccion denominator * self + aFraccion numerator) / aFraccion denominator! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:30:29'!
divideEntero: anEntero
	^ Fraccion with: anEntero over: self! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:50:14'!
divideFraccion: aFraccion
	
	^aFraccion numerator / (aFraccion denominator * self)! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:17:39'!
multiplyByEntero: anEntero
	^ self class with: anEntero integerValue * value! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:38:36'!
multiplyByFraccion: aFraccion
	
	^(aFraccion numerator * self) / aFraccion denominator.
	! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/20/2023 01:17:39'!
subtractFromEntero: anEntero
	^ self class with: anEntero integerValue - value.! !

!Entero methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:37:40'!
subtractFromFraccion: aFraccion

	^ (aFraccion numerator - (self * aFraccion denominator)) / aFraccion denominator! !


!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:33:07'!
* aMultiplier 
	^ aMultiplier multiplyByEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/18/2023 19:05:16'!
+ anAdder 

	^ anAdder addToEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:23:37'!
- aSubtrahend 
	^ aSubtrahend subtractFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:32:05'!
/ aDivisor 
	^ aDivisor divideEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/20/2023 01:17:39'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 19:04:03'!
fibonacci
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JT 4/20/2023 01:17:39'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:18:32'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger"' ].

	aValue negative ifTrue: [^Negativo withNegativo: aValue].
	aValue > 1 ifTrue: [^MayorAUno withMayorAUno: aValue].
	^ aValue = 0 ifTrue: [ Binario cero ] ifFalse: [ Binario uno ].! !


!classDefinition: #Binario category: 'Numero-Exercise'!
Entero subclass: #Binario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Binario methodsFor: 'arithmetic operations' stamp: 'JT 4/20/2023 01:17:39'!
fibonacci
	^ Entero with: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Binario class' category: 'Numero-Exercise'!
Binario class
	instanceVariableNames: ''!

!Binario class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:16:18'!
cero
	^ self new initalizeWith: 0.! !

!Binario class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:16:12'!
uno
	^ self new initalizeWith: 1.! !


!classDefinition: #MayorAUno category: 'Numero-Exercise'!
Entero subclass: #MayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayorAUno methodsFor: 'arithmetic operations' stamp: 'JT 4/20/2023 01:17:40'!
fibonacci
	|one two|
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MayorAUno class' category: 'Numero-Exercise'!
MayorAUno class
	instanceVariableNames: ''!

!MayorAUno class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:16:59'!
withMayorAUno: anIntegerOverOne

	(anIntegerOverOne isInteger and: anIntegerOverOne > 1) ifFalse: [self error: 'Invalid integer over one'].
	
	^ self new initalizeWith: anIntegerOverOne.! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 19:01:34'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: 'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:16:59'!
withMayorAUno: aNegativeInteger

	(aNegativeInteger isInteger and: aNegativeInteger negative) ifFalse: [ self error: 'Invalid negative value' ].
	
	^ self new initalizeWith: aNegativeInteger.! !

!Negativo class methodsFor: 'instance creation' stamp: 'JT 4/20/2023 01:18:05'!
withNegativo: aNegativeInteger

	(aNegativeInteger isInteger and: aNegativeInteger negative) ifFalse: [ self error: 'Invalid negative value' ].
	
	^ self new initalizeWith: aNegativeInteger.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/18/2023 19:05:00'!
addToEntero: anEntero

	^ (anEntero * denominator + numerator) / denominator! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:39:51'!
addToFraccion: aFraccion

		| newNumerator newDenominator |
		
		newNumerator := (aFraccion numerator * denominator) + (aFraccion denominator * numerator).
		newDenominator := aFraccion denominator * denominator.
		
		^newNumerator / newDenominator! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:25:55'!
divideEntero: anEntero

	^ anEntero * denominator / numerator! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:50:55'!
divideFraccion: aFraccion
	^(aFraccion numerator * denominator) / (aFraccion denominator * numerator)! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/18/2023 19:09:25'!
multiplyByEntero: anEntero

	^anEntero * numerator / denominator.! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:39:08'!
multiplyByFraccion: aFraccion

	^(aFraccion numerator * numerator) / (aFraccion denominator * denominator).
	! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:22:32'!
subtractFromEntero: anEntero

	^ (anEntero * denominator - numerator) / denominator! !

!Fraccion methodsFor: 'auxiliary methods' stamp: 'JT 4/19/2023 18:36:59'!
subtractFromFraccion: aFraccion

		| newNumerator newDenominator |
		
		newNumerator := (aFraccion numerator * denominator) - (aFraccion denominator * numerator).
		newDenominator := aFraccion denominator * denominator.
		
		^newNumerator / newDenominator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:39:18'!
* aMultiplier 

	^ aMultiplier multiplyByFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:49:03'!
+ anAdder 

	^ anAdder addToFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:49:09'!
- aSubtrahend 
	^ aSubtrahend subtractFromFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JT 4/19/2023 18:51:03'!
/ aDivisor 

	^ aDivisor divideFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
