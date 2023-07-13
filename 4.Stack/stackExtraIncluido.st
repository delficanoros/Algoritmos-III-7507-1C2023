!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test-stackIlimitado' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:41:40'!
test11PilaConLimiteEstaVacíaCuandoSeCrea

	| stack |
	
	stack := OOStack new initializePilaLimitada: 2.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:49:13'!
test12SeAgregaUnElementoALaPilaYElTamañoEsElCorrecto

	| stack |
	
	stack := OOStack new initializePilaLimitada: 1.
	stack push: 'algo'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:51:02'!
test13SeAgregaUnElementoALaPilaYSeElimina

	| stack |
	
	stack := OOStack new initializePilaLimitada: 1.
	stack push: 'algo'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:50:47'!
test14PopDevuelveElUltimoObjeto

	| stack pushedObject |
	
	stack := OOStack new initializePilaLimitada: 1.
	pushedObject := 'algo'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:53:40'!
test15StackSeComportaLIFO

	| stack primerObjeto segundoObjeto |
	
	stack := OOStack new initializePilaLimitada: 2.
	primerObjeto := 'primero'.
	segundoObjeto := 'segundo'.
	
	stack push: primerObjeto.
	stack push: segundoObjeto.
	
	self assert: (stack pop = segundoObjeto).
	self assert: (stack pop = primerObjeto).
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:55:23'!
test16StackSeComportaLIFOYElUltimoObjetoEsElCorrecto

	| stack primerObjeto segundoObjeto |
	
	stack := OOStack new initializePilaLimitada: 2.
	primerObjeto := 'primero'.
	segundoObjeto := 'segundo'.
	
	stack push: primerObjeto.
	stack push: segundoObjeto.
	
	self assert: (stack top = segundoObjeto).
	self assert: (stack pop = segundoObjeto).
	self assert: (stack pop = primerObjeto).
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 21:58:52'!
test17ElTamañoEsElCorrecto

	| stack segundoObjeto |
	
	stack := OOStack new initializePilaLimitada: 2.
	
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 22:01:35'!
test18ErrorAlAgregarElementosEnUnaPilaCompleta

	| stack unElemento|
	
	stack := OOStack new initializePilaLimitada: 2.
	
	unElemento := 'adios'.
	
	stack push: 'hola'.
	stack push: 'chau'.
	
	self
		should: [ stack push:  unElemento]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEstaCompletoError]! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 22:02:39'!
test19NoSePuedeSacarElementosEnUnaListaRecientementeVacia

	| stack  |
	
	stack := OOStack new initializePilaLimitada: 1.
	stack push: 'algo'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test-stackLimitado' stamp: 'd 5/8/2023 22:05:54'!
test20InsercionesYEliminacionesVariasEnUnaPila

	| stack primerObjeto segundoObjeto cuartoObjeto tercerObjeto quintoObjeto |
	
	stack := OOStack new initializePilaLimitada: 4.
	primerObjeto := 'primero'.
	segundoObjeto := 'segundo'.
	tercerObjeto := 'tercero'.
	cuartoObjeto := 'cuarto'.
	quintoObjeto := 'quinto'.
	
	stack push: primerObjeto.
	stack push: segundoObjeto.
	stack push: tercerObjeto.
	stack push: cuartoObjeto.
	
	self
		should: [ stack push:  quintoObjeto]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEstaCompletoError].
	
	self assert: (stack top = cuartoObjeto).
	stack pop.
	stack pop.
	stack pop.
	self assert: (stack pop = primerObjeto).
	self assert: stack isEmpty 
	! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/8/2023 18:39:07'!
test01SePruebaUnaCoincidencia
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'winter is coming'.
	unaPila push: 'winning is everything'.
	unaPila push: 'The winds of Winter'.
	unaPila push: 'Winter is here'.
	
	unPrefijo := 'Wint'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 1).
	self assert: ((pilaCoincidencia pop) = 'Winter is here').! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/8/2023 18:39:53'!
test02NoHayCoincidencias
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'winter is coming'.
	unaPila push: 'winning is everything'.
	unaPila push: 'The winds of Winter'.
	unaPila push: 'Winter is here'.
	
	unPrefijo := 'wine'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 0).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/8/2023 18:44:11'!
test03ExistenVariasCoincidencias
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'winter is coming'.
	unaPila push: 'Winter is coming'.
	unaPila push: 'winning is everything'.
	unaPila push: 'Winter has arrived'.
	unaPila push: 'The winds of Winter'.
	unaPila push: 'Winter is here'.
	
	unPrefijo := 'Wint'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 3).
	self assert: ((pilaCoincidencia pop) = 'Winter is coming').
	self assert: ((pilaCoincidencia pop) = 'Winter has arrived').
	self assert: ((pilaCoincidencia pop) = 'Winter is here').
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/9/2023 18:37:47'!
test04TodasSonCoincidencias
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'Primero'.
	unaPila push: 'Segundo'.
	unaPila push: 'Tercero'.
	
	unPrefijo := 'Primero'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 1).
	
	self assert: ((unaPila pop) = 'Tercero').
	self assert: ((unaPila pop) = 'Segundo').
	self assert: ((unaPila pop) = 'Primero').
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/8/2023 18:54:42'!
test05LaOrdenDeLaPilaSeMantiene
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'Primero'.
	unaPila push: 'Segundo'.
	unaPila push: 'Tercero'.
	
	unPrefijo := 'Primero'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 1).
	self assert: (	(unaPila size) = 3).
	
	self assert: ((unaPila pop) = 'Tercero').
	self assert: ((unaPila pop) = 'Segundo').
	self assert: ((unaPila pop) = 'Primero').
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/8/2023 18:54:47'!
test06BuscarEsCaseSensitive
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'Primero'.
	unaPila push: 'Segundo'.
	unaPila push: 'Tercero'.
	
	unPrefijo := 'primero'.
	
	pilaCoincidencia := SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.
	
	self assert: ((pilaCoincidencia size) = 0).
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/9/2023 18:43:46'!
test08ElPrefijoEsUnEspacioVacio

	"Aca probabamos el caso que el prefijo contenga un espacio"
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'Primero Ganador'.
	
	unPrefijo := ' '.
	
"
	self
		should: [SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorPrefijoNoCumpleCaseSensitive]."
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'd 5/9/2023 18:31:08'!
test09ElPrefijoEsVacio
	|unaPila unPrefijo pilaCoincidencia|
	
	unaPila := OOStack new. 
	pilaCoincidencia := OOStack new. 
	
	unaPila push: 'Primero Ganador'.
	
	unPrefijo := ''.
	

	self
		should: [SentenceFinderByPrefix buscarPrefijo: unPrefijo en: unaPila.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix errorPrefijoNoCumpleCaseSensitive].
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'tope pilaTamaño estaLimitado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operaciones' stamp: 'Fm 5/7/2023 19:43:55'!
pop
	|elementoQuitado |
	
	elementoQuitado := tope.
	tope := tope anterior.
	^elementoQuitado pop.
	
! !

!OOStack methodsFor: 'operaciones' stamp: 'Fm 5/8/2023 22:31:43'!
push: unElemento
	
	| nuevoElemento |
	nuevoElemento := ElementoQueNoEsBase inicializarElemento: unElemento sobre: tope conTamanio: ((self size) + 1) tieneLimite: estaLimitado numeroLimite: pilaTamaño.
	tope := nuevoElemento.
	! !

!OOStack methodsFor: 'operaciones' stamp: 'Fm 5/8/2023 13:51:17'!
top
	^tope top.! !


!OOStack methodsFor: 'testing' stamp: 'Fm 5/7/2023 19:17:20'!
isEmpty
	^tope isEmpty.! !

!OOStack methodsFor: 'testing' stamp: 'Fm 5/8/2023 13:32:31'!
size
	^tope size.! !


!OOStack methodsFor: 'initialize' stamp: 'd 5/8/2023 19:34:12'!
initialize
	tope := Base new.
	estaLimitado := false.
! !

!OOStack methodsFor: 'initialize' stamp: 'd 5/8/2023 20:06:20'!
initializePilaLimitada: tamañoLimite
	tope := Base new.
	pilaTamaño := tamañoLimite.
	estaLimitado := true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'as yet unclassified' stamp: 'd 5/8/2023 20:04:59'!
stackEstaCompletoError	
	^ 'Stack se encuentra completo'! !


!classDefinition: #Tope category: 'Stack-Exercise'!
OOStack subclass: #Tope
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Tope methodsFor: 'operaciones' stamp: 'Fm 5/7/2023 19:30:22'!
pop
	self subclassResponsibility .! !

!Tope methodsFor: 'operaciones' stamp: 'Fm 5/8/2023 13:18:49'!
top
	self subclassResponsibility .! !


!Tope methodsFor: 'testing' stamp: 'Fm 5/7/2023 19:31:20'!
anterior! !

!Tope methodsFor: 'testing' stamp: 'Fm 5/7/2023 18:38:13'!
isEmpty
	self subclassResponsibility.! !

!Tope methodsFor: 'testing' stamp: 'Fm 5/8/2023 13:32:48'!
size 
	self subclassResponsibility ! !


!classDefinition: #Base category: 'Stack-Exercise'!
Tope subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'operaciones' stamp: 'Fm 5/7/2023 19:26:31'!
pop
	self error: OOStack stackEmptyErrorDescription.! !

!Base methodsFor: 'operaciones' stamp: 'Fm 5/7/2023 20:04:47'!
top
	self error: OOStack stackEmptyErrorDescription.! !


!Base methodsFor: 'testing' stamp: 'Fm 5/7/2023 18:36:34'!
isEmpty
	^true! !

!Base methodsFor: 'testing' stamp: 'Fm 5/8/2023 13:32:57'!
size 
	^0.! !


!Base methodsFor: 'initialize' stamp: 'Fm 5/8/2023 13:56:18'!
initialize! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Base class' category: 'Stack-Exercise'!
Base class
	instanceVariableNames: ''!

!Base class methodsFor: 'as yet unclassified' stamp: 'Fm 5/7/2023 20:02:40'!
new 
	^Base basicNew initialize.! !


!classDefinition: #ElementoQueNoEsBase category: 'Stack-Exercise'!
Tope subclass: #ElementoQueNoEsBase
	instanceVariableNames: 'anterior tamanio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoQueNoEsBase methodsFor: 'operaciones' stamp: 'Fm 5/8/2023 13:29:09'!
pop
	^tope.! !

!ElementoQueNoEsBase methodsFor: 'operaciones' stamp: 'Fm 5/7/2023 20:05:03'!
top
	^tope.! !


!ElementoQueNoEsBase methodsFor: 'testing' stamp: 'Fm 5/8/2023 13:55:50'!
anterior
	^anterior! !

!ElementoQueNoEsBase methodsFor: 'testing' stamp: 'Fm 5/7/2023 18:51:41'!
isEmpty
	^false.! !

!ElementoQueNoEsBase methodsFor: 'testing' stamp: 'Fm 5/8/2023 13:44:34'!
size 
	^tamanio ! !


!ElementoQueNoEsBase methodsFor: 'initialize' stamp: 'd 5/8/2023 20:11:27'!
inicializarElemento: unElemento sobre: otroElemento conTamanio: ultimaPosicion
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoQueNoEsBase class' category: 'Stack-Exercise'!
ElementoQueNoEsBase class
	instanceVariableNames: ''!

!ElementoQueNoEsBase class methodsFor: 'as yet unclassified' stamp: 'Fm 5/8/2023 22:33:12'!
inicializarElemento: unElemento sobre: otroElemento conTamanio: nuevoTamanio tieneLimite: estaLimitado numeroLimite: cantidadMaximaPila

	|subclaseCorrecta|
	subclaseCorrecta := ElementoQueNoEsBase subclasses detect: [:unaSubclase |unaSubclase tieneLimite: estaLimitado maximoPila: cantidadMaximaPila tamañoActual: (nuevoTamanio - 1)].
	^subclaseCorrecta new inicializarElemento: unElemento sobre: otroElemento conTamanio: nuevoTamanio.
! !

!ElementoQueNoEsBase class methodsFor: 'as yet unclassified' stamp: 'd 5/8/2023 20:14:24'!
tieneLimite: estaLimitado maximoPila: cantidadMaximaPila tamañoActual: tamañoPila
	self subclassResponsibility ! !


!classDefinition: #StackCompleto category: 'Stack-Exercise'!
ElementoQueNoEsBase subclass: #StackCompleto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackCompleto methodsFor: 'initialize' stamp: 'd 5/8/2023 20:05:22'!
inicializarElemento: unElemento sobre: otroElemento conTamanio: ultimaPosicion
	^self error: OOStack stackEstaCompletoError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackCompleto class' category: 'Stack-Exercise'!
StackCompleto class
	instanceVariableNames: ''!

!StackCompleto class methodsFor: 'as yet unclassified' stamp: 'd 5/8/2023 21:48:52'!
tieneLimite: estaLimitado maximoPila: cantidadMaximaPila tamañoActual: tamañoPila
	estaLimitado ifTrue: [^ cantidadMaximaPila <= tamañoPila] ifFalse: [^false] .! !


!classDefinition: #StackIncompleto category: 'Stack-Exercise'!
ElementoQueNoEsBase subclass: #StackIncompleto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackIncompleto methodsFor: 'initialize' stamp: 'd 5/8/2023 19:48:38'!
inicializarElemento: unElemento sobre: otroElemento conTamanio: ultimaPosicion
	tope := unElemento.
	anterior := otroElemento.
	tamanio := ultimaPosicion.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackIncompleto class' category: 'Stack-Exercise'!
StackIncompleto class
	instanceVariableNames: ''!

!StackIncompleto class methodsFor: 'as yet unclassified' stamp: 'd 5/8/2023 21:49:04'!
tieneLimite: estaLimitado maximoPila: cantidadMaximaPila tamañoActual: tamañoPila
	estaLimitado ifTrue: [^cantidadMaximaPila > tamañoPila] ifFalse: [^true].! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'd 5/9/2023 18:43:14'!
buscarPrefijo: unPrefijo en: unaPila	
	|pilaAuxiliar unaFrase pilaCoincidencia|
	
	"Intentamos ambas implementaciones pero no logramos encontrar una solución cuando el prefijo contiene un espacio, dejamos algunas implementaciones que utilizamos:
	- (unPrefijo is: prefijoVacio substringAt: 1) ifTrue: [^self error: SentenceFinderByPrefix errorPrefijoNoCumpleCaseSensitive].
	- ((unPrefijo internalSpaces) = 0) ifFalse: [^self error: SentenceFinderByPrefix errorPrefijoNoCumpleCaseSensitive]."
	
	(unPrefijo isEmpty) ifTrue: [^self error: SentenceFinderByPrefix errorPrefijoNoCumpleCaseSensitive].
			
	pilaAuxiliar := OOStack new. 
	pilaCoincidencia := OOStack new. 	
	
	1 to: (unaPila size) do: [:frase|
	unaFrase := unaPila pop. 
	(unaFrase is: unPrefijo substringAt: 1) ifTrue: [pilaCoincidencia push: unaFrase].
	pilaAuxiliar push: unaFrase.
	]. 

	1 to: (pilaAuxiliar size) do:[:frase|
		unaPila push: (pilaAuxiliar pop).
	].
	
	^pilaCoincidencia.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'd 5/8/2023 18:15:27'!
buscarPrefijo: unPrefijo en: unaPila
	^SentenceFinderByPrefix new buscarPrefijo: unPrefijo en: unaPila.
! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'd 5/9/2023 18:20:15'!
errorPrefijoNoCumpleCaseSensitive
	^'El prefijo es incorrecto, contiene vacío o espacio vacío'! !
