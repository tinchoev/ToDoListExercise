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

{ #category : #accessing }
Note >> assignedEmployee [

	^ assignedEmployee
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

	endingDate := aDate
]

{ #category : #modifying }
Note >> modifyState [

	assignedEmployee
		ifNil: [ AssertionFailed signal: 'Action failed because the note does not have an employee assigned' ].
	state = 'open'
		ifTrue: [ state := 'in progress' ]
		ifFalse: [ state = 'in progress'
				ifTrue: [ state := 'finished' ]
			]
]

{ #category : #modifying }
Note >> reassignTo: anEmployee [

	self verifyStateIsOpen.
	assignedEmployee := anEmployee
]

{ #category : #accessing }
Note >> state [

	^ state
]

{ #category : #asserting }
Note >> verifyItDoesNotHaveAnEndingDate [

	endingDate
		ifNotNil: [ AssertionFailed signal: 'Action failed because the note has an ending date' ]
]

{ #category : #asserting }
Note >> verifyStateIsOpen [

	state = 'open'
		ifFalse: [ state = 'in progress'
				ifTrue: [ AssertionFailed signal: 'Action failed because the note is in progress' ]
				ifFalse: [ AssertionFailed signal: 'Action failed because the note is finished' ]
			]
]
