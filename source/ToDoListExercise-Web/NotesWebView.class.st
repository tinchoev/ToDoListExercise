Class {
	#name : #NotesWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'registrationButton',
		'tableWebView',
		'removeButton',
		'modifyStateButton',
		'modifyEndingDateButton',
		'modifyEmployeeButton',
		'modifyButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NotesWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NotesWebView >> initializeAssignedEmployeeModificationButton [

	modifyEmployeeButton := self componentSupplier
		asynchronicButtonLabeled: 'Reassign note to another employee'
		applying: [ :theButton |  ].

	modifyEmployeeButton on trigger
		serverDo: [ workingContext
				setCurrentWebViewTo: ( NoteAssignedEmployeeModificationWebView displayedIn: workingContext )
			];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeRegistrationButton;
		initializeRemoveButton;
		initializeStateModificationButton;
		initializeEndingDateModificationButton;
		initializeAssignedEmployeeModificationButton;
		initializeModifyButton;
		initializeTableWebView
]

{ #category : #initialization }
NotesWebView >> initializeEndingDateModificationButton [

	modifyEndingDateButton := self componentSupplier
		asynchronicButtonLabeled: 'Modify ending date of a note'
		applying: [ :theButton |  ].

	modifyEndingDateButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( NoteEndingDateModificationWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeModifyButton [

	modifyButton := self componentSupplier
		asynchronicButtonLabeled: 'Modify note'
		applying: [ :theButton |  ].

	modifyButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( NoteModificationWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Register Note'
		applying: [ :theButton |  ].

	registrationButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( NoteRegistrationWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeRemoveButton [

	removeButton := self componentSupplier
		asynchronicButtonLabeled: 'Remove Note'
		applying: [ :theButton |  ].

	removeButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( NoteRemovalWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeStateModificationButton [

	modifyStateButton := self componentSupplier
		asynchronicButtonLabeled: 'Modify state of a note'
		applying: [ :theButton |  ].

	modifyStateButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( NoteStateModificationWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesWebView >> initializeTableWebView [

	tableWebView := TableWebViewBuilder new
		addColumn: [ :column | 
			column
				titled: 'Description';
				rendering: [ :note | note description ]
			];
		addColumn: [ :column | 
			column
				titled: 'Categoría';
				rendering:
						[ :note | note withCategoryDo: [ :content | content ] ifUncategorized: [ :explanation | explanation ] ]
			];
		addColumn: [ :column | 
			column
				titled: 'Ending Date';
				rendering: [ :note | note withEndingDateDo: [ :content | content ] ifNone: [ :explanation | explanation ] ]
			];
		addColumn: [ :column | 
			column
				titled: 'Assigned Employee';
				rendering:
						[ :note | note withAssignedEmployeeDo: [ :content | content ] ifUnassigned: [ :explanation | explanation ] ]
			];
		addColumn: [ :column | 
			column
				titled: 'State';
				rendering: [ :note | note state ]
			];
		"addColumn: [ :column | 
			column
				titled: 'Modify';
				rendering: modifyButton
			];"
		buildApplying: [ :container | container addClass bootstrap3 table ]
]

{ #category : #rendering }
NotesWebView >> renderContentOn: aCanvas [

	tableWebView changeContentsTo: workingContext notes.

	aCanvas
		render: registrationButton;
		render: removeButton;
		render: modifyStateButton;
		render: modifyEndingDateButton;
		render: modifyEmployeeButton;
		render: tableWebView
]
