!classDefinition: #StackTest category: 'Stack-Preludio'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:04:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack initialize.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:14:52'!
test02StackPuedeSumarElementoYNoEstaVacia

	| stack |
	stack := Stack initialize.
	
	stack push: 'uno'.
	
	self assert: (stack verUltimoElemento = 'uno'). 
	
	self deny: stack isEmpty.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:19:14'!
test03StackPuedeEliminarUnElementoYQuedaVacio

	| stack elementoEliminado |
	stack := Stack initialize.
	
	stack push: 'uno'.
	elementoEliminado := stack pop.
	
	self assert: elementoEliminado = 'uno'.
	self assert: stack isEmpty.
	
! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:43:42'!
test04StackInsercionDeVariosElementosYeliminacion

	| stack|
	stack := Stack initialize.
	
	stack push: 'uno'.
	stack push: 'dos'.
	stack push: 'tres'.
	stack push: 'cuatro'.
	
	
	self assert: (stack verUltimoElemento = 'cuatro').
	self assert: ('cuatro' = (stack pop)).

	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:37:55'!
test05NoSePuedeAgregarUnElementoVacio

	| stack|
	stack := Stack initialize.
	
	[stack push:'']
	on: Error
	do:[:anError | 
		self assert: Stack elementoEstaVacioError = anError messageText]	
	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:44:47'!
test06NoSePuedeEliminarEnUnStackVacio
	| stack|
	stack := Stack initialize.
	
	[stack pop]
	on: Error
	do:[:anError | 
		self assert: Stack stackVacioMensajeDeError = anError messageText]	
	! !


!classDefinition: #Stack category: 'Stack-Preludio'!
Object subclass: #Stack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Preludio'!

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:27:40'!
errorStackVacio
	self error: self class stackVacioMensajeDeError.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:03:10'!
initializeStack
	stack := OrderedCollection new.
	
! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 17:57:45'!
isEmpty 
	^ stack isEmpty .! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 17:32:17'!
noSePuedeAniadirUnElementoVacio
	^self error: self class elementoEstaVacioError.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:27:40'!
pop
	stack isEmpty ifTrue:[self errorStackVacio].
	^stack removeLast.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:04:55'!
push: unElemento
	unElemento isEmpty ifTrue: [self noSePuedeAniadirUnElementoVacio].
	^stack add: unElemento.
	! !

!Stack methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:27:40'!
verUltimoElemento
	stack isEmpty ifTrue:[self errorStackVacio].
	
	^stack at: stack size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'Stack-Preludio'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 17:32:56'!
elementoEstaVacioError
	^'No se puede agregar un elemento vacio.'! !

!Stack class methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 18:02:56'!
initialize
	^ Stack new initializeStack.
	! !

!Stack class methodsFor: 'as yet unclassified' stamp: 'Fm 5/4/2023 17:28:25'!
stackVacioMensajeDeError
	^ ' Stack esta vacio'.! !

Stack initialize!
