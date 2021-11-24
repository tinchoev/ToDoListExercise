Class {
	#name : #NoteEndingDateModificationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionDropdown',
		'endingDateField',
		'workingContext',
		'acceptButton',
		'cancelButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteEndingDateModificationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> configureInteractions [

	descriptionDropdown on trigger
		serializeIt;
		enable: endingDateField.

	endingDateField on trigger
		serializeIt;
		enable: acceptButton.

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				modifyEndingDateOf: descriptionDropdown currentSelection
					to: ( Date fromString: endingDateField contents );
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> initializeDescriptionDropdown [

	descriptionDropdown := self componentSupplier dropdownListApplying: [ :dropdown |  ].
	descriptionDropdown allowAnyOf: ( workingContext notes collect: [ :note | note description ] )
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeDescriptionDropdown;
		initializeEndingDateField;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> initializeEndingDateField [

	endingDateField := self componentSupplier dateFieldApplying: [ :theField | theField beDisabled ]
]

{ #category : #initialization }
NoteEndingDateModificationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: descriptionDropdown;
		render: endingDateField;
		render: acceptButton;
		render: cancelButton
]
