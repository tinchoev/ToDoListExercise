Class {
	#name : #EmployeeRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'tasksForEmployees',
		'tasksContainerForEmployees',
		'nameField',
		'registrationButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #initialization }
EmployeeRegistrationWebView >> configureInteractions [

	nameField on trigger
		serializeIt;
		enable: registrationButton.
	registrationButton on trigger
		disable;
		serverDo: [ tasksForEmployees add: ( NoteTask describedBy: nameField model ) ];
		setValueTo: [ '' ] thenTriggerChangeOf: nameField;
		render: tasksContainerForEmployees
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeEmployeeNameField [

	nameField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the employee''s name' ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Create employee'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeTaskContainerForEmployees [

	tasksContainerForEmployees := self componentSupplier
		divisionContainerWrapping: [ :canvas | canvas unorderedList: tasksForEmployees ]
		applying: [  ]
]

{ #category : #rendering }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [
	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."
	
	aCanvas
]
