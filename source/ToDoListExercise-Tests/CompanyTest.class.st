Class {
	#name : #CompanyTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
CompanyTest >> testAddEmployee [
	| company |
	company := Company new .
	self assert: company employeesSize equals: 0.
	company addEmployee: 'Martin'.
	self assert: company employeesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testAddNote [
	| company |
	company := Company new addEmployee: 'Martin'; yourself.
	self assert: company notesSize equals: 0.
	company addNote: (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	self assert: company notesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [
	| company note |
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Mickey')
		build.
	company := Company new .
	company addNote: note .
	company modifyStateOf: note .
	company modifyStateOf: note .
	self should: [company reassign: note to: 'Goofy']
	raise: AssertionFailed
	withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [
	| company note |
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Mickey')
		build.
	company := Company new .
	company addNote: note .
	company modifyStateOf: note .
	self should: [company reassign: note to: 'Goofy']
	raise: AssertionFailed
	withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsFinished [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	company addNote: note .
	company modifyStateOf: note .
	company modifyStateOf: note .
	self should: [ company remove: note ]
	raise: AssertionFailed 
	withMessageText: 'Action failed because the note is finished' .
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsInProgress [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	company addNote: note .
	company modifyStateOf: note .
	self should: [ company remove: note ]
	raise: AssertionFailed 
	withMessageText: 'Action failed because the note is in progress' .
]

{ #category : #tests }
CompanyTest >> testModifyEndingDateOfNote [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		endingDate: '01-01-2022' asDate;
		build.
	company addNote: note.
	self assert: note endingDate equals: '01-01-2022' asDate .
	company modifyEndingDateOf: note To: '02-02-2022' asDate .
	self assert: note endingDate equals: '02-02-2022' asDate
]

{ #category : #tests }
CompanyTest >> testModifyStateOfNote [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	company addNote: note.
	self assert: note state equals: 'open' .
	company modifyStateOf: note.
	self assert: note state equals: 'in progress' .
	company modifyStateOf: note.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
CompanyTest >> testReassignANoteToAnotherEmployee [
	| company note |
	company := Company new addEmployee: 'Martin'; addEmployee: 'Lucas'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	company addNote: note.
	self assert: note assignedEmployee equals: 'Martin' .
	company reassign: note to: 'Lucas'.
	self assert: note assignedEmployee equals: 'Lucas'
	
]

{ #category : #tests }
CompanyTest >> testRemoveNote [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := (NoteBuilder
		described: 'aDescription'
		asignedTo: 'Martin')
		build.
	company addNote: note.
	self assert: company notesSize equals: 1 .
	company remove: note .
	self assert: company notesSize equals: 0
]
