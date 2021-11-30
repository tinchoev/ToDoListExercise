Class {
	#name : #NoteRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'acceptButton',
		'cancelButton',
		'noteWebView'
	],
	#classInstVars : [
		'aWorkingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NoteRegistrationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteRegistrationWebView >> configureInteractions [

	acceptButton on trigger
		disable;
		serverDo: [ workingContext
				addNote: noteWebView model;
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
		applying: [ :theButton |  ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeCancelButton [

	cancelButton := self componentSupplier
		asynchronicButtonLabeled: 'Cancel'
		applying: [ :theButton | ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	noteWebView := NoteWebView displayedIn: workingContext.
	self
		initializeAcceptButton;
		initializeCancelButton;
		configureInteractions
]

{ #category : #rendering }
NoteRegistrationWebView >> renderContentOn: aCanvas [

	aCanvas
		render: noteWebView;
		render: acceptButton;
		render: cancelButton
]
