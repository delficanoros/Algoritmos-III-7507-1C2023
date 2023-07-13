!classDefinition: #MarsRoverTest category: 'MarsRover-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Tests'!

!MarsRoverTest methodsFor: 'testing' stamp: 'jpcw 5/27/2023 12:42:28'!
test01inicializaCorrectamente
	
	|rover|
	rover := Rover conCoordenadas: {0@0} yEnDireccion: 'N'.
	
	self assert: ( rover enCoordenadas = {0@0}).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'd 5/28/2023 12:56:34'!
test02ElComandoIngresadoEsVacio

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: ''.

	self assert: rover enCoordenadas equals: 0@0
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:14'!
test03SeMueveHaciaAdelanteAputandoAlNorte
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'f'.

	self assert: rover enCoordenadas equals: 0@1.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:39'!
test04SeMueveHaciaAtrasAputandoAlNorte
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'b'.

	self assert: rover enCoordenadas equals: 0@-1.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:18'!
test05SeMueveHaciaLaIzquierdaApuntandoAlNorte

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'l'.

	self assert: rover enDireccion equals: 'O'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:28'!
test06SeMueveHaciaLaDerechaApuntandoAlNorte

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'r'.

	self assert: rover enDireccion equals: 'E'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:32'!
test07SeMueveHaciaAdelanteAputandoAlSur
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'S'.

	rover comandoIngresado: 'f'.

	self assert: rover enCoordenadas equals: 0@-1.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:21'!
test08SeMueveHaciaAtrasAputandoAlSur
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'S'.

	rover comandoIngresado: 'b'.

	self assert: rover enCoordenadas equals: 0@1.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:35'!
test09SeMueveHaciaLaIzquierdaApuntandoAlSur

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'S'.

	rover comandoIngresado: 'l'.

	self assert: rover enDireccion equals: 'E'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:49'!
test10SeMueveHaciaLaDerechaApuntandoAlSur

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'S'.

	rover comandoIngresado: 'r'.

	self assert: rover enDireccion equals: 'O'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:44'!
test11SeMueveHaciaAdelanteAputandoAlEste
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'E'.

	rover comandoIngresado: 'f'.

	self assert: rover enCoordenadas equals: 1@0.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:25'!
test12SeMueveHaciaAtrasAputandoAlEste
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'E'.

	rover comandoIngresado: 'b'.

	self assert: rover enCoordenadas equals: -1@0.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:44:55'!
test13SeMueveHaciaLaIzquierdaApuntandoAlEste

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'E'.

	rover comandoIngresado: 'l'.

	self assert: rover enDireccion equals: 'N'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:45:00'!
test14SeMueveHaciaLaDerechaApuntandoAlEste

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'E'.

	rover comandoIngresado: 'r'.

	self assert: rover enDireccion equals: 'S'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:43:32'!
test15SeMueveHaciaAdelanteAputandoAlOeste
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'O'.

	rover comandoIngresado: 'f'.

	self assert: rover enCoordenadas equals: -1@0.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:43:47'!
test16SeMueveHaciaAtrasAputandoAlOeste
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'O'.

	rover comandoIngresado: 'b'.

	self assert: rover enCoordenadas equals: 1@0.
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:45:52'!
test17SeMueveHaciaLaIzquierdaApuntandoAlOeste

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'O'.

	rover comandoIngresado: 'l'.

	self assert: rover enDireccion equals: 'S'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:46:00'!
test18SeMueveHaciaLaDerechaApuntandoAlOeste

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'O'.

	rover comandoIngresado: 'r'.

	self assert: rover enDireccion equals: 'N'
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:46:14'!
test19SeMueveVariasVecesHaciaAdelante

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'ffff'.

	self assert: rover enCoordenadas equals: 0@4
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:46:22'!
test20ErrorAlIngresarUnComandoInvalido

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	self should: [rover comandoIngresado: 'h']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Rover errorComandoErroneo].

	self assert: rover enCoordenadas equals: 0@0
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:50:58'!
test21ErrorAlIngresarUnComandoValidoYDespuesUnoInvalido

	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	self should: [rover comandoIngresado: 'fmfff']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Rover errorComandoErroneo].

	self assert: rover enCoordenadas equals: 0@1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'd 5/30/2023 15:50:32'!
test22EmpiezaEnOtraDireccionYSeMueve
	|rover |
	rover := Rover conCoordenadas: 2@3 yEnDireccion: 'S'.

	rover comandoIngresado: 'ff'.

	self assert: rover enCoordenadas equals: 2@1
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'eeee 5/30/2023 10:51:11'!
test23EmpiezaEnOtraPosicionYSeMueve
	|rover |
	rover := Rover conCoordenadas: 4@3 yEnDireccion: 'N'.

	rover comandoIngresado: 'ff'.

	self assert: rover enCoordenadas equals: 4@5
	! !

!MarsRoverTest methodsFor: 'testing' stamp: 'd 5/30/2023 15:50:39'!
test24RealizaVariosMovimientos
	|rover |
	rover := Rover conCoordenadas: 0@0 yEnDireccion: 'N'.

	rover comandoIngresado: 'fbllffflf'.

	self assert: rover enCoordenadas equals: 1@-3
	! !
!classDefinition: #Direccion category: 'MarsRover-Model'!
Object subclass: #Direccion
	instanceVariableNames: 'direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Direccion methodsFor: 'accessing' stamp: 's 5/28/2023 12:00:26'!
signo
	self subclassResponsibility .! !


!Direccion methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:41:20'!
realizarAccion: unComando
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direccion class' category: 'MarsRover-Model'!
Direccion class
	instanceVariableNames: ''!

!Direccion class methodsFor: 'class initialization' stamp: 'd 5/28/2023 11:32:11'!
conSentido: unPuntoCardinal
	|subclaseCorrecta|
	subclaseCorrecta := Direccion subclasses detect: [:unaSubclase |unaSubclase esCorrecta: unPuntoCardinal].
	^subclaseCorrecta new.
! !

!Direccion class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:34:03'!
esCorrecta: unPuntoCardinal
	self subclassResponsibility! !


!classDefinition: #Este category: 'MarsRover-Model'!
Direccion subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Este methodsFor: 'accessing' stamp: 's 5/28/2023 12:00:49'!
signo
	^'E'! !


!Este methodsFor: 'movimiento' stamp: 's 5/28/2023 11:56:04'!
realizarAccion: unComando
	^(Movimientos conComando: unComando) realizarAccionHaciaEste.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: 'MarsRover-Model'!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:34:29'!
esCorrecta: unPuntoCardinal
	^unPuntoCardinal = 'E'! !


!classDefinition: #Norte category: 'MarsRover-Model'!
Direccion subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Norte methodsFor: 'accessing' stamp: 's 5/28/2023 12:01:07'!
signo
	^'N'! !


!Norte methodsFor: 'movimiento' stamp: 's 5/28/2023 11:55:23'!
realizarAccion: unComando
	^(Movimientos conComando: unComando) realizarAccionHaciaNorte.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: 'MarsRover-Model'!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:34:37'!
esCorrecta: unPuntoCardinal
	^unPuntoCardinal = 'N'! !


!classDefinition: #Oeste category: 'MarsRover-Model'!
Direccion subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Oeste methodsFor: 'accessing' stamp: 's 5/28/2023 12:01:18'!
signo
	^'O'! !


!Oeste methodsFor: 'movimiento' stamp: 's 5/28/2023 11:56:31'!
realizarAccion: unComando
	^(Movimientos conComando: unComando) realizarAccionHaciaOeste.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: 'MarsRover-Model'!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:34:44'!
esCorrecta: unPuntoCardinal
	^unPuntoCardinal = 'O'! !


!classDefinition: #Sur category: 'MarsRover-Model'!
Direccion subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Sur methodsFor: 'accessing' stamp: 's 5/28/2023 12:01:27'!
signo
	^'S'! !


!Sur methodsFor: 'movimiento' stamp: 's 5/28/2023 11:56:19'!
realizarAccion: unComando
	^(Movimientos conComando: unComando) realizarAccionHaciaSur.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: 'MarsRover-Model'!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:34:53'!
esCorrecta: unPuntoCardinal
	^unPuntoCardinal = 'S'! !


!classDefinition: #Movimientos category: 'MarsRover-Model'!
Object subclass: #Movimientos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Movimientos methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:33:19'!
realizarAccionHaciaEste
	self subclassResponsibility ! !

!Movimientos methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:33:17'!
realizarAccionHaciaNorte
	self subclassResponsibility ! !

!Movimientos methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:33:23'!
realizarAccionHaciaOeste
	self subclassResponsibility ! !

!Movimientos methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:33:14'!
realizarAccionHaciaSur
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Movimientos class' category: 'MarsRover-Model'!
Movimientos class
	instanceVariableNames: ''!

!Movimientos class methodsFor: 'class initialization' stamp: 's 5/28/2023 12:13:13'!
conComando: unComando
	|subclaseCorrecta|
	subclaseCorrecta := Movimientos subclasses detect: [:unaSubclase |unaSubclase esCorrecto: unComando].
	^subclaseCorrecta new.
	! !

!Movimientos class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:59:29'!
esCorrecto: unComando
	self subclassResponsibility ! !


!classDefinition: #Adelante category: 'MarsRover-Model'!
Movimientos subclass: #Adelante
	instanceVariableNames: 'comando'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Adelante methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:34:05'!
realizarAccionHaciaEste
	^1@0
		! !

!Adelante methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:35:31'!
realizarAccionHaciaNorte
	^0@1! !

!Adelante methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:36:43'!
realizarAccionHaciaOeste
	^-1@0! !

!Adelante methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:37:54'!
realizarAccionHaciaSur
	^0@-1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Adelante class' category: 'MarsRover-Model'!
Adelante class
	instanceVariableNames: ''!

!Adelante class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:59:46'!
esCorrecto: unComando
	^unComando = $f! !


!classDefinition: #Atras category: 'MarsRover-Model'!
Movimientos subclass: #Atras
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Atras methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:34:27'!
realizarAccionHaciaEste
	^-1@0! !

!Atras methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:35:46'!
realizarAccionHaciaNorte
	^0@-1! !

!Atras methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:37:04'!
realizarAccionHaciaOeste
	^1@0! !

!Atras methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:38:07'!
realizarAccionHaciaSur
	^0@1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Atras class' category: 'MarsRover-Model'!
Atras class
	instanceVariableNames: ''!

!Atras class methodsFor: 'class initialization' stamp: 'd 5/27/2023 16:59:57'!
esCorrecto: unComando
	^unComando = $b! !


!classDefinition: #GiroDerecha category: 'MarsRover-Model'!
Movimientos subclass: #GiroDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!GiroDerecha methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:34:47'!
realizarAccionHaciaEste
	^'S'! !

!GiroDerecha methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:35:56'!
realizarAccionHaciaNorte
	^'E'! !

!GiroDerecha methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:37:13'!
realizarAccionHaciaOeste
	^'N'! !

!GiroDerecha methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:38:17'!
realizarAccionHaciaSur
	^'O'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GiroDerecha class' category: 'MarsRover-Model'!
GiroDerecha class
	instanceVariableNames: ''!

!GiroDerecha class methodsFor: 'class initialization' stamp: 'd 5/27/2023 17:00:04'!
esCorrecto: unComando
	^unComando = $r! !


!classDefinition: #GiroIzquierda category: 'MarsRover-Model'!
Movimientos subclass: #GiroIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!GiroIzquierda methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:34:59'!
realizarAccionHaciaEste
	^'N'! !

!GiroIzquierda methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:36:08'!
realizarAccionHaciaNorte
	^ 'O'! !

!GiroIzquierda methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:37:22'!
realizarAccionHaciaOeste
	^'S'! !

!GiroIzquierda methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:38:27'!
realizarAccionHaciaSur
	^'E'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GiroIzquierda class' category: 'MarsRover-Model'!
GiroIzquierda class
	instanceVariableNames: ''!

!GiroIzquierda class methodsFor: 'class initialization' stamp: 'd 5/27/2023 17:00:09'!
esCorrecto: unComando
	^unComando = $l! !


!classDefinition: #Rover category: 'MarsRover-Model'!
Object subclass: #Rover
	instanceVariableNames: 'direccion posicion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Model'!

!Rover methodsFor: 'initialization' stamp: 'd 5/27/2023 16:44:59'!
initializeConCoordenadas: unasCoordenadas yEnDireccion: unPuntoCardinal 
	posicion := unasCoordenadas.
	direccion := Direccion conSentido: unPuntoCardinal.! !


!Rover methodsFor: 'evaluating' stamp: 'd 5/28/2023 12:55:16'!
comandoIngresado: stringComandos 
	|movimiento|
	1 to: stringComandos size do:[:idx | |caracterTemporal|
		
		caracterTemporal := stringComandos at: idx.
		('fblr' includes: caracterTemporal ) ifFalse: [^Rover error: Rover errorComandoErroneo ].
		movimiento := (direccion realizarAccion: caracterTemporal).
			(caracterTemporal = $f or: caracterTemporal  = $b) ifTrue: [self cambiarPosicion: movimiento ]
													 ifFalse: [self cambiarDireccion: movimiento].
		].
	! !


!Rover methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:47:52'!
cambiarDireccion: unPuntoCardinal
	direccion := Direccion conSentido: unPuntoCardinal! !

!Rover methodsFor: 'movimiento' stamp: 'd 5/28/2023 11:30:48'!
cambiarPosicion: unaPosicion
	^posicion := posicion + unaPosicion.! !


!Rover methodsFor: 'posicion' stamp: 'jpcw 5/27/2023 12:35:46'!
enCoordenadas
	
	^posicion ! !

!Rover methodsFor: 'posicion' stamp: 's 5/28/2023 12:02:29'!
enDireccion
	
	^direccion signo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rover class' category: 'MarsRover-Model'!
Rover class
	instanceVariableNames: ''!

!Rover class methodsFor: 'initialization' stamp: 'jpcw 5/27/2023 12:33:08'!
conCoordenadas: unasCoordenadas yEnDireccion: unaDireccion 
	
	^self new initializeConCoordenadas: unasCoordenadas yEnDireccion: unaDireccion.! !


!Rover class methodsFor: 'error' stamp: 'd 5/28/2023 12:50:41'!
errorComandoErroneo
	^'El comando ingresado es erroneo'.! !
