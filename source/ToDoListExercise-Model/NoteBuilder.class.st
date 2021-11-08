Class {
	#name : #NoteBuilder,
	#superclass : #Object,
	#instVars : [
		'note'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #accessing }
NoteBuilder >> build [
	^ note
]

{ #category : #modifying }
NoteBuilder >> category: aCategory [ 
	note category: aCategory .
	^ self
]

{ #category : #creation }
NoteBuilder >> createNoteDescribed: aString asignedTo: aString2 [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
NoteBuilder >> initialize [
	note := Note new.
]
