Class {
	#name : #NoteCreator,
	#superclass : #WAPainter,
	#instVars : [
		'description'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteCreator class >> describedBy: aDescription [
	^ self new initializeDescribedBy: aDescription
]

{ #category : #initialization }
NoteCreator >> initializeDescribedBy: aDescription [
	description := aDescription 
]

{ #category : #rendering }
NoteCreator >> renderContentOn: aCanvas [
	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."
	
	aCanvas listItem: description
]
