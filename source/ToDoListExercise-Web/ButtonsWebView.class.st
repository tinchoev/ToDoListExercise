Class {
	#name : #ButtonsWebView,
	#superclass : #WAPainter,
	#instVars : [
		'employeesButton',
		'notesButton',
		'homeButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #accessing }
ButtonsWebView >> buttonLabeled: aLabel [

	^ self componentSupplier
		asynchronicButtonLabeled: aLabel
		applying: [ :theButton | theButton addClass bootstrap3 buttonPrimary ]
]

{ #category : #configuring }
ButtonsWebView >> configureTriggerOf: aButtonWebView toRender: aWebView [

	aButtonWebView on trigger
		serverDo: [ self session applicationContext setCurrentWebViewTo: aWebView ];
		render: self session applicationContext identifiedCurrentWebView
]

{ #category : #configuring }
ButtonsWebView >> configureTriggers [

	self
		configureTriggerOf: homeButton toRender: WelcomeWebView new;
		configureTriggerOf: employeesButton
			toRender: ( EmployeesWebView displayedIn: ( EmployeesContext workingWith: self session applicationContext ) );
		configureTriggerOf: notesButton
			toRender: ( NotesWebView displayedIn: ( NotesContext workingWith: self session applicationContext ) )
]

{ #category : #initialization }
ButtonsWebView >> initialize [

	self initializeButtons
]

{ #category : #initialization }
ButtonsWebView >> initializeButtons [

	homeButton := self buttonLabeled: 'Home'.
	employeesButton := self buttonLabeled: 'Employees'.
	notesButton := self buttonLabeled: 'Notes'
]

{ #category : #rendering }
ButtonsWebView >> renderContentOn: aCanvas [

	"Se configuran los triggers en este momento dado que en el #initialize todavía el contexto no está creado.- ebalsamo"

	self configureTriggers.

	aCanvas
		render: homeButton;
		render: employeesButton;
		render: notesButton
]
