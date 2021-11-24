Class {
	#name : #NoteRemovalWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionDropdown',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteRemovalWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteRemovalWebView >> configureInteractions [

	descriptionDropdown on trigger
		serializeIt;
		enable: acceptButton.

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				remove: descriptionDropdown currentSelection;
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteRemovalWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
NoteRemovalWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteRemovalWebView >> initializeDescriptionDropdown [

	descriptionDropdown := self componentSupplier dropdownListApplying: [ :dropdown |  ].
	descriptionDropdown allowAnyOf: ( workingContext notes collect: [ :note | note description ] )
]

{ #category : #initialization }
NoteRemovalWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeDescriptionDropdown;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #rendering }
NoteRemovalWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionDropdown;
		render: acceptButton;
		render: cancelButton
]
