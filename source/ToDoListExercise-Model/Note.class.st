Class {
	#name : #Note,
	#superclass : #Object,
	#instVars : [
		'description',
		'category',
		'endingDate',
		'state',
		'assignedEmployee'
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

	endingDate
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

{ #category : #accessing }
Note >> assignedEmployee [

	^ assignedEmployee
]

{ #category : #modifying }
Note >> beFinished [

	assignedEmployee
		withContentDo: [ state := 'finished' ]
		ifUnused:
			[ AssertionFailed signal: 'Cant modify state of note to ''finished'' because it does not have an employee assigned' ]
]

{ #category : #modifying }
Note >> beInProgress [

	assignedEmployee
		withContentDo: [ state := 'in progress' ]
		ifUnused:
			[ AssertionFailed signal: 'Cant modify state of note to ''in progress'' because it does not have an employee assigned' ]
]

{ #category : #modifying }
Note >> beOpen [

	state := 'open'
]

{ #category : #accessing }
Note >> category [

	^ category
]

{ #category : #accessing }
Note >> description [

	^ description
]

{ #category : #accessing }
Note >> endingDate [

	^ endingDate
]

{ #category : #initialization }
Note >> initializeDescribedBy: aDescription optionallyCategorizedBy: optionalCategory optionallyEndingIn: optionalEndingDate optionallyAssignedTo: optionalAssignedEmployee [

	description := aDescription.
	category := optionalCategory.
	endingDate := optionalEndingDate.
	state := 'open'.
	assignedEmployee := optionalAssignedEmployee
]

{ #category : #modifying }
Note >> modifyEndingDateTo: aDate [

	endingDate := Optional containing: aDate
]

{ #category : #modifying }
Note >> reassignTo: anEmployee [

	self assertStateIsNotInProgressNorFinishedFor: 'reassign'.
	assignedEmployee := Optional containing: anEmployee
]

{ #category : #accessing }
Note >> state [

	^ state
]
