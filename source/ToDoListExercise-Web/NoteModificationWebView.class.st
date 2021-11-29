Class {
	#name : #NoteModificationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'acceptButton',
		'cancelButton',
		'noteWebView',
		'note',
		'noteToUpdate',
		'stateDropdown'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NoteModificationWebView class >> displayedIn: aWorkingContext changing: aNote [

	^ self new initializeDisplayedIn: aWorkingContext changing: aNote
]

{ #category : #initialization }
NoteModificationWebView >> configureInteractions [

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				updateNote: note with: noteWebView model;
				setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView.

	cancelButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: ( NotesWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NoteModificationWebView >> initializeAcceptButton [

	acceptButton := self componentSupplier
		asynchronicButtonLabeled: 'Accept'
		applying: [ :theButton |  ]
]

{ #category : #initialization }
NoteModificationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteModificationWebView >> initializeDisplayedIn: aWorkingContext changing: aNote [

	workingContext := aWorkingContext.
	note := aNote.

	self
		initializeNoteWebView;
		initializeStateDropdown;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteModificationWebView >> initializeNoteWebView [

	noteWebView := NoteWebView displayedIn: workingContext.
	noteWebView updateModelWith: note
]

{ #category : #initialization }
NoteModificationWebView >> initializeStateDropdown [

	stateDropdown := self componentSupplier dropdownListApplying: [ :dropdown |  ].
	stateDropdown allowAnyOf: #('Open' 'In progress' 'Finished').
	
	stateDropdown choose: note description.

	stateDropdown on trigger serializeIt
]

{ #category : #initialization }
NoteModificationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: noteWebView;
		render: stateDropdown;
		render: acceptButton;
		render: cancelButton
]