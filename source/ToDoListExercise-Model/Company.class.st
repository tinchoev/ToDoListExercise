Class {
	#name : #Company,
	#superclass : #Object,
	#instVars : [
		'employees',
		'notes'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #modifying }
Company >> addEmployee: anEmployee [

	employees add: anEmployee
]

{ #category : #modifying }
Company >> addNote: aNote [

	notes add: aNote
]

{ #category : #accessing }
Company >> employees [

	^ employees
]

{ #category : #accessing }
Company >> employeesSize [

	^ employees size
]

{ #category : #initialization }
Company >> initialize [

	employees := OrderedCollection new.
	notes := OrderedCollection new
]

{ #category : #modifying }
Company >> modifyEndingDateOf: aNote To: aDate [

	notes detect: [ :note | note = aNote ] ifFound: [ :note | note modifyEndingDateTo: aDate ]
]

{ #category : #modifying }
Company >> modifyStateOf: aNote [

	notes detect: [ :note | note = aNote ] ifFound: [ :note | note modifyState ]
]

{ #category : #accessing }
Company >> notesSize [

	^ notes size
]

{ #category : #modifying }
Company >> reassign: aNote to: anEmployee [

	notes detect: [ :note | note = aNote ] ifFound: [ :note | note reassignTo: anEmployee ]
]

{ #category : #modifying }
Company >> remove: aNote [

	notes
		detect: [ :note | note = aNote ]
		ifFound: [ :note | 
			note
				verifyStateIsOpen;
				verifyItDoesNotHaveAnEndingDate
			].
	notes remove: aNote
]
