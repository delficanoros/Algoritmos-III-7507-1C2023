!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #ReportesTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:52:25'!
test01BalanceEImpresiónCorrectaDeUnaCuentaVacia
	| account accountSummary reporteEsperado |
	account := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: account.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Balance = 0 * pesos'.
	
	self assert: reporteEsperado equals: accountSummary realizarResumen .! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:49:04'!
test02SeHaceUnDepósito
	| account accountSummary reporteEsperado |
	account := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: account.
	
	Deposit register: 100 * peso on: account.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Depósito por 100 * pesos'.
	reporteEsperado add: 'Balance = 100 * pesos'.

	self assert:  reporteEsperado equals: accountSummary realizarResumen.

! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:48:45'!
test03SeHaceUnaExtracción
	| account accountSummary reporteEsperado |
	account := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: account.
	
	Withdraw register: 100 * peso on: account.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Extracción por 100 * pesos'.
	reporteEsperado add: 'Balance = -100 * pesos'.

	self assert:  reporteEsperado equals: accountSummary realizarResumen.

! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:49:22'!
test04SeHaceUnaSalidaPorTransferencia
	| originAccount destinationAccount accountSummary reporteEsperado |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: originAccount.
	
	Transfer amount: 20 * peso from: originAccount to: destinationAccount.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Salida por transferencia de 20 * pesos'.
	reporteEsperado add: 'Balance = -20 * pesos'.

	self assert:  reporteEsperado equals: accountSummary realizarResumen.

! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:49:34'!
test05SeHaceUnaEntradaPorTransferencia
	| originAccount destinationAccount accountSummary reporteEsperado |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: originAccount.
	
	Transfer amount: 20 * peso from: destinationAccount to: originAccount.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Entrada por transferencia de 20 * pesos'.
	reporteEsperado add: 'Balance = 20 * pesos'.

	self assert:  reporteEsperado equals: accountSummary realizarResumen.

! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:52:41'!
test06SeRealizanVariasOperacionesEnUnaCuenta
	| originAccount destinationAccount accountSummary reporteEsperado |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: originAccount.
	
	Deposit register: 100 * peso on: originAccount.
	Withdraw register: 100 * peso on: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount .
	Transfer amount: 20 * peso from: destinationAccount to: originAccount.

	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Depósito por 100 * pesos'.
	reporteEsperado add: 'Extracción por 100 * pesos'.
	reporteEsperado add: 'Salida por transferencia de 20 * pesos'.
	reporteEsperado add: 'Entrada por transferencia de 20 * pesos'.

	reporteEsperado add: 'Balance = 0 * pesos'.


	self assert:  reporteEsperado equals: accountSummary realizarResumen.

! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:52:48'!
test07SeRealizaElResumenDeUnPortfolioVacío
	| accountSummary reporteEsperado portfolio account |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	accountSummary := ReporteAccountSummary with: portfolio.
	
	portfolio add: account.
	
	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Balance = 0 * pesos'.
	
	self assert: reporteEsperado equals: accountSummary realizarResumen .! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:53:16'!
test08PortfolioConUnaCuenta
	| originAccount destinationAccount accountSummary reporteEsperado portfolio |
	
	portfolio := Portfolio new.
	accountSummary := ReporteAccountSummary with: portfolio.
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.

	portfolio add: originAccount .

	Deposit register: 100 * peso on: originAccount.
	Withdraw register: 100 * peso on: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount .
	Transfer amount: 20 * peso from: destinationAccount to: originAccount.

	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Depósito por 100 * pesos'.
	reporteEsperado add: 'Extracción por 100 * pesos'.
	reporteEsperado add: 'Salida por transferencia de 20 * pesos'.
	reporteEsperado add: 'Entrada por transferencia de 20 * pesos'.

	reporteEsperado add: 'Balance = 0 * pesos'.


	self assert:  reporteEsperado equals: accountSummary realizarResumen.! !

!ReportesTest methodsFor: 'accountSummary - testing' stamp: 'd 6/13/2023 16:54:04'!
test09PortfolioYCuentasAnidadas
	| originAccount destinationAccount accountSummary reporteEsperado portfolioPrincipal portfolioAnidado |
	
	portfolioAnidado := Portfolio new.
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	portfolioPrincipal := Portfolio with: portfolioAnidado with: originAccount .
	accountSummary := ReporteAccountSummary with: portfolioPrincipal.

	Deposit register: 100 * peso on: originAccount.
	Withdraw register: 100 * peso on: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount .
	Transfer amount: 20 * peso from: destinationAccount to: originAccount.

	reporteEsperado := OrderedCollection new.
	reporteEsperado add: 'Depósito por 100 * pesos'.
	reporteEsperado add: 'Extracción por 100 * pesos'.
	reporteEsperado add: 'Salida por transferencia de 20 * pesos'.
	reporteEsperado add: 'Entrada por transferencia de 20 * pesos'.

	reporteEsperado add: 'Balance = 0 * pesos'.


	self assert:  reporteEsperado equals: accountSummary realizarResumen.! !


!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:54:37'!
test10ElNetoDeUnaCuentaVacíaEsCero
	| originAccount accountSummary |
	originAccount := ReceptiveAccount new.
	accountSummary := ReporteTransferNet with: originAccount.

	self assert:  (0 * peso) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:56:05'!
test11CalculoDelNetoDeUnaCuentaConUnaTransferenciaCorrecto
	| originAccount accountSummary destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteTransferNet with: originAccount.

	Transfer amount: 20 * peso from: destinationAccount to: originAccount .

	self assert:  (20 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:55:59'!
test12CalculoDelNetoConUnaExtraccionEsCorrecto
	| originAccount accountSummary destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteTransferNet with: originAccount.

	Transfer amount: 20 * peso from: originAccount to: destinationAccount .

	self assert:  (-20 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:56:54'!
test13RecibirYEnviarUnaTransferenciaObtieneUnNetoCorrecto
	| originAccount accountSummary destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteTransferNet with: originAccount.

	Transfer amount: 100 * peso from: destinationAccount to: originAccount .
	Transfer amount: 50 * peso from: originAccount to: destinationAccount .

	self assert:  (50 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:59:28'!
test14MúltiplesTransferencias
	| originAccount accountSummary destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	accountSummary := ReporteTransferNet with: originAccount.

	Transfer amount: 100 * peso from: destinationAccount to: originAccount .
	Deposit register: (10*peso) on: originAccount .
	Transfer amount: 50 * peso from: originAccount to: destinationAccount .

	self assert:  (50 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 16:59:53'!
test15ObtenerNetoDeUnPortfolio
	| portfolio accountSummary |
	portfolio := Portfolio new.
	accountSummary := ReporteTransferNet with: portfolio.

	self assert:  (0 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 17:01:28'!
test16MúltiplesTransferenciasEnUnPortfolioConCuenta
	| originAccount accountSummary destinationAccount portfolio |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	portfolio := Portfolio with: originAccount .
	
	accountSummary := ReporteTransferNet with: portfolio.

	Transfer amount: 100 * peso from: destinationAccount to: originAccount .
	Deposit register: (10*peso) on: originAccount .
	Transfer amount: 50 * peso from: originAccount to: destinationAccount .

	self assert:  (50 * peso ) equals: accountSummary calcularNetoTransferencias.


! !

!ReportesTest methodsFor: 'transferNet - testing' stamp: 'd 6/13/2023 17:01:52'!
test17MúltiplesTransferenciasEnPortfoliosAnidadosYCuentas
	| originAccount accountSummary destinationAccount portfolio portfolioAnidado |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	portfolioAnidado := Portfolio with: originAccount .
	portfolio := Portfolio with: portfolioAnidado.
	
	accountSummary := ReporteTransferNet with: portfolio.

	Transfer amount: 100 * peso from: destinationAccount to: originAccount .
	Deposit register: (10*peso) on: originAccount .
	Transfer amount: 50 * peso from: originAccount to: destinationAccount .

	self assert:  (50 * peso ) equals: accountSummary calcularNetoTransferencias.


! !


!ReportesTest methodsFor: 'setUp/tearDown' stamp: 'fm 6/12/2023 12:51:17'!
indentacion

	^'	'! !


!ReportesTest methodsFor: 'treePrinterDetailed - testing' stamp: 'd 6/13/2023 18:30:38'!
test23PortfolioSinNombreSeImprimeDiciendoQueNoTieneNombre
	
	| arbolEsperado treePrinter portfolioSinNombre |
	
	portfolioSinNombre:= Portfolio new.
	treePrinter := PortfolioTreePrinterDetailed para: portfolioSinNombre .
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio sin nombre'.
	arbolEsperado add: self indentacion,'Balance = 0 * pesos'.
	
	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterDetailed - testing' stamp: 'd 6/13/2023 18:39:31'!
test24PortfolioConCuentaImprimeCorrectamenteSuResumen
	
	|portfolioFamiliar cuentaJorge arbolEsperado treePrinter |
	
	cuentaJorge:= ReceptiveAccount named: 'Cuenta de Jorge'.
	Deposit register: (100*peso) on: cuentaJorge.
	portfolioFamiliar:= Portfolio named: 'Portfolio de la familia' with: cuentaJorge.
	
	treePrinter := PortfolioTreePrinterDetailed para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio de la familia'.
	arbolEsperado add: self indentacion, 'Cuenta de Jorge'.
	arbolEsperado add: self indentacion, self indentacion,'Depósito por 100 * pesos'.
	arbolEsperado add: self indentacion, self indentacion,'Balance = 100 * pesos'.
	arbolEsperado add: self indentacion, 'Balance = 100 * pesos'.

	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterDetailed - testing' stamp: 'd 6/13/2023 18:50:17'!
test25PortfoliosYCuentasAnidadasImprimenCorrectamenteSuResumen
	
	|portfolioFamiliar arbolEsperado treePrinter portfolioHijos cuentaFranco |
	
	cuentaFranco := ReceptiveAccount named: 'Cuenta de Franco'.
	Deposit register: (30 * peso) on: cuentaFranco.
	portfolioHijos:= Portfolio named: 'Portfolio de los hijos'with: cuentaFranco.
	portfolioFamiliar:= Portfolio named: 'Portfolio familia' with: portfolioHijos.
	
	treePrinter := PortfolioTreePrinterDetailed para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio familia'.
	arbolEsperado add: self indentacion,'Portfolio de los hijos'.
	arbolEsperado add: self indentacion,self indentacion,'Cuenta de Franco'.
	arbolEsperado add: self indentacion, self indentacion,self indentacion,'Depósito por 30 * pesos'.
	arbolEsperado add: self indentacion, self indentacion,self indentacion,'Balance = 30 * pesos'.
	arbolEsperado add: self indentacion,'Balance = 30 * pesos'.


	self assert: arbolEsperado equals: treePrinter imprimir.

! !


!ReportesTest methodsFor: 'treePrinterSimple - testing' stamp: 'd 6/13/2023 17:03:48'!
test18PortfolioVacioYSinNombreSeImprimeDiciendoQueNoTieneNombre
	
	| arbolEsperado treePrinter portfolioSinNombre |
	
	portfolioSinNombre:= Portfolio new.
	treePrinter := PortfolioTreePrinterSimple para: portfolioSinNombre .
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio sin nombre'.

	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterSimple - testing' stamp: 'd 6/13/2023 17:03:22'!
test19SeImprimeCorrectamenteElNombreDelPortfolio
	
	| arbolEsperado portfolioFamiliar treePrinter |
	
	portfolioFamiliar:= Portfolio named: 'Portfolio de la familia'.
	
	treePrinter := PortfolioTreePrinterSimple para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio de la familia'.

	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterSimple - testing' stamp: 'd 6/13/2023 17:04:54'!
test20PortfolioConCuentaSeImprimenConIndentaciónCorrecta
	
	|portfolioFamiliar cuentaJorge arbolEsperado treePrinter |
	
	cuentaJorge:= ReceptiveAccount named: 'Cuenta de Jorge'.
	portfolioFamiliar:= Portfolio named: 'Portfolio de la familia' with: cuentaJorge.
	
	treePrinter := PortfolioTreePrinterSimple para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio de la familia'.
	arbolEsperado add: self indentacion, 'Cuenta de Jorge'.

	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterSimple - testing' stamp: 'd 6/13/2023 17:05:09'!
test21VariasCuentasTienenSuCorrectaIndentación
	
	|portfolioFamiliar cuentaJorge arbolEsperado treePrinter cuentaPepe |
	
	cuentaPepe :=ReceptiveAccount named: 'Cuenta de Pepe'.
	cuentaJorge:= ReceptiveAccount named: 'Cuenta de Jorge'.
	portfolioFamiliar:= Portfolio named: 'Portfolio de la familia' with: cuentaJorge with: cuentaPepe.
	
	treePrinter := PortfolioTreePrinterSimple para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio de la familia'.
	arbolEsperado add: self indentacion, 'Cuenta de Jorge'.
	arbolEsperado add: self indentacion, 'Cuenta de Pepe'.

	self assert: arbolEsperado equals: treePrinter imprimir.

! !

!ReportesTest methodsFor: 'treePrinterSimple - testing' stamp: 'd 6/13/2023 17:05:43'!
test22PortfoliosYCuentasAnidadasTienenSuCorrectaIndentación
	
	|portfolioFamiliar arbolEsperado treePrinter portfolioHijos cuentaFranco cuentaJuan |
	
	cuentaFranco := ReceptiveAccount named: 'Cuenta de Franco'.
	cuentaJuan := ReceptiveAccount named: 'Cuenta de Juan'.
	portfolioHijos:= Portfolio named: 'Portfolio de los hijos' with: cuentaFranco.
	portfolioFamiliar:= Portfolio named: 'Portfolio de la familia' with: portfolioHijos with: cuentaJuan.
	
	treePrinter := PortfolioTreePrinterSimple para: portfolioFamiliar.
	
	arbolEsperado := OrderedCollection new.
	arbolEsperado add: 'Portfolio de la familia'.
	arbolEsperado add: self indentacion,'Portfolio de los hijos'.
	arbolEsperado add: self indentacion,self indentacion,'Cuenta de Franco'.
	arbolEsperado  add: self indentacion,'Cuenta de Juan'.


	self assert: arbolEsperado equals: treePrinter imprimir.

! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:23:47'!
imprimeConUnaIndentacion: unaIndentacion yUnFormato: unFormatoDeImpresion unReporte: unReporte
	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'fm 6/12/2023 11:59:43'!
name
	^name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'fm 6/12/2023 12:37:23'!
named: nombreDeLaCuenta

	^self new initializeWith: nombreDeLaCuenta ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'fm 6/11/2023 22:48:03'!
initializeWith: nombreDelPortfolio

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := nombreDelPortfolio.! !


!Portfolio methodsFor: 'main protocol' stamp: 'DD 6/11/2023 18:54:54'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'fm 6/12/2023 12:21:25'!
accounts
	^accounts! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:24:14'!
imprimeConUnaIndentacion: unaIndentacion yUnFormato: unFormatoDeImpresion unReporte: unReporte
	
	unReporte add: unaIndentacion, self name.
	self accounts do: [:unaCuenta| 
		^unFormatoDeImpresion imprimirArbolDe: unaCuenta conIndentacion: (unaIndentacion append: String tab).
			].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fm 6/12/2023 12:36:22'!
named: nombreDelportfolio with: unaCuenta

	^(self new initializeWith: nombreDelportfolio)
	add: unaCuenta; 
	yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fm 6/12/2023 12:36:04'!
named: nombreDelportfolio with: unaCuenta with: otraCuenta

	^(self new initializeWith: nombreDelportfolio)
	add: unaCuenta; 
	add: otraCuenta;
	yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fm 6/11/2023 22:32:29'!
initializeWith: nombreDelTitular 

	super initialize.
	transactions := OrderedCollection new.
	name := nombreDelTitular ! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fm 6/11/2023 16:31:06'!
balance

	^transactions 
		inject: (0 * peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]
	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:24:20'!
imprimeConUnaIndentacion: unaIndentacion yUnFormato: unFormatoDeImpresion unReporte: unReporte
	unReporte add: unaIndentacion, self name.
	
	unFormatoDeImpresion imprimirTransacciones: self.
	
	^unReporte! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:19:46'!
operacionNetoDeTransferencia: variable
	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'DD 6/11/2023 17:57:44'!
operacionNetoDeTransferencia: variable

	^variable! !

!Deposit methodsFor: 'value' stamp: 'DD 6/11/2023 17:18:17'!
reporte
	^'Depósito por ', self value asString! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:19:54'!
operacionNetoDeTransferencia: variable
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'DD 6/11/2023 17:56:51'!
operacionNetoDeTransferencia: variable

	^variable + self value! !

!TransferDepositLeg methodsFor: 'accessing' stamp: 'DD 6/11/2023 17:20:24'!
reporte
	^'Entrada por transferencia de ', self value asString! !

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'DD 6/11/2023 17:56:57'!
operacionNetoDeTransferencia: variable

	^variable - self value! !

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'DD 6/11/2023 17:20:30'!
reporte
	^'Salida por transferencia de ', self value asString! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'DD 6/11/2023 17:57:53'!
operacionNetoDeTransferencia: variable

	^variable! !

!Withdraw methodsFor: 'value' stamp: 'DD 6/11/2023 17:20:03'!
reporte
	^'Extracción por ', self value asString! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Reportes category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Reportes
	instanceVariableNames: 'archivo reporte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Reportes methodsFor: 'initialization' stamp: 'DD 6/11/2023 18:32:10'!
initializeWith: anAccount

	archivo := anAccount.
	reporte := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reportes class' category: 'ServiciosFinancieros-Solucion'!
Reportes class
	instanceVariableNames: ''!

!Reportes class methodsFor: 'as yet unclassified' stamp: 'fm 6/9/2023 18:09:04'!
with: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Reportes subclass: #PortfolioTreePrinter
	instanceVariableNames: 'indentacionReporte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'morphic' stamp: 'd 6/12/2023 23:08:39'!
indentacionBásica

	^'	'.! !


!PortfolioTreePrinter methodsFor: 'private' stamp: 'd 6/13/2023 18:50:09'!
imprimir
	| nombreDelPortfolioPrincipal indentacionInicial |
	indentacionReporte := ''.
	
	nombreDelPortfolioPrincipal :=(archivo name) ifNil:['Portfolio sin nombre'].
	reporte add: nombreDelPortfolioPrincipal.
	
	self sumarUnaIndentacion.
	indentacionInicial := indentacionReporte. 
	
	reporte := self agregarAlReporteCon:indentacionInicial.
	
	^reporte! !

!PortfolioTreePrinter methodsFor: 'private' stamp: 'd 6/13/2023 18:23:16'!
imprimirArbolDe: anAccount conIndentacion: unaIndentacion
	indentacionReporte := unaIndentacion.
	^ anAccount imprimeConUnaIndentacion: unaIndentacion yUnFormato: self unReporte: reporte.! !


!PortfolioTreePrinter methodsFor: 'accessing' stamp: 'd 6/12/2023 23:09:54'!
sumarUnaIndentacion

	^ indentacionReporte :=	indentacionReporte append: self indentacionBásica! !


!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:50:09'!
agregarAlReporteCon: indentacionInicial
	self subclassResponsibility ! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:11:28'!
imprimirTransacciones 
	self subclassResponsibility ! !


!classDefinition: #PortfolioTreePrinterDetailed category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter subclass: #PortfolioTreePrinterDetailed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterDetailed methodsFor: 'operations' stamp: 'd 6/13/2023 18:50:09'!
agregarAlReporteCon: indentacionInicial
	archivo accounts do:[:anAccount|
		reporte := self imprimirArbolDe: anAccount conIndentacion: indentacionReporte.
		indentacionReporte := indentacionInicial.
	].
	reporte add: indentacionInicial, 'Balance = ', archivo balance asString.
	^reporte.! !

!PortfolioTreePrinterDetailed methodsFor: 'operations' stamp: 'd 6/13/2023 18:46:17'!
imprimirTransacciones: anAccount
	self sumarUnaIndentacion.
	anAccount transactions do: [:aTransaction|
		reporte add: indentacionReporte, aTransaction reporte.  
	]. 
	reporte add: indentacionReporte, 'Balance = ', anAccount balance asString.
	^reporte! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinterDetailed class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinterDetailed class
	instanceVariableNames: ''!

!PortfolioTreePrinterDetailed class methodsFor: 'as yet unclassified' stamp: 'd 6/12/2023 18:20:33'!
para: unPortfolio
	
	^self new initializeWith: unPortfolio.! !


!classDefinition: #PortfolioTreePrinterSimple category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter subclass: #PortfolioTreePrinterSimple
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterSimple methodsFor: 'private' stamp: 'd 6/13/2023 18:18:24'!
imprimirTransacciones: anAccount
	^self! !


!PortfolioTreePrinterSimple methodsFor: 'as yet unclassified' stamp: 'd 6/13/2023 18:50:09'!
agregarAlReporteCon: indentacionInicial	
	archivo accounts do:[:anAccount|
		reporte := self imprimirArbolDe: anAccount conIndentacion: indentacionReporte.
		indentacionReporte := indentacionInicial.
	].
	^reporte.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinterSimple class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinterSimple class
	instanceVariableNames: ''!

!PortfolioTreePrinterSimple class methodsFor: 'as yet unclassified' stamp: 'fm 6/11/2023 23:51:15'!
para: unPortfolio
	
	^self new initializeWith: unPortfolio.! !


!classDefinition: #ReporteAccountSummary category: 'ServiciosFinancieros-Solucion'!
Reportes subclass: #ReporteAccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReporteAccountSummary methodsFor: 'operations' stamp: 'DD 6/11/2023 18:57:21'!
realizarResumen
	archivo transactions do:[:aTransaction | 
		reporte add: aTransaction reporte. 
		].

	reporte add:('Balance = ', archivo balance asString).
	
	^reporte
	! !


!classDefinition: #ReporteTransferNet category: 'ServiciosFinancieros-Solucion'!
Reportes subclass: #ReporteTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReporteTransferNet methodsFor: 'operations' stamp: 'd 6/13/2023 17:18:11'!
calcularNetoTransferencias
	
	| variable |
	 variable := (0 * peso).
	
	archivo transactions do:[:aTransaction |
		variable := aTransaction operacionNetoDeTransferencia: variable .
		].
	
	^variable
	 
	
	! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
