Class {
	#name : #NoteBuilderTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteBuilderTest >> testCantCreateNoteWithoutDescription [

	self
		should: [ NoteBuilder describedBy: '' ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithAllItsAttributes [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		assignedTo: 'anEmployee';
		build.
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutAssignedEmployee [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		build.
	aNote category
		withContentDo: [ :category | self assert: category equals: 'aCategory' ]
		ifUnused: [ self fail ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ self fail ]
		ifUnused: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategory [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: January first , 2022;
		assignedTo: 'anEmployee';
		build.
	aNote category
		withContentDo: [ self fail ]
		ifUnused: [ :category | self assert: category equals: 'Category not assigned yet' ].
	aNote endingDate
		withContentDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
		ifUnused: [ self fail ].
	aNote assignedEmployee
		withContentDo: [ :employee | self assert: employee equals: 'anEmployee' ]
		ifUnused: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: January first , 2022;
		build.
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
NoteBuilderTest >> testCreateNoteWithoutCategoryAndEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		assignedTo: 'anEmployee';
		build.
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
NoteBuilderTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' ) build.
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
NoteBuilderTest >> testCreateNoteWithoutEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		assignedTo: 'anEmployee';
		build.
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
NoteBuilderTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		build.
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
