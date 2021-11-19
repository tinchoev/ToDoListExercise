Class {
	#name : #EmployeeRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'nameField',
		'workingContext',
		'acceptButton'
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
		enable: acceptButton.

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				addEmployee: nameField model;
				setCurrentWebViewTo: ( EmployeesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView
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

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #rendering }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: nameField;
		render: acceptButton
]
