Class {
	#name : #NoteWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'noteBinding',
		'endingDateField',
		'descriptionField',
		'categoryField',
		'assignedEmployeeDropdown',
		'model',
		'stateDropdown'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NoteWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #configuration }
NoteWebView >> configureInteractions [

	descriptionField on trigger
		serverDo: [ model describedBy: descriptionField model ];
		enable: categoryField;
		enable: endingDateField.
	categoryField on trigger serverDo: [ model categorizedBy: categoryField model ].
	endingDateField on trigger
		serverDo: [ model endingIn: ( Date fromString: endingDateField contents ) ].
	assignedEmployeeDropdown on trigger
		serverDo: [ assignedEmployeeDropdown
				withCurrentSelectionDo: [ :anEmployee | model assignedTo: anEmployee from: workingContext employeesRepository ]
			]
]

{ #category : #initialization }
NoteWebView >> initializeAssignedEmployeeDropdown [

	assignedEmployeeDropdown := ( self componentSupplier dropdownListApplying: [ :dropdown |  ] )
		allowAnyOf: workingContext employees;
		yourself
]

{ #category : #initialization }
NoteWebView >> initializeCategoryField [

	categoryField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the category' ]
]

{ #category : #initialization }
NoteWebView >> initializeDescriptionField [

	descriptionField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the description' ]
]

{ #category : #initialization }
NoteWebView >> initializeDisplayedIn: aWorkingContext [

	model := NoteBuilder new.
	workingContext := aWorkingContext.
	noteBinding := Binding undefinedExplainedBy: 'Note not configured yet'.
	self initializeDescriptionField
		initializeCategoryField;
		initializeEndingDateField;
		initializeAssignedEmployeeDropdown;
		configureInteractions
]

{ #category : #initialization }
NoteWebView >> initializeEndingDateField [

	endingDateField := self componentSupplier dateFieldApplying: [ :theField |  ]
]

{ #category : #initialization }
NoteWebView >> model [

	model describedBy: descriptionField model.
	model categorizedBy: categoryField model.
	model endingIn: ( Date fromString: endingDateField contents ).
	assignedEmployeeDropdown
		withCurrentSelectionDo:
			[ :anEmployee | model assignedTo: anEmployee from: workingContext employeesRepository ].

	^ model build
]

{ #category : #rendering }
NoteWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionField;
		render: categoryField;
		render: endingDateField;
		render: assignedEmployeeDropdown
]

{ #category : #configuration }
NoteWebView >> updateModelWith: aNote [

	descriptionField
		changeModelTo: aNote description.
	aNote withCategoryDo: [ :aCategory | categoryField changeModelTo: aCategory ] ifUncategorized: [  ].
	aNote withEndingDateDo: [ :aDate | endingDateField changeModelTo: aDate ] ifNone: [  ].
	aNote
		withAssignedEmployeeDo: [ :anEmployee | assignedEmployeeDropdown choose: anEmployee ]
		ifUnassigned: [  ]
]
