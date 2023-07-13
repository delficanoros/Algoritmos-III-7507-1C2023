!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReceptivePortfoliosTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptivePortfoliosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:43:22'!
test01SeCreaUnPortfolioYElBalanceValeCero

	| portfolio |
	
	portfolio := ReceptivePortfolio new.

	self assert: 0 equals: portfolio balance
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:45:33'!
test02SeAgregaUnaCuentaConUnaTransferencia

	| portfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
	
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account. 

	self assert: (100*peso) equals: portfolio balance
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:45:51'!
test03SeAgreganVariasCuentas

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account1.
	account2 := ReceptiveAccount  new.
	Deposit register: 200 * peso on: account2.
	
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account1. 
	portfolio agregarCuenta: account2. 

	self assert: (300*peso) equals: portfolio balance
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:46:13'!
test04SeAgreganCuentasYOtrosPortfolio
	"revisar"
	| account1 portfolioPrincipal portfolioSecundario account2 |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account1.

	account2 := ReceptiveAccount  new.
	Deposit register: 200 * peso on: account2.
		
	portfolioPrincipal := ReceptivePortfolio new.
	portfolioSecundario := ReceptivePortfolio new.
	
	portfolioPrincipal agregarCuenta: account1. 
	portfolioSecundario agregarCuenta: account2. 
	portfolioPrincipal agregarCuenta: portfolioSecundario. 

	self assert: (300*peso) equals: portfolioPrincipal balance
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:54:34'!
test05VerificaEnUnPortfolioSiUnaCuentaConTransaccionesTuvoAlguna
	| portfolio account |
	
	account := ReceptiveAccount  new.
	Deposit register: (100*peso) on:account.  
	
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account. 
	
	self assert: true equals: portfolio hayAlgunaTransaccion.
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:54:24'!
test05VerificaEnUnPortfolioSiUnaCuentaSinTransaccionesTuvoAlguna
	| portfolio account |
	
	account := ReceptiveAccount  new.
	
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account. 
	
	self assert: false equals: portfolio hayAlgunaTransaccion.
! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:12:41'!
test07SeBuscaUnaTransferencia
	| portfolio account transferencia |
	
	account := ReceptiveAccount  new.
	transferencia := Deposit register: (50*peso) on: account.
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account. 
	self assert: (portfolio seEncuentra: transferencia)! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:12:56'!
test08SeBuscarVariasTransferencias
	| portfolio account transferencia1 transferencia2 transferencia3 |
	
	account := ReceptiveAccount  new.
	transferencia1 := Deposit register: (50*peso) on:account.  
	transferencia2 := Deposit register: (1000*peso) on:account.  
	transferencia3 := Deposit register: (2000*peso) on:account.  
		
	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account. 
	
	self assert: (portfolio seEncuentra: transferencia1).
	self assert: (portfolio seEncuentra: transferencia2).
	self assert: (portfolio seEncuentra: transferencia3).! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:13:46'!
test09SeBuscarTransferenciasEnVariasCuentas
	| portfolio account1 transferencia1 transferencia2 transferencia3 account2 transferencia4 |
	
	account1 := ReceptiveAccount  new.
	transferencia1 := Deposit register: (50*peso) on:account1.  
	transferencia2 := Deposit register: (1000*peso) on:account1.  
	transferencia3 := Deposit register: (2000*peso) on:account1.  
	
	account2 := ReceptiveAccount  new.
	transferencia4 := Deposit register: (50*peso) on:account2.  

	portfolio := ReceptivePortfolio new.
	
	portfolio agregarCuenta: account1. 
	portfolio agregarCuenta: account2. 
	
	self assert: (portfolio seEncuentra: transferencia1).
	self assert: (portfolio seEncuentra: transferencia2).
	self assert: (portfolio seEncuentra: transferencia3).
	self assert: (portfolio seEncuentra: transferencia4).! !

!ReceptivePortfoliosTest methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:14:06'!
test10SeBuscanTransferenciasEnCuentasYPortfolios
	| portfolioPrincipal account transferencia1 portfolioSecundario account2 transferencia2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	portfolioPrincipal := ReceptivePortfolio new.
	portfolioSecundario := ReceptivePortfolio new.
	
	transferencia1 := Deposit register: (50*peso) on:account.
	transferencia2 := Deposit register: (2000*peso) on:account2.  
	
	portfolioSecundario agregarCuenta: account2.
	portfolioPrincipal agregarCuenta: account.  
	portfolioPrincipal agregarCuenta: portfolioSecundario. 
	
	self assert: (portfolioPrincipal seEncuentra: transferencia1).
	self assert: (portfolioPrincipal seEncuentra: transferencia2).! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'testing' stamp: 'd 6/2/2023 16:14:34'!
test01SeTransfiereUnaCantidadDeDineroCorrecta

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: (10 * peso) on: account1.
	Transfer desdeUnaCuenta: account1 aOtraCuenta: account2 unaCantidadDeDinero:  (10 * peso).
	
	self assert: (10 * peso) equals: (account2 balance).
	self assert: (0*peso) equals: (account1 balance).

! !

!TransferTest methodsFor: 'testing' stamp: 'd 6/2/2023 16:15:16'!
test02NoSePuedeTransferir0Pesos

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer desdeUnaCuenta: account1 aOtraCuenta: account2 unaCantidadDeDinero: (0*peso)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = ReceptiveAccount errorTransferirDineroInvalido].
! !

!TransferTest methodsFor: 'testing' stamp: 'd 6/2/2023 16:16:53'!
test03NoSePuedeTransferirAUnaMismaCuenta

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	self should: [Transfer desdeUnaCuenta: account1 aOtraCuenta: account1 unaCantidadDeDinero: (10*peso)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = ReceptiveAccount errorNoSePuedeTransferirASiMismo].
! !

!TransferTest methodsFor: 'testing' stamp: 'd 6/2/2023 16:16:24'!
test04NoSePuedeTransferirDineroNegativo

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	self should: [Transfer desdeUnaCuenta: account1 aOtraCuenta: account2 unaCantidadDeDinero: (-10*peso)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = ReceptiveAccount errorTransferirDineroInvalido ].
! !

!TransferTest methodsFor: 'testing' stamp: 'd 6/6/2023 18:09:21'!
test05SePidenLasPatas

	| account1 account2 transferencia |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: (100 * peso) on: account1.
	transferencia := Transfer desdeUnaCuenta: account1 aOtraCuenta: account2 unaCantidadDeDinero: (100 * peso).
	
	self assert: (100 * peso) equals: transferencia cuentaEmisora value.	

! !

!TransferTest methodsFor: 'testing' stamp: 'd 6/6/2023 18:41:04'!
test06SePidenLasContrapartes

	| account1 account2 transferencia |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: (10 * peso) on: account1.
	transferencia := Transfer desdeUnaCuenta: account1 aOtraCuenta: account2 unaCantidadDeDinero: (100 * peso).
	
	self assert: (100 * peso) equals: (transferencia cantidadUltimaTransferencia). 
	self assert: (transferencia cuentaEmisora) equals: (transferencia contraparteDeUnaCuenta: (transferencia cuentaReceptora) con: (transferencia cuentaEmisora )).
	self assert: (transferencia cuentaReceptora) equals: (transferencia contraparteDeUnaCuenta: (transferencia cuentaEmisora) con: (transferencia cuentaReceptora )).
	
	"Extra: nuestra idea principal acerca de la contraparte era hacer los siguientes tests:
	self assert: (transferencia cuentaEmisora) equals: (transferencia contraparteDeUnaCuenta: (transferencia cuentaReceptora)).
	self assert: (transferencia cuentaReceptora) equals: (transferencia contraparteDeUnaCuenta: (transferencia cuentaEmisora)).	
	y tenemos sus respectivos metodos implementados en los objetos CuentaEmisora y CuentaReceptora, y en transfer el metodo 'contraparteDeUnaCuenta' pero obtuvimos un error. 
	Este es que cuando llegabamos al metodo de contraparte de cada una de las respectivas cuentas, se devolvia nil (creemos que hay un problema con el inicializado) y no lo pudimos solucionar. 
	Te lo dejamos comentado porque tal vez podias encontrar en que falla. Perdon y gracias!!!! " ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'cuentaReceptora cuentaEmisora'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #CuentaReceptora category: 'ServiciosFinancieros-Ejercicio'!
Deposit subclass: #CuentaReceptora
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!CuentaReceptora methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 18:43:52'!
contraparte
	^cuentaEmisora! !

!CuentaReceptora methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 18:30:02'!
contraparteCon: otraCuenta
	^otraCuenta! !

!CuentaReceptora methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:56:26'!
initializeFor: aValue with: unaCuenta

	value := aValue.
	cuentaReceptora := unaCuenta! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CuentaReceptora class' category: 'ServiciosFinancieros-Ejercicio'!
CuentaReceptora class
	instanceVariableNames: 'cuentaReceptora'!

!CuentaReceptora class methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:55:30'!
for: aValue with: unaCuenta

	^ self new initializeFor: aValue with: unaCuenta ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'd 6/6/2023 17:24:10'!
value

	^ value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #CuentaEmisora category: 'ServiciosFinancieros-Ejercicio'!
Withdraw subclass: #CuentaEmisora
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!CuentaEmisora methodsFor: 'as yet unclassified' stamp: 'd 6/2/2023 17:51:26'!
contraparte
	^cuentaReceptora ! !

!CuentaEmisora methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 18:30:10'!
contraparteCon: otraCuenta
	^otraCuenta! !

!CuentaEmisora methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:56:54'!
initializeFor: aValue with: unaCuenta

	value := aValue.
	cuentaEmisora := unaCuenta! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CuentaEmisora class' category: 'ServiciosFinancieros-Ejercicio'!
CuentaEmisora class
	instanceVariableNames: ''!

!CuentaEmisora class methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 17:55:35'!
for: aValue with: unaCuenta

	^ self new initializeFor: aValue with: unaCuenta ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'd 5/30/2023 21:06:30'!
balance

	^transactions sum: [ :aTransaction | 
		(aTransaction isKindOf: Deposit) ifTrue: [aTransaction value] 
								     ifFalse: [aTransaction value negated] 
		] 
	ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'xxx' stamp: 'd 6/6/2023 15:55:26'!
errorNoSePuedeTransferirAUnoMismo

	^ ReceptiveAccount error: ReceptiveAccount errorNoSePuedeTransferirASiMismo! !

!ReceptiveAccount methodsFor: 'xxx' stamp: 'd 6/6/2023 15:55:44'!
errorTransferirDineroInvalido

	^ ReceptiveAccount error: ReceptiveAccount errorTransferirDineroInvalido! !

!ReceptiveAccount methodsFor: 'xxx' stamp: 'd 6/6/2023 15:55:44'!
transferir: unaCantidadDeDinero aCuenta: unaCuenta 
	(unaCantidadDeDinero <= (0*peso)) ifTrue: [^self errorTransferirDineroInvalido].
	(self == unaCuenta) ifTrue: [^self errorNoSePuedeTransferirAUnoMismo].
	Withdraw register: unaCantidadDeDinero on: self.
	Deposit register: unaCantidadDeDinero on: unaCuenta.! !


!ReceptiveAccount methodsFor: 'estaRegistrada: unaTransaccion' stamp: 'd 6/6/2023 17:12:05'!
seEncuentra: unaTransferencia 
	^transactions includes: unaTransferencia ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'd 6/2/2023 16:04:58'!
errorNoSePuedeTransferirASiMismo
	^'No se puede transferir dinero a una misma cuenta'.! !

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'd 6/2/2023 15:57:47'!
errorTransferirDineroInvalido
	^'No se puede transferir dinero invalido'.! !


!classDefinition: #ReceptivePortfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptivePortfolio
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptivePortfolio methodsFor: 'xxx' stamp: 'd 6/2/2023 18:42:09'!
agregarCuenta: unaCuenta 
	portfolio add: unaCuenta! !

!ReceptivePortfolio methodsFor: 'xxx' stamp: 'd 6/2/2023 18:24:25'!
balance
	^portfolio sum: [:unaCuenta | unaCuenta balance] ifEmpty: [ 0 ].! !

!ReceptivePortfolio methodsFor: 'xxx' stamp: 'd 6/2/2023 18:49:18'!
hayAlgunaTransaccion
	1 to: portfolio size do:[:index | |unaCuenta| unaCuenta := portfolio at: index.
		 ((unaCuenta transactions size) > 0) ifTrue: [^true]].
	^false.! !

!ReceptivePortfolio methodsFor: 'xxx' stamp: 'd 6/6/2023 14:55:41'!
initialize
	portfolio := OrderedCollection new.! !

!ReceptivePortfolio methodsFor: 'xxx' stamp: 'd 6/6/2023 17:10:18'!
seEncuentra: unaTransferencia
	^portfolio anySatisfy: [:anAccount | anAccount seEncuentra: unaTransferencia].! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'cantidadDeDinero cuentaEmisora cuentaReceptora'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'datosDeTransferencia' stamp: 'd 6/2/2023 16:19:10'!
cantidadUltimaTransferencia
	^cantidadDeDinero ! !


!Transfer methodsFor: 'initialize' stamp: 'd 6/6/2023 18:00:55'!
initializeTransferirDesdeUnaCuenta: unaCuentaEmisora aOtraCuenta: unaCuentaReceptora unaCantidadDeDinero: unaCantidadDeDinero
	cantidadDeDinero := unaCantidadDeDinero.
	cuentaEmisora := CuentaEmisora for: cantidadDeDinero with: unaCuentaEmisora.
	cuentaReceptora := CuentaReceptora for: cantidadDeDinero with: unaCuentaReceptora.
	unaCuentaEmisora transferir: unaCantidadDeDinero aCuenta: unaCuentaReceptora.! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 18:42:46'!
contraparteDeUnaCuenta: unaCuenta
	^unaCuenta contraparte! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 18:35:25'!
contraparteDeUnaCuenta: unaCuenta con: otraCuenta
	^unaCuenta contraparteCon: otraCuenta! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:34:48'!
cuentaEmisora
	^cuentaEmisora! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'd 6/6/2023 16:34:53'!
cuentaReceptora
	^cuentaReceptora! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance initialization' stamp: 'd 6/2/2023 16:12:06'!
desdeUnaCuenta: unaCuentaEmisora aOtraCuenta: unaCuentaReceptora unaCantidadDeDinero: unaCantidadDeDinero
	^self new initializeTransferirDesdeUnaCuenta: unaCuentaEmisora aOtraCuenta: unaCuentaReceptora unaCantidadDeDinero: unaCantidadDeDinero.

! !
