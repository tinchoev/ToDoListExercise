Class {
	#name : #NoteBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'aNote',
		'aNotesRepo',
		'anEmployeesRepo'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #asserting }
NoteBuilderTest >> assertContentOf: aUsedOptional equals: aContent [

	aUsedOptional
		withContentDo: [ :content | self assert: content equals: aContent ]
		ifUnused: [ self fail ]
]

{ #category : #asserting }
NoteBuilderTest >> assertExplanationOf: anUnusedOptional equals: anExplanation [

	anUnusedOptional
		withContentDo: [ self fail ]
		ifUnused: [ :explanation | self assert: explanation equals: anExplanation ]
]

{ #category : #running }
NoteBuilderTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	aNotesRepo := NotesRepository new.
	anEmployeesRepo := EmployeesRepository new
		addEmployee: 'anEmployee';
		yourself.
	aNote := NoteBuilder describedBy: 'aDescription'
]

{ #category : #tests }
NoteBuilderTest >> testCantCreateNoteAssignedToAnEmployeeThatIsntLoaded [

	self
		should: [ aNote
				assignedTo: 'Martin' from: anEmployeesRepo;
				build
			]
		raise: AssertionFailed
		withMessageText: 'Cant create note because the employee isnt loaded'
]

{ #category : #tests }
NoteBuilderTest >> testCantCreateNoteWithoutDescription [

	self
		should: [ NoteBuilder describedBy: '' ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithAllItsAttributes [

	aNote
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		assignedTo: 'anEmployee' from: anEmployeesRepo;
		build.
	self assertContentOf: aNote category equals: 'aCategory'.
	self assertContentOf: aNote endingDate equals: January first , 2022.
	self assertContentOf: aNote assignedEmployee equals: 'anEmployee'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutAssignedEmployee [

	aNote
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		build.
	self assertContentOf: aNote category equals: 'aCategory'.
	self assertContentOf: aNote endingDate equals: January first , 2022.
	self assertExplanationOf: aNote assignedEmployee equals: 'Employee not assigned yet'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategory [

	aNote
		endingIn: January first , 2022;
		assignedTo: 'anEmployee' from: anEmployeesRepo;
		build.
	self assertExplanationOf: aNote category equals: 'Category not assigned yet'.
	self assertContentOf: aNote endingDate equals: January first , 2022.
	self assertContentOf: aNote assignedEmployee equals: 'anEmployee'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	aNote
		endingIn: January first , 2022;
		build.
	self assertExplanationOf: aNote category equals: 'Category not assigned yet'.
	self assertContentOf: aNote endingDate equals: January first , 2022.
	self assertExplanationOf: aNote assignedEmployee equals: 'Employee not assigned yet'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryAndEndingDate [

	aNote
		assignedTo: 'anEmployee' from: anEmployeesRepo;
		build.
	self assertExplanationOf: aNote category equals: 'Category not assigned yet'.
	self assertExplanationOf: aNote endingDate equals: 'Ending date not assigned yet'.
	self assertContentOf: aNote assignedEmployee equals: 'anEmployee'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	aNote build.
	self assertExplanationOf: aNote category equals: 'Category not assigned yet'.
	self assertExplanationOf: aNote endingDate equals: 'Ending date not assigned yet'.
	self assertExplanationOf: aNote assignedEmployee equals: 'Employee not assigned yet'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutEndingDate [

	aNote
		categorizedBy: 'aCategory';
		assignedTo: 'anEmployee' from: anEmployeesRepo;
		build.
	self assertExplanationOf: aNote endingDate equals: 'Ending date not assigned yet'.
	self assertContentOf: aNote category equals: 'aCategory'.
	self assertContentOf: aNote assignedEmployee equals: 'anEmployee'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	aNote
		categorizedBy: 'aCategory';
		build.
	self assertContentOf: aNote category equals: 'aCategory'.
	self assertExplanationOf: aNote endingDate equals: 'Ending date not assigned yet'.
	self assertExplanationOf: aNote assignedEmployee equals: 'Employee not assigned yet'
]
