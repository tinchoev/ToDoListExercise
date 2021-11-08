Class {
	#name : #NoteBuilerTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithCategoryAndWithoutEndingDate [
	| aNote |
	aNote := ((NoteBuilder new createNoteDescribed: 'aDescription' asignedTo: 'anEmployee') category: 'aCategory') build .
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' asignedTo: 'anEmployee'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndWithEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' asignedTo: 'anEmployee'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]
