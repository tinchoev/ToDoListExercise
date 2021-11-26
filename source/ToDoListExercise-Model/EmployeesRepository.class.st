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

	self assertEmployeeIsNotAdded: anEmployee.
	employees add: anEmployee
]

{ #category : #asserting }
EmployeesRepository >> assertEmployeeIsNotAdded: anEmployee [

	AssertionChecker
		refuse: ( employees includes: anEmployee )
		because: 'Cant add employee because it is already added'
		raising: AssertionFailed
]

{ #category : #asserting }
EmployeesRepository >> assertIsAdded: anEmployee for: anAction [

	AssertionChecker
		refuse: ( employees includes: anEmployee )
		because: ( 'Cant <1s> because the employee isnt added' expandMacrosWith: anAction )
		raising: AssertionFailed
]

{ #category : #accessing }
EmployeesRepository >> employees [

	^ employees
]

{ #category : #initialization }
EmployeesRepository >> initialize [

	employees := OrderedCollection new
]
