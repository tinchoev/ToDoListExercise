Class {
	#name : #ToDoListExerciseApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'tasks',
		'tasksContainer',
		'addTaskButton',
		'taskFieldForNoteDescription',
		'taskFieldForNoteCategory',
		'taskFieldForNoteEndingDate',
		'taskDropdownForNoteAssignedEmployee'
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
	taskFieldForNoteDescription on trigger
		serializeIt;
		enable: addTaskButton.
	taskFieldForNoteCategory on trigger serializeIt.
	taskFieldForNoteEndingDate on trigger serializeIt.
	taskDropdownForNoteAssignedEmployee on trigger serializeIt .
	addTaskButton on trigger
		disable;
		serverDo: [ tasks
				add:
					(NoteTask describedBy: (((NoteBuilder describedBy: taskFieldForNoteDescription model)
						categorizedBy: taskFieldForNoteCategory model;"
						endingIn: taskFieldForNoteEndingDate model;
						assignedTo: taskDropdownForNoteAssignedEmployee model;"
						build) printString)) ];
		setValueTo: [ '' ]
			thenTriggerChangeOf: taskFieldForNoteDescription;
		setValueTo: [ '' ]
			thenTriggerChangeOf: taskFieldForNoteCategory;
		render: tasksContainer
]

{ #category : #accessing }
ToDoListExerciseApplication >> contentView [

	^ [ :canvas | 
	canvas heading: 'Welcome to the To Do List Exercise!';
	render: tasksContainer ;
	render: taskFieldForNoteDescription;
	render: taskFieldForNoteCategory ;
	render: taskFieldForNoteEndingDate ;
	render: taskDropdownForNoteAssignedEmployee ;
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
	self initializeTaskFieldForNoteEndingDate.
	self initializeTaskDropdownForNoteAssignedEmployee.
	self initializeAddTaskButton.
"	self initializeButtons."
	self configureInteractions
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeAddTaskButton [
	addTaskButton := self componentSupplier asynchronicButtonLabeled: 'Click me' applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskContainer [

	tasksContainer := self componentSupplier
		divisionContainerWrapping: [ :canvas | canvas unorderedList: tasks ]
		applying: [  ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskDropdownForNoteAssignedEmployee [

	taskDropdownForNoteAssignedEmployee := self componentSupplier
		dropdownListApplying: [ :theField | "theField setPlaceholderTo: 'Select an employee to be assigned'" ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskFieldForNoteCategory [

	taskFieldForNoteCategory := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the category' ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskFieldForNoteDescription [

	taskFieldForNoteDescription := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the description' ]
]

{ #category : #initialization }
ToDoListExerciseApplication >> initializeTaskFieldForNoteEndingDate [

	taskFieldForNoteEndingDate := self componentSupplier
		dateFieldApplying: [ :theField | "theField setPlaceholderTo: 'Select the ending date'" ]
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
