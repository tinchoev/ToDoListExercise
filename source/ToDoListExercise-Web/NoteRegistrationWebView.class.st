Class {
	#name : #NoteRegistrationWebView,
	#superclass : #WAPainter,
	#instVars : [
		'endingDateField',
		'descriptionField',
		'categoryField',
		'assignedEmployeeDropdown',
		'registrationButton',
		'workingContext',
		'notesRepository'
	],
	#classInstVars : [
		'aWorkingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #constructor }
NoteRegistrationWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
NoteRegistrationWebView >> configureInteractions [

	descriptionField on trigger
		serializeIt;
		enable: registrationButton.
	categoryField on trigger serializeIt.
	endingDateField on trigger serializeIt.
	assignedEmployeeDropdown on trigger serializeIt.
	registrationButton on trigger
		disable;
		serverDo: [ notesRepository
				addNote:
					( ( NoteBuilder describedBy: descriptionField model )
						categorizedBy: categoryField model;
						"		endingIn: endingDateField model;
						assignedTo: assignedEmployeeDropdown model;"
							build ).
			workingContext renderNotes: notesRepository notes
			];
		setValueTo: [ '' ] thenTriggerChangeOf: descriptionField;
		setValueTo: [ '' ] thenTriggerChangeOf: categoryField
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
NoteRegistrationWebView >> initializeDisplayedIn: aWorkingContext [

	self
		initializeRegistrationButton;
		initializeAssignedEmployeeDropdown;
		initializeCategoryField;
		initializeDescriptionField;
		initializeEndingDateField;
		configureInteractions.
	workingContext := aWorkingContext.
	notesRepository := NotesRepository new
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeEndingDateField [

	endingDateField := self componentSupplier
		dateFieldApplying: [ :theField | "theField setPlaceholderTo: 'Select the ending date'" ]
]

{ #category : #initialization }
NoteRegistrationWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Create note'
		applying: [ :theButton | theButton beDisabled ]
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
		render: registrationButton
]
