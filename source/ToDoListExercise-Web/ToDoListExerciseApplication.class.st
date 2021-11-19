Class {
	#name : #ToDoListExerciseApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'company',
		'employeeRegistrationWebView',
		'noteRegistrationWebView',
		'noteWebView',
		'employeeWebView',
		'employeesRepository'
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

{ #category : #initialization }
ToDoListExerciseApplication >> configureInteractions [

]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ [ :canvas | 
	canvas
		heading: 'Welcome to the To Do List Exercise!';
		render: noteRegistrationWebView;
		render: noteWebView;
		render: employeeRegistrationWebView;
		render: employeeWebView 
	]
]

{ #category : #accessing }
ToDoListExerciseApplication >> employeeWebView [

	^ employeeWebView
]

{ #category : #initialization }
ToDoListExerciseApplication >> initialRequest: request [

	super initialRequest: request.
	self initializeViews.
	employeesRepository := EmployeesRepository new.
	self configureInteractions
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeViews [

	employeeWebView := EmployeeWebView new.
	noteWebView := NoteWebView new.
	employeeRegistrationWebView := EmployeeRegistrationWebView displayedIn: self.
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

{ #category : #rendering }
ToDoListExerciseApplication >> updateEmployees: employees [

	employeeWebView changeEmployeesTo: employees
]
