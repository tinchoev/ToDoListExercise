Class {
	#name : #NoteBuilerTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithCategoryAndEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		category: 'aCategory';
		endingDate: 'aDate';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithCategoryAndWithoutEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		category: 'aCategory';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndWithEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		endingDate: 'aDate';
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]
