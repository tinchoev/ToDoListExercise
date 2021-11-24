Class {
	#name : #NoteRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'endingDateField',
		'descriptionField',
		'categoryField',
		'assignedEmployeeDropdown',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#classInstVars : [
		'aWorkingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteRegistrationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteRegistrationWebView >> configureInteractions [

	| aNoteBuilder |

	descriptionField on trigger
		serverDo: [ aNoteBuilder := NoteBuilder describedBy: descriptionField model ];
		enable: acceptButton;
		enable: categoryField;
		enable: endingDateField.
	categoryField on trigger serverDo: [ aNoteBuilder categorizedBy: categoryField model ].
	endingDateField on trigger
		serverDo: [ aNoteBuilder endingIn: ( Date fromString: endingDateField contents ) ].
	assignedEmployeeDropdown on trigger
		serverDo: [ aNoteBuilder
				assignedTo: ( assignedEmployeeDropdown currentSelectionIfNone: [  ] )
				from: workingContext employeesRepository
			].

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				addNote: aNoteBuilder build;
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeAssignedEmployeeDropdown [

	assignedEmployeeDropdown := ( self componentSupplier dropdownListApplying: [ :dropdown |  ] )
		allowAnyOf: workingContext employees;
		yourself
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeCategoryField [

	categoryField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | (theField setPlaceholderTo: 'Write the category') + theField beDisabled ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeDescriptionField [

	descriptionField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the description' ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeDescriptionField;
		initializeCategoryField;
		initializeEndingDateField;
		initializeAssignedEmployeeDropdown;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeEndingDateField [

	endingDateField := self componentSupplier dateFieldApplying: [ :theField | theField beDisabled ]".
	endingDateField on change serializeIt"
]

{ #category : #rendering }
NoteRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionField;
		render: categoryField;
		render: endingDateField;
		render: assignedEmployeeDropdown;
		render: acceptButton;
		render: cancelButton
]
