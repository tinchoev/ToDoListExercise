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

	( noteWithDescription
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		assignedTo: mickey from: employeesRepo;
		build )
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Mickey' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutAssignedEmployee [

	( noteWithDescription
		categorizedBy: 'aCategory';
		endingIn: January first , 2022;
		build )
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :explanation | self assert: explanation equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategory [

	( noteWithDescription
		endingIn: January first , 2022;
		assignedTo: mickey from: employeesRepo;
		build )
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :explanation | self assert: explanation equals: 'Category not assigned yet' ];
		withEndingDateDo: [ :date | self assert: date equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Mickey' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndAssignedEmployee [

	( noteWithDescription
		endingIn: January first , 2022;
		build )
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :category | self assert: category equals: 'Category not assigned yet' ];
		withEndingDateDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
			ifNone: [ self fail ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryAndEndingDate [

	( noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build )
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :category | self assert: category equals: 'Category not assigned yet' ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Mickey' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutCategoryEndingDateAndAssignedEmployee [

	noteWithDescription build
		withCategoryDo: [ self fail ]
			ifUncategorized: [ :category | self assert: category equals: 'Category not assigned yet' ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutEndingDate [

	( noteWithDescription
		categorizedBy: 'aCategory';
		assignedTo: mickey from: employeesRepo;
		build )
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Mickey' ]
			ifUnassigned: [ self fail ]
]

{ #category : #tests }
NoteTest >> testCreateNoteWithoutEndingDateAndAssignedEmployee [

	( noteWithDescription
		categorizedBy: 'aCategory';
		build )
		withCategoryDo: [ :category | self assert: category equals: 'aCategory' ]
			ifUncategorized: [ self fail ];
		withEndingDateDo: [ self fail ]
			ifNone: [ :endingDate | self assert: endingDate equals: 'Ending date not assigned yet' ];
		withAssignedEmployeeDo: [ self fail ]
			ifUnassigned: [ :employee | self assert: employee equals: 'Employee not assigned yet' ]
]

{ #category : #tests }
NoteTest >> testModifyEndingDate [

	( noteWithDescription
		endingIn: January first , 2022;
		build )
		withEndingDateDo: [ :endingDate | self assert: endingDate equals: January first , 2022 ]
			ifNone: [ self fail ];
		modifyEndingDateTo: January second , 2022;
		withEndingDateDo: [ :endingDate | self assert: endingDate equals: January second , 2022 ]
			ifNone: [ self fail ]
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

	| martin |

	martin := Employee named: 'Martin'.
	employeesRepo addEmployee: martin.
	( noteWithDescription
		assignedTo: mickey from: employeesRepo;
		build )
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Mickey' ]
			ifUnassigned: [ self fail ];
		reassignTo: martin;
		withAssignedEmployeeDo: [ :employee | self assert: employee name equals: 'Martin' ]
			ifUnassigned: [ self fail ]
]
