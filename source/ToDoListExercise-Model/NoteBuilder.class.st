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

	self assertDescriptionIsNotEmpty: aDescription.
	^ self new initializeDescribedBy: aDescription
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee [

	^ assignedEmployee
]

{ #category : #modifying }
NoteBuilder >> assignedTo: anEmployee [

	assignedEmployee := Optional containing: anEmployee
]

{ #category : #creation }
NoteBuilder >> build [

	^ Note newFrom: self
]

{ #category : #modifying }
NoteBuilder >> categorizedBy: aCategory [

	category := Optional containing: aCategory
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

	endingDate := Optional containing: anEndingDate
]

{ #category : #initialization }
NoteBuilder >> initializeDescribedBy: aDescription [

	description := aDescription.
	category := Optional unusedBecauseAll: 'Category not assigned yet'.
	assignedEmployee := Optional unusedBecauseAll: 'Employee not assigned yet'.
	endingDate := Optional unusedBecauseAll: 'Ending date not assigned yet'
]
