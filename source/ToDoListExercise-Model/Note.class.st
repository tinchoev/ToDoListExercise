Class {
	#name : #Note,
	#superclass : #Object,
	#instVars : [
		'description',
		'category',
		'endingDate',
		'state',
		'assignedEmployee',
		'builder'
	],
	#classInstVars : [
		'description',
		'endingDate',
		'asignedEmployee'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #construction }
Note class >> described: aDescription asignedTo: anEmployee [ 
	^ self new initializeDescribed: aDescription asignedTo: anEmployee .
]

{ #category : #accesing }
Note >> assignedEmployee [
	^ assignedEmployee
]

{ #category : #accessing }
Note >> builder [
	^ builder
]

{ #category : #accessing }
Note >> category [
	^ category
]

{ #category : #accessing }
Note >> endingDate [
	^ endingDate
]

{ #category : #initialization }
Note >> initializeDescribed: aDescription asignedTo: anEmployee [ 
	description := aDescription .
	assignedEmployee := anEmployee .
	state := 'open' .
	builder := NoteBuilder with: self.
]

{ #category : #modifying }
Note >> modifyEndingDateTo: aDate [ 
	endingDate := aDate
]

{ #category : #modifying }
Note >> modifyState [
	(state = 'open') ifTrue: [ state := 'in progress' ] ifFalse: [ (state = 'in progress') ifTrue: [ state := 'finished' ] ]
]

{ #category : #modifying }
Note >> reassignTo: anEmployee [  
	self verifyStateIsOpen .
	assignedEmployee := anEmployee
]

{ #category : #accessing }
Note >> state [
	^ state
]

{ #category : #asserting }
Note >> verifyStateIsOpen [
	(state = 'open') 
		ifFalse: [ (state = 'in progress') 
			ifTrue: [ AssertionFailed signal: 'Action failed because the note is in progress' ] 
			ifFalse: [ AssertionFailed signal: 'Action failed because the note is finished' ] ]
]
