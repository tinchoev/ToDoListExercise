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
		'taskFieldForDescriptionNote'
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
ToDoListExerciseApplication >> componentSupplierForApplication [

	^ Html5ComponentSupplier new
]

{ #category : #rendering }
ToDoListExerciseApplication >> configureInteractions [

	taskFieldForDescriptionNote on trigger
		serializeIt;
		enable: addTaskButton.
	addTaskButton on trigger
		disable;
		serverDo: [ tasks add: ( NoteCreator describedBy: taskFieldForDescriptionNote model ) ];
		setValueTo: [ '' ] withoutTriggeringChangeOf: taskFieldForDescriptionNote;
		render: tasksContainer	"employeesButton on trigger serverDo: [ :canvas | self renderEmployeesPageButtonsOn: canvas ].
	notesButton on trigger serverDo: [ self renderNotesPageButtonsOn: canvas ]"
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ [ :canvas | 
	canvas heading: 'Welcome to the To Do List Exercise!';
	render: tasksContainer ;
	render: taskFieldForDescriptionNote;
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
	self initializeTaskFieldForDescriptionNote.
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
ToDoListExerciseApplication >> initializeTaskFieldForDescriptionNote [

	taskFieldForDescriptionNote := self componentSupplier
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
