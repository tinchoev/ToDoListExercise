Class {
	#name : #NotesContext,
	#superclass : #Object,
	#instVars : [
		'workingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
NotesContext class >> workingWith: aWorkingContext [

	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #accessing }
NotesContext >> addNote: aNote [

	workingContext notesRepository addNote: aNote
]

{ #category : #accessing }
NotesContext >> employees [

	^ workingContext employeesRepository employees
]

{ #category : #accessing }
NotesContext >> employeesRepository [

	^ workingContext employeesRepository
]

{ #category : #accessing }
NotesContext >> identifiedCurrentWebView [

	^ workingContext identifiedCurrentWebView
]

{ #category : #initialization }
NotesContext >> initializeWorkingWith: aWorkingContext [

	workingContext := aWorkingContext
]

{ #category : #modifying }
NotesContext >> modifyEndingDateOf: aDescription to: aDate [

	workingContext notesRepository
		modifyEndingDateOf: ( self noteDescriptedBy: aDescription )
		to: aDate
]

{ #category : #modifying }
NotesContext >> modifyStateOf: aNote to: aState [

	aState = 'Open'
		ifTrue: [ workingContext notesRepository beOpen: aNote ]
		ifFalse: [ aState = 'In progress'
				ifTrue: [ workingContext notesRepository beInProgress: aNote ]
				ifFalse: [ aState = 'Finished'
						ifTrue: [ workingContext notesRepository beFinished: aNote ]
					]
			]
]

{ #category : #accessing }
NotesContext >> noteDescriptedBy: aNoteDescription [

	^ self notes detect: [ :note | note description = aNoteDescription ]
]

{ #category : #accessing }
NotesContext >> notes [

	^ workingContext notesRepository notes
]

{ #category : #modifying }
NotesContext >> reassign: aDescription to: anEmployee [

	workingContext notesRepository
		reassign: ( self noteDescriptedBy: aDescription )
		to: anEmployee
		from: workingContext employeesRepository
]

{ #category : #modifying }
NotesContext >> remove: aNote [

	workingContext notesRepository remove: aNote
]

{ #category : #modifying }
NotesContext >> setCurrentWebViewTo: aWebView [

	workingContext setCurrentWebViewTo: aWebView
]

{ #category : #modifying }
NotesContext >> updateNote: aNote with: anotherNote [

	self modifyEndingDateOf: aNote description to: ( anotherNote withEndingDateDo: [ :date | date ] ifNone: [  ] ).
	self
		reassign: aNote description
		to: ( anotherNote withAssignedEmployeeDo: [ :employee | employee ] ifUnassigned: [  ] ).
	self modifyStateOf: aNote to: anotherNote state
]
