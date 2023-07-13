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

!CustomerBookTest methodsFor: 'testing' stamp: 'jpcw 4/24/2023 15:58:04'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertAplicar: (customerBook addCustomerNamed: 'John Lennon') dentro: customerBook enMenosDe: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpcw 4/24/2023 16:00:23'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	  
	self assertAplicar: (customerBook removeCustomerNamed: 'Paul McCartney') dentro: customerBook enMenosDe: 100.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpcw 4/24/2023 17:30:05'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.


	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jpcw 4/24/2023 17:31:53'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.

	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 4/25/2023 15:17:06'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	
	|customerBook|
	customerBook := CustomerBook new.
	
	self agregarYSuspenderA: 'Paul McCartney' en: customerBook.
	
	self assertVerificaCantidadClientesEn:  customerBook cantidadActivos: 0 cantidadSusp: 1.
	self assert:(customerBook includesCustomerNamed: 'Paul McCartney').

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 4/25/2023 15:17:10'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self agregarYSuspenderA: 'Paul McCartney' en: customerBook.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	self assertVerificaCantidadClientesEn:  customerBook cantidadActivos: 0  cantidadSusp: 0.
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 4/25/2023 15:04:12'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertVerificaSuspensionEn: customerBook de: 'Ringo Starr'.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 4/25/2023 15:04:12'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.

	self agregarYSuspenderA: johnLennon en: customerBook.

	self assertVerificaSuspensionEn: customerBook de: johnLennon

! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jpcw 4/24/2023 17:40:02'!
agregarYSuspenderA: nombre en: listaClientes
	listaClientes addCustomerNamed: nombre.
	listaClientes suspendCustomerNamed: nombre.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'jpcw 4/24/2023 15:58:11'!
assertAplicar: modificarLista dentro: listaClientes enMenosDe: tiempo

	|millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	modificarLista.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (tiempo * millisecond)
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'd 4/25/2023 15:16:50'!
assertVerificaCantidadClientesEn: listaClientes cantidadActivos: cantidadActivos cantidadSusp: cantidadSuspendidos 
	
	self assert: cantidadActivos equals: listaClientes numberOfActiveCustomers.
	self assert: cantidadSuspendidos equals: listaClientes numberOfSuspendedCustomers.
	self assert: (cantidadActivos + cantidadSuspendidos) equals: listaClientes numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'd 4/25/2023 15:04:12'!
assertVerificaSuspensionEn: listaClientes de: nombre

	[ listaClientes suspendCustomerNamed: nombre.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: listaClientes numberOfCustomers = 1.
			self assert: (listaClientes includesCustomerNamed: 'John Lennon') ]
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jpcw 4/24/2023 18:35:54'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 4/25/2023 15:03:06'!
removeCustomerNamed: aName 
 
	((self buscarYEliminarCliente: aName enEstado: active) or:
	(self buscarYEliminarCliente: aName enEstado: suspended)) ifTrue:[ ^aName] ifFalse: [^ NotFound signal].
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


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'd 4/25/2023 14:57:50'!
buscarYEliminarCliente: nombre  enEstado: estado
	
	1 to: estado size do: 
	[ :index |
		nombre = (estado at: index)
			ifTrue: [
				estado removeAt: index.
				^ true 
			] 
	].
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
