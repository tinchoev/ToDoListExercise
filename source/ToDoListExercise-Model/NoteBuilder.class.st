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
NoteBuilder >> assertDescriptionIsNotEmpty [

	AssertionChecker
		refuse: [ description isEmpty | description isNil ]
		because: 'Note couldnt be created because it didnt have description'
		raising: AssertionFailed
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

	self assertDescriptionIsNotEmpty.
	^ Note
		describedBy: description
		optionallyCategorizedBy: optionalCategory
		optionallyEndingIn: optionalEndingDate
		optionallyAssignedTo: optionalAssignedEmployee
]

{ #category : #modifying }
NoteBuilder >> categorizedBy: aCategory [

	aCategory isEmpty
		ifTrue: [ optionalCategory := Optional unusedBecauseAll: 'Category not assigned yet' ]
		ifFalse: [ optionalCategory := Optional containing: aCategory ]
]

{ #category : #accessing }
NoteBuilder >> category [

	^ optionalCategory
]

{ #category : #modifying }
NoteBuilder >> describedBy: aDescription [

	description := aDescription
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
NoteBuilder >> initialize [

	description := ''.
	optionalCategory := Optional unusedBecauseAll: 'Category not assigned yet'.
	optionalAssignedEmployee := Optional unusedBecauseAll: 'Employee not assigned yet'.
	optionalEndingDate := Optional unusedBecauseAll: 'Ending date not assigned yet'
]

{ #category : #modifying }
NoteBuilder >> withAssignedEmployeeDo: aBlock ifUnassigned: anotherBlock [

	^ optionalAssignedEmployee withContentDo: aBlock ifUnused: anotherBlock
]

{ #category : #modifying }
NoteBuilder >> withCategoryDo: aBlock ifUncategorized: anotherBlock [

	^ optionalCategory withContentDo: aBlock ifUnused: anotherBlock
]

{ #category : #modifying }
NoteBuilder >> withEndingDateDo: aBlock ifNone: anotherBlock [

	^ optionalEndingDate withContentDo: aBlock ifUnused: anotherBlock
]
