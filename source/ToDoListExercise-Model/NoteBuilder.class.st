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
NoteBuilder class >> described: aDescription [
	^ self new initializeDescribed: aDescription
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee [
	^ assignedEmployee
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee: anEmployee [
	assignedEmployee := anEmployee
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
NoteBuilder >> initializeDescribed: aDescription [ 
	description := aDescription .
	category := '-' .
	endingDate := '-' .
	assignedEmployee := '-'
]
