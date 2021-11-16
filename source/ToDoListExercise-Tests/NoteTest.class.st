Class {
	#name : #NoteTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteTest >> testCantReassignNoteToAnotherEmployeeBecauseItIsFinished [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
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

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		endingIn: 'aDate';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithCategoryAndWithoutEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' ) build.
	self assert: aNote description equals: 'aDescription'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndWithEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: 'aDate';
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteTest >> testModifyEndingDate [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: '01-01-2022' asDate;
		build.
	self assert: note endingDate equals: '01-01-2022' asDate.
	note modifyEndingDateTo: '02-02-2022' asDate.
	self assert: note endingDate equals: '02-02-2022' asDate
]

{ #category : #tests }
NoteTest >> testReassignToAnotherEmployee [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Martin';
		build.
	self assert: note assignedEmployee equals: 'Martin'.
	note reassignTo: 'Lucas'.
	self assert: note assignedEmployee equals: 'Lucas'
]

{ #category : #tests }
NoteTest >> testState [

	| note |

	note := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'Mickey';
		build.
	self assert: note state equals: 'open'.
	note modifyState.
	self assert: note state equals: 'in progress'.
	note modifyState.
	self assert: note state equals: 'finished'
]
