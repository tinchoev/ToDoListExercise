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

{ #category : #asserting }
NoteBuilder class >> assertDescriptionIsNotEmpty: aDescription [

	aDescription isEmpty
		ifTrue: [ AssertionFailed signal: 'Note couldnt be created because it didnt have description' ]
]

{ #category : #constructor }
NoteBuilder class >> describedBy: aDescription [

	self assertDescriptionIsNotEmpty: aDescription .
	^ self new initializeDescribedBy: aDescription
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee [

	^ assignedEmployee
]

{ #category : #modifying }
NoteBuilder >> assignedTo: anEmployee [

	assignedEmployee := anEmployee
]

{ #category : #creation }
NoteBuilder >> build [

	^ Note newFrom: self
]

{ #category : #modifying }
NoteBuilder >> categorizedBy: aCategory [

	category := aCategory.
	^ self
]

{ #category : #accessing }
NoteBuilder >> category [

	^ category
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
NoteBuilder >> endingIn: anEndingDate [

	endingDate := anEndingDate.
	^ self
]

{ #category : #initialization }
NoteBuilder >> initializeDescribedBy: aDescription [

	description := aDescription
]
