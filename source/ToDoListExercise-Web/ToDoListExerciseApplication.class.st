Class {
	#name : #ToDoListExerciseApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'company',
		'noteRegistrationWebView',
		'noteWebView'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #accessing }
ToDoListExerciseApplication class >> applicationTitle [
	
	^ 'To Do List Exercise'
]

{ #category : #accessing }
ToDoListExerciseApplication class >> handlerName [

	^ 'to-do-list-exercise'
]

{ #category : #accessing }
ToDoListExerciseApplication class >> sessionClass [

	^ ToDoListExerciseSession
]

{ #category : #accessing }
ToDoListExerciseApplication class >> start [

	ToDoListExerciseApplication registerAsDevelopmentApplication.
	( ZnZincServerAdaptor port: 8080 )
		codec: ( GRCodec forEncoding: 'utf8' );
		start
]

{ #category : #accessing }
ToDoListExerciseApplication class >> stop [

	ZnServer stopDefault.
	ZnZincServerAdaptor allInstancesDo: [ :each | each shutDown ].
	ToDoListExerciseApplication unregisterFromApplications.
	Smalltalk garbageCollect
]

{ #category : #accessing }
ToDoListExerciseApplication >> componentSupplierForApplication [

	^ Html5ComponentSupplier new
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ self session applicationContext mainWebView
]

{ #category : #initialization }
ToDoListExerciseApplication >> initialRequest: request [

	super initialRequest: request.
	self initializeViews
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeViews [

	noteRegistrationWebView := NoteRegistrationWebView displayedIn: self
]

{ #category : #accessing }
ToDoListExerciseApplication >> jQueryLibrary [

	^ JQuery3OnlineLibrary default
]

{ #category : #rendering }
ToDoListExerciseApplication >> renderNotes: notes [

	noteWebView renderNotes: notes
]
