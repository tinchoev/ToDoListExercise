Class {
	#name : #NoteModificationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'acceptButton',
		'cancelButton',
		'noteWebView',
		'note',
		'noteToUpdate'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NoteModificationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
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
NoteModificationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.

	self
		initializeNoteWebView;
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #initialization }
NoteModificationWebView >> initializeNoteWebView [

	noteWebView := NoteWebView displayedIn: workingContext.
	noteWebView updateModelWith: noteToUpdate
]

{ #category : #initialization }
NoteModificationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: noteWebView;
		render: acceptButton;
		render: cancelButton
]
