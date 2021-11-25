Class {
	#name : #NoteTest,
	#superclass : #TestCase,
	#instVars : [
		'employeesRepo',
		'noteWithDescription',
		'mickey'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
NoteTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	mickey := Employee named: 'Mickey'.
	employeesRepo := EmployeesRepository new
		addEmployee: mickey;
		yourself.
	noteWithDescription := NoteBuilder describedBy: 'aDescription'
]

{ #category : #tests }
NoteTest >> testCantCreateNoteWithoutDescription [

	self
		should: [ Note newFrom: ( NoteBuilder describedBy: '' ) build ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteTest >> testCantModifyStateOfNoteFromOpenIfItDoesNotHaveAnEmployeeAssigned [

	| note |

	note := noteWithDescription build.
	self assert: note state equals: 'open'.
	self
		should: [ note beInProgress ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''in progress'' because it does not have an employee assigned'.
	self
		should: [ note beFinished ]
		raise: AssertionFailed
		withMessageText: 'Cant modify state of note to ''finished'' because it does not have an employee assigned'
]

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	note beFinished.
	self
		should: [ note reassignTo: ( Employee named: 'Goofy' ) ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is finished'
]

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	note beInProgress.
	self
		should: [ note reassignTo: ( Employee named: 'Goofy' ) ]
		raise: AssertionFailed
		withMessageText: 'Cant reassign note because it is in progress'
]

{ #category : #tests }
NoteTest >> testCreateNoteWithAllItsAttributes [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				categorizedBy: 'aCategory';
				endingIn: January first , 2022;
				assignedTo: mickey from: employeesRepo;
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Mickey' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				categorizedBy: 'aCategory';
				endingIn: January first , 2022;
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ self fail ]
		ifUnused: [ :explanations | self assert: explanations equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategory [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				endingIn: January first , 2022;
				assignedTo: mickey from: employeesRepo;
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Mickey' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				endingIn: January first , 2022;
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ self fail ]
		ifUnused: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndEndingDate [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				assignedTo: mickey from: employeesRepo;
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Mickey' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	| aNote |

	aNote := Note newFrom: noteWithDescription build.
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ self fail ]
		ifUnused: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutEndingDate [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				categorizedBy: 'aCategory';
				assignedTo: mickey from: employeesRepo;
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Mickey' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( noteWithDescription
				categorizedBy: 'aCategory';
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ self fail ]
		ifUnused: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testModifyEndingDate [

	| note |

	note := noteWithDescription
		endingIn: January first , 2022;
		build.

	note endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	note modifyEndingDateTo: January second , 2022.
	note endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January second , 2022 ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testModifyStateFromFinishedToInProgress [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beFinished.
	self assert: note state equals: 'finished'.
	note beInProgress.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NoteTest >> testModifyStateFromFinishedToOpen [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beFinished.
	self assert: note state equals: 'finished'.
	note beInProgress.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NoteTest >> testModifyStateFromInProgressToFinished [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beInProgress.
	self assert: note state equals: 'in progress'.
	note beFinished.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
NoteTest >> testModifyStateFromInProgressToOpen [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beInProgress.
	self assert: note state equals: 'in progress'.
	note beOpen.
	self assert: note state equals: 'open'
]

{ #category : #tests }
NoteTest >> testModifyStateFromOpenToFinished [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beFinished.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
NoteTest >> testModifyStateFromOpenToInProgress [

	| note |

	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	self assert: note state equals: 'open'.
	note beInProgress.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NoteTest >> testReassignToAnotherEmployee [

	| note martin |

	martin := Employee named: 'Martin'.
	employeesRepo addEmployee: martin.
	note := noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Mickey' ]
		ifUnused: [ self fail ].
	note reassignTo: martin.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee name equals: 'Martin' ]
		ifUnused: [ self fail ]
]
