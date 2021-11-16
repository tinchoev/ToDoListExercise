Class {
	#name : #NoteBuilerTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
NoteBuilerTest >> testCantCreateNoteWithoutDescription [

	self
		should: [ NoteBuilder describedBy: '' ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithCategoryAndEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		endingIn: 'aDate';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNotNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithCategoryAndWithoutEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		categorizedBy: 'aCategory';
		build.
	self assert: aNote category isNotNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' ) build.
	self assert: aNote description equals: 'aDescription'.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNil
]

{ #category : #tests }
NoteBuilerTest >> testCreateNoteWithoutCategoryAndWithEndingDate [

	| aNote |

	aNote := ( NoteBuilder describedBy: 'aDescription' )
		endingIn: 'aDate';
		build.
	self assert: aNote category isNil.
	self assert: aNote endingDate isNotNil
]
