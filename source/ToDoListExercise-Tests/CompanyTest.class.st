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
	company addEmployee: 'Martín'.
	self assert: company employeesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testAddNote [
	| company |
	company := Company new addEmployee: 'Martín'; yourself.
	self assert: company notesSize equals: 0.
	company addNote: (Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martín').
	self assert: company notesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [
	| company note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	company := Company new .
	company addNote: note .
	company modifyStateOf: note .
	company modifyStateOf: note .
	self should: [company reassign: note to: 'Lucas']
	raise: AssertionFailed
	withMessageText: 'Cant reassing note because it is finished'
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [
	| company note |
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	company := Company new .
	company addNote: note .
	company modifyStateOf: note .
	self should: [company reassign: note to: 'Lucas']
	raise: AssertionFailed
	withMessageText: 'Cant reassing note because it is in progress'
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsFinished [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
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
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
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
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asDate asignedTo: 'Martin' .
	company addNote: note.
	self assert: note endingDate equals: '01-01-2022' asDate .
	company modifyEndingDateOf: note To: '02-02-2022' asDate .
	self assert: note endingDate equals: '02-02-2022' asDate
]

{ #category : #tests }
CompanyTest >> testModifyStateOfNote [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asDate asignedTo: 'Martin' .
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
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	company addNote: note.
	self assert: note assignedEmployee equals: 'Martin' .
	company reassign: note to: 'Lucas'.
	self assert: note assignedEmployee equals: 'Lucas'
	
]

{ #category : #tests }
CompanyTest >> testRemoveNote [
	| company note |
	company := Company new addEmployee: 'Martin'; yourself.
	note := Note described: 'aDescription' categorized: 'aCategory' endingAt: '01-01-2022' asignedTo: 'Martin' .
	company addNote: note.
	self assert: company notesSize equals: 1 .
	company remove: note .
	self assert: company notesSize equals: 0
]
