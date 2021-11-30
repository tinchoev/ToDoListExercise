Class {
	#name : #NoteBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'aNote',
		'aNotesRepo',
		'anEmployeesRepo',
		'anEmployee'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
NoteBuilderTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	aNotesRepo := NotesRepository new.
	anEmployee := Employee named: 'anEmployee'.
	anEmployeesRepo := EmployeesRepository new
		addEmployee: anEmployee;
		yourself.
	aNote := NoteBuilder new describedBy: 'aDescription'
]

{ #category : #tests }
NoteBuilderTest >> testCantCreateNoteAssignedToAnEmployeeThatIsntLoaded [

	self
		should: [ aNote
				assignedTo: ( Employee named: 'Martin' ) from: anEmployeesRepo;
				build
			]
		raise: AssertionFailed
		withMessageText: 'Cant create note because the employee isnt added'
]

{ #category : #tests }
NoteBuilderTest >> testCantCreateNoteWithoutEmptyDescription [

	self
		should: [ NoteBuilder new build ]
		raise: AssertionFailed
		withMessageText: 'Note couldnt be created because it didnt have description'
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithAllItsAttributes [

	aNote
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		assignedTo: anEmployee from: anEmployeesRepo;
		build;
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'anEmployee' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutAssignedEmployee [

	aNote
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		build;
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :explanation | self assert: explanation equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategory [

	aNote
		endingIn: January first , 2022;
		assignedTo: anEmployee from: anEmployeesRepo;
		build;
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :explanation | self assert: explanation equals: 'Category not assigned yet' ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'anEmployee' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	aNote
		endingIn: January first , 2022;
		build;
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :explanation | self assert: explanation equals: 'Category not assigned yet' ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :explanation | self assert: explanation equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryAndEndingDate [

	aNote
		assignedTo: anEmployee from: anEmployeesRepo;
		build;
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :explanation | self assert: explanation equals: 'Category not assigned yet' ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :explanation | self assert: explanation equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'anEmployee' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	aNote
		build;
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :explanation | self assert: explanation equals: 'Category not assigned yet' ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :explanation | self assert: explanation equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :explanation | self assert: explanation equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutEndingDate [

	aNote
		categorizedBy: 'aCategory';
		assignedTo: anEmployee from: anEmployeesRepo;
		build;
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :explanation | self assert: explanation equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'anEmployee' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteBuilderTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	aNote
		categorizedBy: 'aCategory';
		build;
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :explanation | self assert: explanation equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :explanation | self assert: explanation equals: 'Employee not assigned yet' ]
]
