Class {
	#name : #NoteTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [
	| note |
	note := (NoteBuilder described: 'aDescription' asignedTo: 'Mickey')
		build.
	note modifyState.
	note modifyState.
	self
		should: [ note reassignTo: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [
	| note |
	note := (NoteBuilder described: 'aDescription' asignedTo: 'Mickey')
		build.
	note modifyState.
	self
		should: [ note reassignTo: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
NoteTest >> testCreateNoteWithCategoryAndEndingDate [
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
NoteTest >> testCreateNoteWithCategoryAndWithoutEndingDate [
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
NoteTest >> testCreateNoteWithoutCategoryAndEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndWithEndingDate [
	| aNote |
	aNote := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		endingDate: 'aDate';
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteTest >> testModifyEndingDate [
	| note |
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'anEmployee')
		endingDate: '01-01-2022' asDate;
		build.
	self assert: note endingDate equals: '01-01-2022' asDate .
	note modifyEndingDateTo: '02-02-2022' asDate .
	self assert: note endingDate equals: '02-02-2022' asDate
]

{ #category : #tests }
NoteTest >> testReassignToAnotherEmployee [
	| note |
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	self assert: note assignedEmployee equals: 'Martin' .
	note reassignTo: 'Lucas'.
	self assert: note assignedEmployee equals: 'Lucas'
]

{ #category : #tests }
NoteTest >> testState [

	| note |

	note := ( NoteBuilder described: 'aDescription' asignedTo: 'anEmployee' ) build.
	self assert: note state equals: 'open'.
	note modifyState.
	self assert: note state equals: 'in progress'.
	note modifyState.
	self assert: note state equals: 'finished'
]
