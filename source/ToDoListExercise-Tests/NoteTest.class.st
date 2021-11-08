Class {
	#name : #NoteTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [
	| note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	note modifyState .
	note modifyState .
	self should: [note reassignTo: 'Lucas']
	raise: AssertionFailed
	withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [
	| note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	note modifyState .
	self should: [note reassignTo: 'Lucas']
	raise: AssertionFailed
	withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
NoteTest >> testCreateNoteWithCategoryAndEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' categorized: 'aCategory' endingAt: 'aDate' asignedTo: 'anEmployee'.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithCategoryAndWithoutEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' categorized: 'aCategory' endingAt: nil asignedTo: 'anEmployee'.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' categorized: nil endingAt: nil asignedTo: 'anEmployee'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndWithEndingDate [
	| aNote |
	aNote := Note described: 'aDescription' categorized: nil endingAt: 'anEndingDate' asignedTo: 'anEmployee'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteTest >> testModifyEndingDate [
	| note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asDate asignedTo: 'Martin' .
	self assert: note endingDate equals: '01-01-2022' asDate .
	note modifyEndingDateTo: '02-02-2022' asDate .
	self assert: note endingDate equals: '02-02-2022' asDate
]

{ #category : #tests }
NoteTest >> testReassignToAnotherEmployee [
	| note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	self assert: note assignedEmployee equals: 'Martin' .
	note reassignTo: 'Lucas'.
	self assert: note assignedEmployee equals: 'Lucas'
]

{ #category : #tests }
NoteTest >> testState [
	| note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asDate asignedTo: 'Martin' .
	self assert: note state equals: 'open' .
	note modifyState.
	self assert: note state equals: 'in progress' .
	note modifyState.
	self assert: note state equals: 'finished'
]
