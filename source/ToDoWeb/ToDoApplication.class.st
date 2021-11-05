Class {
	#name : #ToDoApplication,
	#superclass : #WillowApplication,
	#instVars : [
		'tasks',
		'tasksContainer',
		'taskDescriptionField',
		'addTaskButton'
	],
	#category : #ToDoWeb
}

{ #category : #accessing }
ToDoApplication class >> applicationTitle [
	^ 'To Do'
]

{ #category : #accessing }
ToDoApplication class >> handlerName [
	^ 'to-do'
]

{ #category : #accessing }
ToDoApplication >> componentSupplierForApplication [
	^ Html5ComponentSupplier new
]

{ #category : #initialization }
ToDoApplication >> configureInteractions [
	taskDescriptionField on trigger 
									serializeIt;
									enable: addTaskButton .
	addTaskButton on trigger
							disable;
							serverDo: [ tasks add: (PendingTask describedBy: taskDescriptionField model) ];
							setValueTo: [ '' ] withoutTriggeringChangeOf: taskDescriptionField ;
							render: tasksContainer
]

{ #category : #accessing }
ToDoApplication >> contentView [
	^ [ :canvas | 
			canvas
				heading: 'My To-Do';
				render: tasksContainer;
				render: taskDescriptionField;
				render: addTaskButton ]
]

{ #category : #hooks }
ToDoApplication >> initialRequest: request [
	super initialRequest: request.
	tasks := OrderedCollection new.
	self initializeTasksContainer.
	self initializeTaskDescriptionField.
	self initializeAddTaskButton.
	self configureInteractions
]

{ #category : #initialization }
ToDoApplication >> initializeAddTaskButton [
	addTaskButton := self componentSupplier 
									asynchronicButtonLabeled: 'Click me' 
									applying: [ :theButton | theButton beDisabled ]
]

{ #category : #initialization }
ToDoApplication >> initializeTaskDescriptionField [
	taskDescriptionField := self componentSupplier 
											singleLineTextFieldApplying: 
												[ :theField | theField setPlaceholderTo: 'Write your task' ]
]

{ #category : #initialization }
ToDoApplication >> initializeTasksContainer [
	tasksContainer := self componentSupplier 
									divisionContainerWrapping: [ :canvas | canvas unorderedList: tasks ] 
									applying: [  ]
]

{ #category : #accessing }
ToDoApplication >> jQueryLibrary [
	^ JQuery3OnlineLibrary default
]
