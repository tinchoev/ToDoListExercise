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
NotesWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeRegistrationButton;
		initializeRemoveButton;
		initializeTableWebView
]

{ #category : #initialization }
NotesWebView >> initializeModifyButtonFor: aNote [

	modifyButton := self componentSupplier
		asynchronicButtonLabeled: 'Modify note'
		applying: [ :theButton |  ].

	modifyButton on trigger
		serverDo: [ workingContext
				setCurrentWebViewTo: ( NoteModificationWebView displayedIn: workingContext changing: aNote )
			];
		render: workingContext identifiedCurrentWebView.

	^ modifyButton
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
NotesWebView >> initializeRemoveButtonFor: aNote [

	removeButton := self componentSupplier
		asynchronicButtonLabeled: 'Remove note'
		applying: [ :theButton |  ].

	removeButton on trigger
		serverDo: [ workingContext
				setCurrentWebViewTo: ( NoteRemovalWebView displayedIn: workingContext removing: aNote )
			];
		render: workingContext identifiedCurrentWebView.

	^ removeButton
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
						[ :note | note withAssignedEmployeeDo: [ :employee | employee name ] ifUnassigned: [ :explanation | explanation ] ]
			];
		addColumn: [ :column | 
			column
				titled: 'State';
				rendering: [ :note | note state ]
			];
		addColumn: [ :column | 
			column
				titled: '';
				rendering: [ :note | self initializeModifyButtonFor: note ]
			];
		addColumn: [ :column | 
			column
				titled: '';
				rendering: [ :note | self initializeRemoveButtonFor: note ]
			];
		buildApplying: [ :container | container addClass bootstrap3 table ]
]

{ #category : #rendering }
NotesWebView >> renderContentOn: aCanvas [

	tableWebView changeContentsTo: workingContext notes.

	aCanvas
		render: registrationButton;
		render: tableWebView
]
