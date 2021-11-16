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

	assignedEmployee := UsedOptional containing: anEmployee
]

{ #category : #creation }
NoteBuilder >> build [

	^ Note newFrom: self
]

{ #category : #modifying }
NoteBuilder >> categorizedBy: aCategory [

	category := UsedOptional containing: aCategory
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

	endingDate := UsedOptional containing: anEndingDate
]

{ #category : #initialization }
NoteBuilder >> initializeDescribedBy: aDescription [

	description := aDescription.
	category := UnusedOptional explainedByAll: 'Category not assigned yet'.
	assignedEmployee := UnusedOptional explainedByAll: 'Employee not assigned yet'.
	endingDate := UnusedOptional explainedByAll: 'Ending date not assigned yet'
]
