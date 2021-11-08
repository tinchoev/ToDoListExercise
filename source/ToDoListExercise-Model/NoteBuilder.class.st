Class {
	#name : #NoteBuilder,
	#superclass : #Object,
	#instVars : [
		'description',
		'category',
		'endingDate',
		'assignedEmployee'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #constructor }
NoteBuilder class >> described: aDescription asignedTo: anEmployee [ 
	^ self new initializeDescribed: aDescription asignedTo: anEmployee 
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee [
	^ assignedEmployee
]

{ #category : #creation }
NoteBuilder >> build [
	^ Note newFrom: self
]

{ #category : #accessing }
NoteBuilder >> category [
	^ category
]

{ #category : #modifying }
NoteBuilder >> category: aCategory [ 
	category := aCategory .
	^ self
]

{ #category : #accessing }
NoteBuilder >> description [
	^ description
]

{ #category : #accessing }
NoteBuilder >> endingDate [
	^ endingDate
]

{ #category : #modifying }
NoteBuilder >> endingDate: anEndingDate [ 
	endingDate := anEndingDate .
	^ self
]

{ #category : #initialization }
NoteBuilder >> initializeDescribed: aDescription asignedTo: anEmployee [ 
	description := aDescription .
	assignedEmployee := anEmployee
]
