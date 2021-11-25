Class {
	#name : #NotesRepository,
	#superclass : #Object,
	#instVars : [
		'notes'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #modifying }
NotesRepository >> addNote: aNote [

	notes add: aNote
]

{ #category : #asserting }
NotesRepository >> assertIsAdded: aNote for: anAction [

	( notes includes: aNote )
		ifFalse: [ AssertionFailed signal: ( 'Cant <1s> because the note isnt added' expandMacrosWith: anAction ) ]
]

{ #category : #modifying }
NotesRepository >> beFinished: aNote [

	self assertIsAdded: aNote for: 'modify state to ''finished'''.
	aNote beFinished
]

{ #category : #modifying }
NotesRepository >> beInProgress: aNote [

	self assertIsAdded: aNote for: 'modify state to ''in progress'''.
	aNote beInProgress
]

{ #category : #modifying }
NotesRepository >> beOpen: aNote [

	aNote beOpen
]

{ #category : #initialization }
NotesRepository >> initialize [

	notes := OrderedCollection new
]

{ #category : #modifying }
NotesRepository >> modifyEndingDateOf: aNote to: aDate [

	self assertIsAdded: aNote for: 'modify ending date'.
	aNote modifyEndingDateTo: aDate
]

{ #category : #accessing }
NotesRepository >> notes [

	^ notes
]

{ #category : #modifying }
NotesRepository >> reassign: aNote to: anEmployee from: anEmployeesRepo [

	self assertIsAdded: aNote for: 'reassign to another employee'.
	anEmployeesRepo assertIsAdded: anEmployee for: 'reassign note'.
	aNote reassignTo: anEmployee
]

{ #category : #modifying }
NotesRepository >> remove: aNote [

	self assertIsAdded: aNote for: 'remove note'.
	aNote
		assertStateIsNotInProgressNorFinishedFor: 'remove';
		assertNoteDoesntHaveAnEndingDate.
	notes remove: aNote
]
