Class {
	#name : #NoteTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteTest >> testCantCreateNoteWithoutDescription [

	self
		should: [ Note newFrom: ( NoteBuilder describedBy: '' ) ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteTest >> testCantModifyStateOfNoteFromOpenIfItDoesNotHaveAnEmployeeAssigned [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' ) build.
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	note beFinished.
	self
		should: [ note reassignTo: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is finished'
]

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsInProgress [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	note beInProgress.
	self
		should: [ note reassignTo: 'Goofy' ]
		raise: AssertionFailed
		withMessageText: 'Action failed because the note is in progress'
]

{ #category : #tests }
NoteTest >> testCreateNoteWithAllItsAttributes [

	| aNote |

	aNote := Note
		newFrom:
			( ( NoteBuilder describedBy: 'aDescription' )
				categorizedBy: 'aCategory';
				endingIn: 'aDate';
				assignedTo: 'anEmployee';
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: 'aDate' ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( ( NoteBuilder describedBy: 'aDescription' )
				categorizedBy: 'aCategory';
				endingIn: 'aDate';
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: 'aDate' ]
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
			( ( NoteBuilder describedBy: 'aDescription' )
				endingIn: 'aDate';
				assignedTo: 'anEmployee';
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: 'aDate' ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( ( NoteBuilder describedBy: 'aDescription' )
				endingIn: 'aDate';
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: 'aDate' ]
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
			( ( NoteBuilder describedBy: 'aDescription' )
				assignedTo: 'anEmployee';
				build ).
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	| aNote |

	aNote := Note newFrom: ( NoteBuilder describedBy: 'aDescription' ) build.
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
			( ( NoteBuilder describedBy: 'aDescription' )
				categorizedBy: 'aCategory';
				assignedTo: 'anEmployee';
				build ).
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ self fail ]
		ifUnused: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	| aNote |

	aNote := Note
		newFrom:
			( ( NoteBuilder describedBy: 'aDescription' )
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: '01-01-2022' asDate;
		build.

	note endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: '01-01-2022' asDate ]
		ifUnused: [ self fail ].
	note modifyEndingDateTo: '02-02-2022' asDate.
	note endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: '02-02-2022' asDate ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteTest >> testModifyStateFromFinishedToInProgress [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	self assert: note state equals: 'open'.
	note beFinished.
	self assert: note state equals: 'finished'
]

{ #category : #tests }
NoteTest >> testModifyStateFromOpenToInProgress [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	self assert: note state equals: 'open'.
	note beInProgress.
	self assert: note state equals: 'in progress'
]

{ #category : #tests }
NoteTest >> testReassignToAnotherEmployee [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'Martin' ]
		ifUnused: [ self fail ].
	note reassignTo: 'Lucas'.
	note assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'Lucas' ]
		ifUnused: [ self fail ]
]
