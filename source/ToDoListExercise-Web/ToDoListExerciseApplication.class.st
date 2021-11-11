Class {
	#name : #ToDoListExerciseApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'employeesButton',
		'notesButton',
		'createEmployeeButton',
		'showEmployeesButton',
		'createNoteButton',
		'modifyNoteButton',
		'removeNoteButton',
		'company',
		'tasks',
		'tasksContainer',
		'addTaskButton',
		'taskFieldForNoteDescription',
		'taskFieldForNoteCategory'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #accessing }
ToDoListExerciseApplication class >> applicationTitle [
	
	^ 'To Do List Exercise'
]

{ #category : #accessing }
ToDoListExerciseApplication class >> handlerName [

	^ 'to-do-list-exercise'
]

{ #category : #accessing }
ToDoListExerciseApplication class >> start [

	ToDoListExerciseApplication registerAsDevelopmentApplication.
	( ZnZincServerAdaptor port: 8080 )
		codec: ( GRCodec forEncoding: 'utf8' );
		start
]

{ #category : #accessing }
ToDoListExerciseApplication class >> stop [

	ZnServer stopDefault.
	ZnZincServerAdaptor allInstancesDo: [ :each | each shutDown ].
	ToDoListExerciseApplication unregisterFromApplications.
	Smalltalk garbageCollect
]

{ #category : #accessing }
ToDoListExerciseApplication >> componentSupplierForApplication [

	^ Html5ComponentSupplier new
]

{ #category : #rendering }
ToDoListExerciseApplication >> configureInteractions [
	| note |
	taskFieldForNoteDescription on trigger
		serializeIt;
		enable: addTaskButton.
	taskFieldForNoteCategory on trigger serializeIt.
	note := NoteCreator
		for:
			((NoteBuilder described: taskFieldForNoteDescription)
				category: taskFieldForNoteCategory;
				build).
	addTaskButton on trigger
		disable;
		serverDo: [ tasks
				add: note description model;
				add: note category model ];
		setValueTo: [ '' ]
			withoutTriggeringChangeOf: taskFieldForNoteDescription;
		render: tasksContainer	"employeesButton on trigger serverDo: [ :canvas | self renderEmployeesPageButtonsOn: canvas ].
	notesButton on trigger serverDo: [ self renderNotesPageButtonsOn: canvas ]"
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ [ :canvas | 
	canvas heading: 'Welcome to the To Do List Exercise!';
	render: tasksContainer ;
	render: taskFieldForNoteDescription;
	render: taskFieldForNoteCategory ;
	render: addTaskButton 
"		render: employeesButton;
		render: notesButton"
	]
]

{ #category : #rendering }
ToDoListExerciseApplication >> initialRequest: request [
	super initialRequest: request.
	tasks := OrderedCollection new.
	self initializeTaskContainer.
	self initializeTaskFieldForNoteDescription.
	self initializeTaskFieldForNoteCategory .
	self initializeAddTaskButton.
"	self initializeButtons."
	self configureInteractions
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeAddTaskButton [
	addTaskButton := self componentSupplier asynchronicButtonLabeled: 'Click me' applying: [ :theButton | theButton beDisabled ]
]

{ #category : #rendering }
ToDoListExerciseApplication >> initializeButtons [
	company := Company new .
	employeesButton := self componentSupplier
		asynchronicButtonLabeled: 'Employees'
		applying: [ :theButton | ] .
	notesButton := self componentSupplier
		asynchronicButtonLabeled: 'Notes'
		applying: [ :theButton | ] .
	createEmployeeButton := self componentSupplier
		asynchronicButtonLabeled: 'Create employee'
		applying: [ :theButton | ] .
	showEmployeesButton := self componentSupplier
		asynchronicButtonLabeled: 'Show employees'
		applying: [ :theButton | ] .
	createNoteButton := self componentSupplier
		asynchronicButtonLabeled: 'Create note'
		applying: [ :theButton | ] .
	modifyNoteButton := self componentSupplier
		asynchronicButtonLabeled: 'Modify note'
		applying: [ :theButton | ] .
	removeNoteButton := self componentSupplier
		asynchronicButtonLabeled: 'Remove note'
		applying: [ :theButton | ] .
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskContainer [

	tasksContainer := self componentSupplier
		divisionContainerWrapping: [ :canvas | canvas unorderedList: tasks ]
		applying: [  ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskFieldForNoteCategory [

	taskFieldForNoteCategory := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the category' ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskFieldForNoteDescription [

	taskFieldForNoteDescription := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the desription' ]
]

{ #category : #accessing }
ToDoListExerciseApplication >> jQueryLibrary [

	^ JQuery3OnlineLibrary default
]

{ #category : #rendering }
ToDoListExerciseApplication >> renderButtonOn: aCanvas with: aMessage [
	^ self componentSupplier
		asynchronicButtonLabeled: aMessage
		applying: [ :theButton | ]
]

{ #category : #rendering }
ToDoListExerciseApplication >> renderEmployeesPageButtonsOn: aCanvas [

	aCanvas
		render: createEmployeeButton;
		render: showEmployeesButton
]

{ #category : #rendering }
ToDoListExerciseApplication >> renderHomepageButtonsOn: aCanvas [

	aCanvas
		render: employeesButton;
		render: notesButton
]

{ #category : #rendering }
ToDoListExerciseApplication >> renderNotesPageButtonsOn: aCanvas [

	aCanvas
		render: createNoteButton;
		render: modifyNoteButton;
		render: removeNoteButton
]

{ #category : #accessing }
ToDoListExerciseApplication >> renderTasksOn: aCanvas [
	^ aCanvas unorderedList add: PendingTask new
]
