Class {
	#name : #NoteBuilder,
	#superclass : #Object,
	#instVars : [
		'description',
		'optionalCategory',
		'optionalEndingDate',
		'optionalAssignedEmployee'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #asserting }
NoteBuilder class >> assertDescriptionIsNotEmpty: aDescription [

	aDescription isEmpty
		ifTrue: [ AssertionFailed signal: 'Note couldnt be created because it didnt have description' ]
]

{ #category : #'instance creation' }
NoteBuilder class >> describedBy: aDescription [

	self assertDescriptionIsNotEmpty: aDescription.
	^ self new initializeDescribedBy: aDescription
]

{ #category : #accessing }
NoteBuilder >> assignedEmployee [

	^ optionalAssignedEmployee
]

{ #category : #modifying }
NoteBuilder >> assignedTo: anEmployee from: anEmployeesRepository [

	anEmployeesRepository assertIsAdded: anEmployee for: 'create note'.
	optionalAssignedEmployee := Optional containing: anEmployee
]

{ #category : #creation }
NoteBuilder >> build [

	^ Note
		describedBy: description
		optionallyCategorizedBy: optionalCategory
		optionallyEndingIn: optionalEndingDate
		optionallyAssignedTo: optionalAssignedEmployee
]

{ #category : #modifying }
NoteBuilder >> categorizedBy: aCategory [

	optionalCategory := Optional containing: aCategory
]

{ #category : #accessing }
NoteBuilder >> category [

	^ optionalCategory
]

{ #category : #accessing }
NoteBuilder >> description [

	^ description
]

{ #category : #accessing }
NoteBuilder >> endingDate [

	^ optionalEndingDate
]

{ #category : #modifying }
NoteBuilder >> endingIn: anEndingDate [

	optionalEndingDate := Optional containing: anEndingDate
]

{ #category : #initialization }
NoteBuilder >> initializeDescribedBy: aDescription [

	description := aDescription.
	optionalCategory := Optional unusedBecauseAll: 'Category not assigned yet'.
	optionalAssignedEmployee := Optional unusedBecauseAll: 'Employee not assigned yet'.
	optionalEndingDate := Optional unusedBecauseAll: 'Ending date not assigned yet'
]
