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

	^ 'toDoListExercise'
]

{ #category : #accessing }
ToDoListExerciseApplication class >> sessionClass [

	^ ToDoListExerciseSession
]

{ #category : #'private utility' }
ToDoListExerciseApplication class >> start [

	ToDoListExerciseApplication registerAsDevelopmentApplication.
	( ZnZincServerAdaptor port: 8080 )
		codec: ( GRCodec forEncoding: 'utf8' );
		start
]

{ #category : #'private utility' }
ToDoListExerciseApplication class >> stop [

	ZnServer stopDefault.
	ZnZincServerAdaptor allInstancesDo: [ :each | each shutDown ].
	ToDoListExerciseApplication unregisterFromApplications.
	Smalltalk garbageCollect
]

{ #category : #accessing }
ToDoListExerciseApplication >> componentSupplierForApplication [

	^ Bootstrap3ComponentSupplier online
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ self session applicationContext mainWebView
]

{ #category : #initialization }
ToDoListExerciseApplication >> initialRequest: request [

	super initialRequest: request
]

{ #category : #accessing }
ToDoListExerciseApplication >> jQueryLibrary [

	^ JQuery3OnlineLibrary default
]
