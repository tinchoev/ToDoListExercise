Class {
	#name : #EmployeeRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'nameField',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
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
				addEmployee: ( Employee named: nameField model );
				setCurrentWebViewTo: ( EmployeesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( EmployeesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeNameField;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
EmployeeRegistrationWebView >> initializeNameField [

	nameField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the employee''s name' ]
]

{ #category : #rendering }
EmployeeRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: nameField;
		render: acceptButton;
		render: cancelButton
]
