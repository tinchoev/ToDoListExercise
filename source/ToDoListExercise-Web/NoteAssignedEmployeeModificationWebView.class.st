Class {
	#name : #NoteAssignedEmployeeModificationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionDropdown',
		'employeeDropdown',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteAssignedEmployeeModificationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> configureInteractions [

	descriptionDropdown on trigger
		serializeIt;
		enable: employeeDropdown.

	employeeDropdown on trigger
		serializeIt;
		enable: acceptButton.

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				reassign: descriptionDropdown currentSelection to: employeeDropdown currentSelection;
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> initializeDescriptionDropdown [

	descriptionDropdown := self componentSupplier dropdownListApplying: [ :dropdown |  ].
	descriptionDropdown allowAnyOf: ( workingContext notes collect: [ :note | note description ] )
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeDescriptionDropdown;
		initializeEmployeeDropdown;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteAssignedEmployeeModificationWebView >> initializeEmployeeDropdown [

	| options |

	options := OrderedCollection with: nil.
	workingContext employees do: [ :employee | options add: employee ].
	employeeDropdown := self componentSupplier
		dropdownListApplying: [ :dropdown | dropdown beDisabled ].
	employeeDropdown allowAnyOf: options
]

{ #category : #rendering }
NoteAssignedEmployeeModificationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionDropdown;
		render: employeeDropdown;
		render: acceptButton;
		render: cancelButton
]
