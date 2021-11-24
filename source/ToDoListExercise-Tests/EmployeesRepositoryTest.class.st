Class {
	#name : #EmployeesRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'repo'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
EmployeesRepositoryTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	repo := EmployeesRepository new
]

{ #category : #tests }
EmployeesRepositoryTest >> testAddEmployee [

	repo := EmployeesRepository new.
	self assert: repo employees isEmpty.
	repo addEmployee: 'Goku'.
	self withTheOnlyOneIn: repo employees do: [ :employee | self assert: employee equals: 'Goku' ]
]

{ #category : #tests }
EmployeesRepositoryTest >> testAssertAnEmployeeIsLoaded [

	self
		should: [ repo assertIsLoaded: 'Goku' for: 'cocinar fideos' ]
		raise: AssertionFailed
		withMessageText: 'Cant cocinar fideos because the employee isnt loaded'.
	repo addEmployee: 'Goku'.
	self withTheOnlyOneIn: repo employees do: [ :employee | self assert: employee equals: 'Goku' ]
]

{ #category : #tests }
EmployeesRepositoryTest >> testCantAddEmployeeThatsAlreadyAdded [

	self assert: repo employees isEmpty.
	repo addEmployee: 'Goku'.
	self withTheOnlyOneIn: repo employees do: [ :employee | self assert: employee equals: 'Goku' ].
	self
		should: [ repo addEmployee: 'Goku' ]
		raise: AssertionFailed
		withMessageText: 'Cant add employee because it is already added'
]
