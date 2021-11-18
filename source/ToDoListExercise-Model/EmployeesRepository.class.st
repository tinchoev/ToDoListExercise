Class {
	#name : #EmployeesRepository,
	#superclass : #Object,
	#instVars : [
		'employees'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #modifying }
EmployeesRepository >> addEmployee: anEmployee [

	employees add: anEmployee
]

{ #category : #asserting }
EmployeesRepository >> assertIsLoaded: anEmployee for: anAction [

	( employees includes: anEmployee )
		ifFalse: [ AssertionFailed
				signal: ( 'Cant <1s> because the employee isnt loaded' expandMacrosWith: anAction ) ]
]

{ #category : #accessing }
EmployeesRepository >> employees [

	^ employees
]

{ #category : #initialization }
EmployeesRepository >> initialize [

	employees := OrderedCollection new
]
