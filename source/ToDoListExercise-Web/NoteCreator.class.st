Class {
	#name : #NoteCreator,
	#superclass : #WAPainter,
	#instVars : [
		'note'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteCreator class >> for: aNote [
	^ self new initializeFor: aNote
]

{ #category : #accessing }
NoteCreator >> assignedEmployee [
	^ note assignedEmployee
]

{ #category : #accessing }
NoteCreator >> category [
	^ note category
]

{ #category : #accessing }
NoteCreator >> description [
	^ note description
]

{ #category : #accessing }
NoteCreator >> endingDate [
	^ note endingDate
]

{ #category : #initialization }
NoteCreator >> initializeFor: aNote [
	note := aNote 
]

{ #category : #rendering }
NoteCreator >> renderContentOn: aCanvas [
	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."
	
	aCanvas listItem: note description; listItem: note category
]

{ #category : #accessing }
NoteCreator >> state [
	^ note state
]
