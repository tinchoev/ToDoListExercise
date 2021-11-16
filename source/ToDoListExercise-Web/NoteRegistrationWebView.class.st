Class {
	#name : #NoteRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'company',
		'tasksForNotes',
		'tasksContainerForNotes',
		'endingDateField',
		'descriptionField',
		'categoryField',
		'assignedEmployeeDropdown',
		'notesRegistrationButton',
		'notes'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #initialization }
NoteRegistrationWebView >> configureInteractions [

	descriptionField on trigger
		serializeIt;
		enable: notesRegistrationButton.
	categoryField on trigger serializeIt.
	endingDateField on trigger serializeIt.
	assignedEmployeeDropdown on trigger serializeIt.
	notesRegistrationButton on trigger
		disable;
		serverDo: [ | note |

			note := ( NoteBuilder describedBy: descriptionField model )
				categorizedBy: categoryField model;
				"		endingIn: endingDateField model;
						assignedTo: assignedEmployeeDropdown model;"
					build.
			notes add: note
			];
		setValueTo: [ '' ] thenTriggerChangeOf: descriptionField;
		setValueTo: [ '' ] thenTriggerChangeOf: categoryField;
		render: tasksContainerForNotes
]

{ #category : #initialization }
NoteRegistrationWebView >> initialize [

	notes := OrderedCollection new.
	self
		initializeRegistrationButton;
		initializeTaskContainerForNotes;
		initializeAssignedEmployeeDropdown;
		initializeCategoryField;
		initializeDescriptionField;
		initializeEndingDateField;
		configureInteractions
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeAssignedEmployeeDropdown [

	assignedEmployeeDropdown := self componentSupplier
		dropdownListApplying: [ :theField | "theField setPlaceholderTo: 'Select an employee to be assigned'" ]	"	taskDropdownForNoteAssignedEmployee allowAnyOf: company employees"
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeCategoryField [

	categoryField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the category' ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeDescriptionField [

	descriptionField := self componentSupplier
		singleLineTextFieldApplying: [ :theField | theField setPlaceholderTo: 'Write the description' ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeEndingDateField [

	endingDateField := self componentSupplier
		dateFieldApplying: [ :theField | "theField setPlaceholderTo: 'Select the ending date'" ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeRegistrationButton [

	notesRegistrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Create note'
		applying: [ :theButton | 
			theButton beDisabled.
			theButton addClass bootstrap3 buttonPrimary
			]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeTaskContainerForNotes [

	tasksContainerForNotes := self componentSupplier
		divisionContainerWrapping: [ :canvas | canvas unorderedList: tasksForNotes ]
		applying: [  ]
]

{ #category : #accessing }
NoteRegistrationWebView >> notes [
	^ notes
]

{ #category : #rendering }
NoteRegistrationWebView >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	aCanvas
		render: descriptionField;
		render: categoryField;
		render: endingDateField;
		render: assignedEmployeeDropdown;
		render: notesRegistrationButton
]
