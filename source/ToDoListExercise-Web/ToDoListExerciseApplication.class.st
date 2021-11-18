Class {
	#name : #ToDoListExerciseApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'company',
		'employeeRegistrationWebView',
		'noteRegistrationWebView',
		'noteOutputWebView',
		'employeeOutoutWebView'
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

{ #category : #rendering }
ToDoListExerciseApplication >> configureInteractions [

	
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ [ :canvas | 
	canvas
		heading: 'Welcome to the To Do List Exercise!';
		render: noteRegistrationWebView;
		render: noteOutputWebView;
		render: employeeRegistrationWebView;
		render: employeeOutoutWebView 
	]
]

{ #category : #rendering }
ToDoListExerciseApplication >> initialRequest: request [

	super initialRequest: request.
	self initializeViews.
	company := NotesRepository new.
	self configureInteractions
]

{ #category : #rendering }
ToDoListExerciseApplication >> initializeViews [

	employeeRegistrationWebView := EmployeeRegistrationWebView new.
	employeeOutoutWebView := EmployeeOutputWebView new.
	noteRegistrationWebView := NoteRegistrationWebView new.
	noteOutputWebView := NoteOutputWebView new
]

{ #category : #accessing }
ToDoListExerciseApplication >> jQueryLibrary [

	^ JQuery3OnlineLibrary default
]
