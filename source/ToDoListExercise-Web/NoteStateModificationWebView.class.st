Class {
	#name : #NoteStateModificationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionDropdown',
		'stateDropdown',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteStateModificationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteStateModificationWebView >> configureInteractions [

	descriptionDropdown on trigger
		serializeIt;
		enable: acceptButton.

	stateDropdown on trigger serializeIt.

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				modifyStateOf: descriptionDropdown currentSelection
					to: ( stateDropdown currentSelectionIfNone: [  ] );
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteStateModificationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
NoteStateModificationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteStateModificationWebView >> initializeDescriptionDropdown [

	descriptionDropdown := self componentSupplier dropdownListApplying: [ :dropdown |  ].
	descriptionDropdown allowAnyOf: ( workingContext notes collect: [ :note | note description ] )
]

{ #category : #initialization }
NoteStateModificationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeDescriptionDropdown;
		initializeStateDropdown;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteStateModificationWebView >> initializeStateDropdown [

	stateDropdown := self componentSupplier dropdownListApplying: [ :dropdown | ].
	stateDropdown allowAnyOf: #('Open' 'In progress' 'Finished')
]

{ #category : #rendering }
NoteStateModificationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionDropdown;
		render: stateDropdown;
		render: acceptButton;
		render: cancelButton
]
