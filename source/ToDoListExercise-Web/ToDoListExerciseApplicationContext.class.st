Class {
	#name : #ToDoListExerciseApplicationContext,
	#superclass : #Object,
	#instVars : [
		'mainWebView',
		'currentWebView',
		'employeesRepository',
		'notesRepository'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #accessing }
ToDoListExerciseApplicationContext >> currentWebView [

	^ currentWebView
]

{ #category : #accessing }
ToDoListExerciseApplicationContext >> employeesRepository [

	^ employeesRepository
]

{ #category : #accessing }
ToDoListExerciseApplicationContext >> identifiedCurrentWebView [

	^ mainWebView identifiedCurrentWebView
]

{ #category : #initialization }
ToDoListExerciseApplicationContext >> initialize [

	super initialize.
	self
		initializeRepositories;
		setCurrentWebViewTo: WelcomeWebView new;
		initializeMainWebView
]

{ #category : #initialization }
ToDoListExerciseApplicationContext >> initializeMainWebView [

	mainWebView := MainWebView new
]

{ #category : #initialization }
ToDoListExerciseApplicationContext >> initializeRepositories [

	employeesRepository := EmployeesRepository new.
	notesRepository := NotesRepository new
]

{ #category : #accessing }
ToDoListExerciseApplicationContext >> mainWebView [

	^ mainWebView
]

{ #category : #accessing }
ToDoListExerciseApplicationContext >> notesRepository [

	^ notesRepository
]

{ #category : #accessing }
ToDoListExerciseApplicationContext >> setCurrentWebViewTo: aCurrentWebView [

	currentWebView := aCurrentWebView
]
