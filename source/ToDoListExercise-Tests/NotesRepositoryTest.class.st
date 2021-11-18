Class {
	#name : #NotesRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'notesRepo',
		'noteWithDescription',
		'employeesRepo'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
NotesRepositoryTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	notesRepo := NotesRepository new.
	employeesRepo := EmployeesRepository new
		addEmployee: 'Martin';
		yourself.
	noteWithDescription := NoteBuilder describedBy: 'aDescription'
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
		withMessageText: 'Cant modify ending date because the note isnt loaded'
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
		withMessageText: 'Cant modify state to ''in progress'' because the note isnt loaded'.
	self
		should: [ notesRepo beFinished: note ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state to ''finished'' because the note isnt loaded'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignANoteThatIsntLoaded [

	self
		should: [ notesRepo reassign: noteWithDescription build to: 'Martin' from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign to another employee because the note isnt loaded'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteBecauseItIsFinished [

	| note |

	note := noteWithDescription
		assignedTo: 'Martin' from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beFinished: note.
	self
		should: [ notesRepo reassign: note to: 'Martin' from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is finished'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteBecauseItIsInProgress [

	| note |

	employeesRepo addEmployee: 'Mickey'.
	note := noteWithDescription
		assignedTo: 'Mickey' from: employeesRepo;
		build.
	notesRepo addNote: note.
	notesRepo beInProgress: note.
	self
		should: [ notesRepo reassign: note to: 'Martin' from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testCantReassignNoteToAnEmployeeThatIsntLoaded [

	| note |

	note := noteWithDescription
		assignedTo: 'Martin' from: employeesRepo;
		build.
	notesRepo addNote: note.
	self
		should: [ notesRepo reassign: note to: 'Goofy' from: employeesRepo ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because the employee isnt loaded'
]

{ #category : #tests }
NotesRepositoryTest >> testCantRemoveANoteThatIsntLoaded [

	self
		should: [ notesRepo remove: noteWithDescription build ]
		raise: AssertionFailed
		withMessageText: 'Cant remove note because the note isnt loaded'
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
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
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
	note endingDate
		withContentDo: [ :aDate | self assert: aDate equals: January second , 2022 ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NotesRepositoryTest >> testModifyStateFromFinishedToInProgress [

	| note |

	note := noteWithDescription
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
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
		assignedTo: 'Martin' from: employeesRepo;
		build.
	notesRepo addNote: note.
	self assert: note state equals: 'open'.
	notesRepo beInProgress: note.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NotesRepositoryTest >> testReassignANoteToAnotherEmployee [

	| note |

	employeesRepo addEmployee: 'Goku'.
	note := noteWithDescription
		assignedTo: 'Martin' from: employeesRepo;
		build.
	notesRepo addNote: note.
	note reassignTo: 'Goku'.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'Goku' ]
		ifUnused: [ self fail ]
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
