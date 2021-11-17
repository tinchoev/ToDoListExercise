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

{ #category : #constructor }
Note class >> newFrom: aBuilder [
	^ self new initializeWith: aBuilder
]

{ #category : #asserting }
Note >> assertNoteDoesntHaveAnEndingDate [

	endingDate
		withContentDo: [ AssertionFailed signal: 'Cant remove the note because it has an ending date' ]
		ifUnused: [  ]
]

{ #category : #asserting }
Note >> assertStateIsOpenFor: aMethod [

	state = 'open'
		ifFalse: [ state = 'in progress'
				ifTrue: [ AssertionFailed signal: ( 'Cant <1s> note because it is in progress' expandMacrosWith: aMethod ) ]
				ifFalse: [ AssertionFailed signal: ( 'Cant <1s> note because it is finished' expandMacrosWith: aMethod ) ]
			]
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
Note >> initializeWith: aBuilder [

	description := aBuilder description.
	category := aBuilder category.
	endingDate := aBuilder endingDate.
	state := 'open'.
	assignedEmployee := aBuilder assignedEmployee
]

{ #category : #modifying }
Note >> modifyEndingDateTo: aDate [

	endingDate := Optional containing: aDate
]

{ #category : #modifying }
Note >> reassignTo: anEmployee [

	self assertStateIsOpenFor: 'reassign'.
	assignedEmployee := Optional containing: anEmployee
]

{ #category : #accessing }
Note >> state [

	^ state
]
