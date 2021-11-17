Class {
	#name : #CompanyTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
CompanyTest >> testAddEmployee [

	| company |

	company := Company new.
	self assert: company employeesSize equals: 0.
	company addEmployee: 'Martin'.
	self assert: company employeesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testAddNote [

	| company |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	self assert: company notesSize equals: 0.
	company addNote: ( NoteBuilder describedBy: 'aDescription' ) build.
	self assert: company notesSize equals: 1
]

{ #category : #tests }
CompanyTest >> testCantModifyStateOfNoteFromOpenIfItDoesNotHaveAnEmployeeAssigned [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' ) build.
	company addNote: note.
	self assert: note state equals: 'open'.
	self
		should: [ company beInProgress: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''in progress'' because it does not have an employee assigned'.
	self
		should: [ company beFinished: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''finished'' because it does not have an employee assigned'
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [

	| company note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	company := Company new.
	company addNote: note.
	company beFinished: note.
	self
		should: [ company reassign: note to: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
CompanyTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [

	| company note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	company := Company new.
	company addNote: note.
	company beInProgress: note.
	self
		should: [ company reassign: note to: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsFinished [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	company beFinished: note.
	self
		should: [ company remove: note ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsHasEndingDate [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: '01-01-2022' asDate;
		build.
	company addNote: note.
	self
		should: [ company remove: note ]
		raise: AssertionFailed
		withMessageText: 'Cant remove the note because it has an ending date'
]

{ #category : #tests }
CompanyTest >> testCantRemoveNoteBecauseItIsInProgress [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	company beInProgress: note.
	self
		should: [ company remove: note ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
CompanyTest >> testModifyEndingDateOfNote [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: '01-01-2022' asDate;
		build.
	company addNote: note.
	note endingDate
		withContentDo: [ :aDate | self assert: aDate equals: '01-01-2022' asDate ]
		ifUnused: [ self fail ].
	company modifyEndingDateOf: note To: '02-02-2022' asDate.
	note endingDate
		withContentDo: [ :aDate | self assert: aDate equals: '02-02-2022' asDate ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
CompanyTest >> testModifyStateFromFinishedToInProgress [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beFinished: note.
	self assert: note state equals: 'finished'.
	company beInProgress: note.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
CompanyTest >> testModifyStateFromFinishedToOpen [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beFinished: note.
	self assert: note state equals: 'finished'.
	company beOpen: note.
	self assert: note state equals: 'open'
]

{ #category : #tests }
CompanyTest >> testModifyStateFromInProgressToFinished [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beInProgress: note.
	self assert: note state equals: 'in progress'.
	company beFinished: note.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
CompanyTest >> testModifyStateFromInProgressToOpen [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beInProgress: note.
	self assert: note state equals: 'in progress'.
	company beOpen: note.
	self assert: note state equals: 'open'
]

{ #category : #tests }
CompanyTest >> testModifyStateFromOpenToFinished [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beFinished: note.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
CompanyTest >> testModifyStateFromOpenToInProgress [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	self assert: note state equals: 'open'.
	company beInProgress: note.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
CompanyTest >> testReassignANoteToAnotherEmployee [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		addEmployee: 'Lucas';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	company addNote: note.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'Martin' ]
		ifUnused: [ self fail ].
	note reassignTo: 'Lucas'.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'Lucas' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
CompanyTest >> testRemoveNote [

	| company note |

	company := Company new
		addEmployee: 'Martin';
		yourself.
	note := ( NoteBuilder describedBy: 'aDescription' ) build.
	company addNote: note.
	self assert: company notesSize equals: 1.
	company remove: note.
	self assert: company notesSize equals: 0
]
