!classDefinition: #I category: 'Numbers'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numbers'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:37:54'!
next
	next ifNil: [
		next := self cloneNamed: (self name, #I).
		next previous: self
	].
	^next! !

!I class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:38:37'!
previous
	^previous! !

!I class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:38:03'!
previous: otroNumero
	previous := otroNumero! !


!I class methodsFor: 'comparadores' stamp: 'IV 3/30/2023 21:19:27'!
< otroNumero
	^self isNotEqualTo: otroNumero! !

!I class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:08:39'!
<= otroNumero
	^(self > otroNumero) not! !

!I class methodsFor: 'comparadores' stamp: 'IV 3/30/2023 21:19:07'!
> otroNumero
	^false! !

!I class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:05:41'!
>= otroNumero
	^(self < otroNumero) not! !


!I class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 16:10:18'!
between: minimo and: maximo
	^minimo <= self and: (maximo > self)! !

!I class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 15:59:38'!
dividirA: otroNumero
	^otroNumero! !

!I class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 15:39:11'!
restarseDe: otroNumero
	^otroNumero previous! !


!I class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:43:40'!
* otroNumero
	^otroNumero! !

!I class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:43:43'!
+ otroNumero
	^otroNumero next! !

!I class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:58:13'!
- otroNumero
	^self error: self negativeNumbersNotSupportedErrorDescription! !

!I class methodsFor: 'operadores' stamp: 'IV 3/31/2023 16:27:13'!
/ otroNumero
	^otroNumero dividirA: self! !


!I class methodsFor: 'errores' stamp: 'IV 3/31/2023 16:25:03'!
canNotDivideByBiggerNumberErrorDescription
	^'No se puede dividir por un número más grande'! !

!I class methodsFor: 'errores' stamp: 'IV 3/31/2023 15:58:06'!
negativeNumbersNotSupportedErrorDescription
	^'Los números negativos no están soportados por la resta'! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	previous := nil.! !


!classDefinition: #II category: 'Numbers'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numbers'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:51:18'!
* otroNumero
	 ^otroNumero * (self previous) + otroNumero! !

!II class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:39:24'!
+ otroNumero
	^ (self previous) + (otroNumero next)! !

!II class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:52:30'!
- otroNumero
	^ otroNumero restarseDe: self! !

!II class methodsFor: 'operadores' stamp: 'IV 3/31/2023 15:58:53'!
/ otroNumero
	^ otroNumero dividirA: self! !


!II class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:40:59'!
next
	next ifNil: [
		next := II createChildNamed: (self name, #I).
		next previous: self
	].
	^next! !

!II class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:40:15'!
previous
	^previous! !

!II class methodsFor: 'predecesor y sucesor' stamp: 'IV 3/31/2023 15:40:20'!
previous: otroNumero
	previous := otroNumero! !


!II class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:37:33'!
< otroNumero
	[self next - otroNumero] on: Error do: [^true].
	^false! !

!II class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:08:28'!
<= otroNumero
	^(self > otroNumero) not

	! !

!II class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:36:28'!
> otroNumero
	^otroNumero < self

	! !

!II class methodsFor: 'comparadores' stamp: 'IV 3/31/2023 16:05:32'!
>= otroNumero
	^(self < otroNumero) not

	! !


!II class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 16:08:19'!
between: minimo and: maximo
	^minimo <= self and: (maximo > self)! !

!II class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 16:27:49'!
dividirA: otroNumero
	(otroNumero < self) ifTrue: [self error: self canNotDivideByBiggerNumberErrorDescription].
	(otroNumero between: self and: II * self) ifTrue: [^I].
	^I + (self dividirA: otroNumero - self)
! !

!II class methodsFor: 'operadores auxiliares' stamp: 'IV 3/31/2023 16:39:49'!
restarseDe: otroNumero
	^ (otroNumero previous) - self previous! !


!II class methodsFor: 'errores' stamp: 'IV 3/31/2023 16:19:59'!
canNotDivideByBiggerNumberErrorDescription
	^'No se puede dividir por un número más grande'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numbers'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numbers'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numbers'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numbers'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numbers'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numbers'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numbers'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numbers'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numbers'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numbers'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numbers'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numbers'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numbers'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numbers'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numbers'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'IV 3/31/2023 16:40:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!