Class {
	#name : #NotesRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'notesRepo',
		'noteWithDescription',
		'employeesRepo',
		'martin'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
NotesRepositoryTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	notesRepo := NotesRepository new.
	martin := Employee named: 'Martin'.
	employeesRepo := EmployeesRepository new
		addEmployee: martin;
		yourself.
	noteWithDescription := NoteBuilder new describedBy: 'aDescription'
]

{ #category : #tests }
NotesRepositoryTest >> testAddNote [

	| repo note |

	repo := NotesRepository new.
	note := noteWithDescription build.
	self assert: repo notes isEmpty.
	repo addNote: note.
	self assert: ( repo notes includes: note )
]

{ #category : #tests }
NotesRepositoryTest >> testCantModifyEndingDateOfANoteThatIsntLoaded [

	self
		should: [ notesRepo
				modifyEndingDateOf:
					( noteWithDescription
						endingIn: January first , 2022;
						build )
				to: January second , 2022
			]
		raise: AssertionFailed
		withMessageText: 'Cant modify ending date because the note isnt added'
]

{ #category : #tests }
NotesRepositoryTest >> testCantModifyStateOfNoteFromOpenIfItDoesNotHaveAnEmployeeAssigned [

	| note |

	note := noteWithDescription build.
	notesRepo addNote: note.
	self
		should: [ notesRepo beInProgress: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''in progress'' because it does not have an employee assigned'.
	self
		should: [ notesRepo beFinished: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''finished'' because it does not have an employee assigned'
]

{ #category : #tests }
NotesRepositoryTest >> testCantModifyStateOfNoteThatIsntLoaded [

	| note |

	note := noteWithDescription build.
	self
		should: [ notesRepo beInProgress: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state to ''in progress'' because the note isnt added'.
	self
		should: [ notesRepo beFinished: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state to ''finished'' because the note isnt added'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignANoteThatIsntLoaded [

	self
		should: [ notesRepo reassign: noteWithDescription build to: martin from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign to another employee because the note isnt added'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteBecauseItIsFinished [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beFinished: note.
	self
		should: [ notesRepo reassign: note to: martin from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is finished'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteBecauseItIsInProgress [

	| note mickey |

	mickey := Employee named: 'Mickey'.
	employeesRepo addEmployee: mickey.
	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beInProgress: note.
	self
		should: [ notesRepo reassign: note to: martin from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteToAnEmployeeThatIsntLoaded [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	self
		should: [ notesRepo reassign: note to: ( Employee named: 'Goofy' ) from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because the employee isnt added'
]

{ #category : #tests }
NotesRepositoryTest >> testCantRemoveANoteThatIsntLoaded [

	self
		should: [ notesRepo remove: noteWithDescription build ]
		raise: AssertionFailed
		withMessageText: 'Cant remove note because the note isnt added'
]

{ #category : #tests }
NotesRepositoryTest >> testCantRemoveNoteBecauseItHasEndingDate [

	| note |

	note := noteWithDescription
		endingIn: January first , 2022;
		build.
	notesRepo addNote: note.
	self
		should: [ notesRepo remove: note ]
		raise: AssertionFailed
		withMessageText: 'Cant remove the note because it has an ending date'
]

{ #category : #tests }
NotesRepositoryTest >> testCantRemoveNoteBecauseItIsFinished [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beFinished: note.
	self
		should: [ notesRepo remove: note ]
		raise: AssertionFailed
		withMessageText: 'Cant remove note because it is finished'
]

{ #category : #tests }
NotesRepositoryTest >> testCantRemoveNoteBecauseItIsInProgress [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beInProgress: note.
	self
		should: [ notesRepo remove: note ]
		raise: AssertionFailed
		withMessageText: 'Cant remove note because it is in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyEndingDateOfNote [

	| note |

	note := noteWithDescription
		endingIn: January first , 2022;
		build.
	notesRepo addNote: note.
	notesRepo modifyEndingDateOf: note to: January second , 2022.
	note
		withEndingDateDo: [ :aDate | self assert: aDate equals: January second , 2022 ]
		ifNone: [ self fail ]
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromFinishedToInProgress [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beFinished: note.
	self assert: note state equals: 'finished'.
	notesRepo beInProgress: note.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromFinishedToOpen [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beFinished: note.
	self assert: note state equals: 'finished'.
	notesRepo beOpen: note.
	self assert: note state equals: 'open'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromInProgressToFinished [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beInProgress: note.
	self assert: note state equals: 'in progress'.
	notesRepo beFinished: note.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromInProgressToOpen [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beInProgress: note.
	self assert: note state equals: 'in progress'.
	notesRepo beOpen: note.
	self assert: note state equals: 'open'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromOpenToFinished [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	self assert: note state equals: 'open'.
	notesRepo beFinished: note.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromOpenToInProgress [

	| note |

	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	self assert: note state equals: 'open'.
	notesRepo beInProgress: note.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testReassignANoteToAnotherEmployee [

	| note goku |

	goku := Employee named: 'Goku'.
	employeesRepo addEmployee: goku.
	note := noteWithDescription
		assignedTo: martin from: employeesRepo;
		build.
	notesRepo addNote: note.
	note
		reassignTo: goku;
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Goku' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NotesRepositoryTest >> testRemoveNote [

	| note |

	note := noteWithDescription build.
	notesRepo addNote: note.
	self assert: ( notesRepo notes includes: note ).
	notesRepo remove: note.
	self deny: ( notesRepo notes includes: note )
]
