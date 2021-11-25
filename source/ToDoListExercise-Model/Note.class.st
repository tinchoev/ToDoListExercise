Class {
	#name : #Note,
	#superclass : #Object,
	#instVars : [
		'description',
		'state',
		'categoryOptional',
		'endingDateOptional',
		'assignedEmployeeOptional'
	],
	#classInstVars : [
		'description',
		'endingDate',
		'asignedEmployee'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #'instance creation' }
Note class >> describedBy: aDescription optionallyCategorizedBy: optionalCategory optionallyEndingIn: optionalEndingDate optionallyAssignedTo: optionalAssignedEmployee [

	^ self new
		initializeDescribedBy: aDescription
		optionallyCategorizedBy: optionalCategory
		optionallyEndingIn: optionalEndingDate
		optionallyAssignedTo: optionalAssignedEmployee
]

{ #category : #asserting }
Note >> assertNoteDoesntHaveAnEndingDate [

	endingDateOptional
		withContentDo: [ AssertionFailed signal: 'Cant remove the note because it has an ending date' ]
		ifUnused: [  ]
]

{ #category : #asserting }
Note >> assertStateIsNot: aState for: aMethod [

	state = aState
		ifTrue: [ AssertionFailed signal: ( 'Cant <1s> note because it is <2s>' expandMacrosWith: aMethod with: aState ) ]
]

{ #category : #asserting }
Note >> assertStateIsNotInProgressNorFinishedFor: aMethod [

	self
		assertStateIsNot: 'in progress' for: aMethod;
		assertStateIsNot: 'finished' for: aMethod
]

{ #category : #modifying }
Note >> beFinished [

	assignedEmployeeOptional
		withContentDo: [ state := 'finished' ]
		ifUnused:
			[ AssertionFailed signal: 'Cant modify state of note to ''finished'' because it does not have an employee assigned' ]
]

{ #category : #modifying }
Note >> beInProgress [

	assignedEmployeeOptional
		withContentDo: [ state := 'in progress' ]
		ifUnused:
			[ AssertionFailed signal: 'Cant modify state of note to ''in progress'' because it does not have an employee assigned' ]
]

{ #category : #modifying }
Note >> beOpen [

	state := 'open'
]

{ #category : #accessing }
Note >> description [

	^ description
]

{ #category : #initialization }
Note >> initializeDescribedBy: aDescription optionallyCategorizedBy: optionalCategory optionallyEndingIn: optionalEndingDate optionallyAssignedTo: optionalAssignedEmployee [

	description := aDescription.
	categoryOptional := optionalCategory.
	endingDateOptional := optionalEndingDate.
	state := 'open'.
	assignedEmployeeOptional := optionalAssignedEmployee
]

{ #category : #modifying }
Note >> modifyEndingDateTo: aDate [

	endingDateOptional := Optional containing: aDate
]

{ #category : #modifying }
Note >> reassignTo: anEmployee [

	self assertStateIsNotInProgressNorFinishedFor: 'reassign'.
	assignedEmployeeOptional := Optional containing: anEmployee
]

{ #category : #accessing }
Note >> state [

	^ state
]

{ #category : #modifying }
Note >> withAssignedEmployeeDo: aBlock ifUnassigned: anotherBlock [

	^ assignedEmployeeOptional withContentDo: aBlock ifUnused: anotherBlock
]

{ #category : #modifying }
Note >> withCategoryDo: aBlock ifUncategorized: anotherBlock [

	^ categoryOptional withContentDo: aBlock ifUnused: anotherBlock
]

{ #category : #modifying }
Note >> withEndingDateDo: aBlock ifNone: anotherBlock [

	^ endingDateOptional withContentDo: aBlock ifUnused: anotherBlock
]
