Class {
	#name : #Company,
	#superclass : #Object,
	#instVars : [
		'employees',
		'notes'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #modifying }
Company >> addEmployee: anEmployee [

	employees add: anEmployee
]

{ #category : #modifying }
Company >> addNote: aNote [

	notes add: aNote
]

{ #category : #asserting }
Company >> assertEmployeeIsLoaded: anEmployee for: anAction [

	( employees includes: anEmployee )
		ifFalse: [ AssertionFailed signal: ( 'Cant <1s> because the employee isnt loaded' expandMacrosWith: anAction ) ]
]

{ #category : #asserting }
Company >> assertNoteIsLoaded: aNote for: anAction [

	( notes includes: aNote )
		ifFalse: [ AssertionFailed signal: ( 'Cant <1s> because the note isnt loaded' expandMacrosWith: anAction ) ]
]

{ #category : #modifying }
Company >> beFinished: aNote [

	self assertNoteIsLoaded: aNote for: 'modify state to ''finished'''.
	aNote beFinished
]

{ #category : #modifying }
Company >> beInProgress: aNote [

	self assertNoteIsLoaded: aNote for: 'modify state to ''in progress'''.
	aNote beInProgress
]

{ #category : #modifying }
Company >> beOpen: aNote [

	aNote beOpen
]

{ #category : #accessing }
Company >> employees [

	^ employees
]

{ #category : #accessing }
Company >> employeesSize [

	^ employees size
]

{ #category : #initialization }
Company >> initialize [

	employees := OrderedCollection new.
	notes := OrderedCollection new
]

{ #category : #modifying }
Company >> modifyEndingDateOf: aNote To: aDate [

	self assertNoteIsLoaded: aNote for: 'modify ending date'.
	aNote modifyEndingDateTo: aDate
]

{ #category : #accessing }
Company >> notesSize [

	^ notes size
]

{ #category : #modifying }
Company >> reassign: aNote to: anEmployee [

	self assertNoteIsLoaded: aNote for: 'reassign to another employee'.
	self assertEmployeeIsLoaded: anEmployee for: 'reassign note'.
	aNote reassignTo: anEmployee
]

{ #category : #modifying }
Company >> remove: aNote [

	self assertNoteIsLoaded: aNote for: 'remove note'.
	aNote
		assertStateIsNotInProgressNorFinishedFor: 'remove';
		assertNoteDoesntHaveAnEndingDate.
	notes remove: aNote
]
