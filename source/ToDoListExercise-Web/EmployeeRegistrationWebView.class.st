Class {
	#name : #EmployeeRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'nameField',
		'registrationButton',
		'workingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
EmployeeRegistrationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
EmployeeRegistrationWebView >> configureInteractions [

	nameField on trigger
		serializeIt;
		enable: registrationButton.

	registrationButton on trigger
		disable;
		serverDo: [ workingContext updateEmployees: nameField model ];
		setValueTo: [ '' ] thenTriggerChangeOf: nameField
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeNameField;
		initializeRegistrationButton;
		configureInteractions
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeNameField [

	nameField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the employee''s name' ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Create employee'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #rendering }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	aCanvas
		render: nameField;
		render: registrationButton
]
