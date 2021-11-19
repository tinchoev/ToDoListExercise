Class {
	#name : #ToDoListExerciseSession,
	#superclass : #WillowSession,
	#instVars : [
		'applicationContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #Controlling }
ToDoListExerciseSession >> applicationContext [

	^ applicationContext
]

{ #category : #Controlling }
ToDoListExerciseSession >> startUpApplicationContextFor: aWillowApplication [

	super startUpApplicationContextFor: aWillowApplication.
	applicationContext := ToDoListExerciseApplicationContext new
]
