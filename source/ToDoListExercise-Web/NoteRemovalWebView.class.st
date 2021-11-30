Class {
	#name : #NoteRemovalWebView,
	#superclass : #WAPainter,
	#instVars : [
		'descriptionDropdown',
		'workingContext',
		'acceptButton',
		'cancelButton',
		'note'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NoteRemovalWebView class >> displayedIn: aWorkingContext removing: aNote [

	^ self new initializeDisplayedIn: aWorkingContext removing: aNote
]

{ #category : #initialization }
NoteRemovalWebView >> configureInteractions [

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				remove: note;
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
		applying: [ :theButton |  ]
]

{ #category : #initialization }
NoteRemovalWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
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

{ #category : #initialization }
NoteRemovalWebView >> initializeDisplayedIn: aWorkingContext removing: aNote [

	note := aNote.
	workingContext := aWorkingContext.
	self
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #rendering }
NoteRemovalWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			( HeadingWebView
				displaying: 'You are about to delete a note. Continue?'
				withLevel: 4
				applying: [ :heading |  ] );
		render: acceptButton;
		render: cancelButton
]
