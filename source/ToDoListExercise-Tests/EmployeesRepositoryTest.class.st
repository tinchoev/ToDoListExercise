Class {
	#name : #EmployeesRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'repo',
		'goku'
	],
	#category : #'ToDoListExercise-Tests'
}

{ #category : #running }
EmployeesRepositoryTest >> setUp [

	"Hooks that subclasses may override to define the fixture of test."

	repo := EmployeesRepository new.
	goku := Employee named: 'Goku'
]

{ #category : #tests }
EmployeesRepositoryTest >> testAddEmployee [

	repo := EmployeesRepository new.
	self assert: repo employees isEmpty.
	repo addEmployee: goku.
	self
		withTheOnlyOneIn: repo employees
		do: [ :anEmployee | self assert: anEmployee name equals: 'Goku' ]
]

{ #category : #tests }
EmployeesRepositoryTest >> testAssertAnEmployeeIsLoaded [

	self
		should: [ repo assertIsAdded: goku for: 'cocinar fideos' ]
		raise: AssertionFailed
		withMessageText: 'Cant cocinar fideos because the employee isnt added'.
	repo addEmployee: goku.
	self
		withTheOnlyOneIn: repo employees
		do: [ :anEmployee | self assert: anEmployee name equals: 'Goku' ]
]

{ #category : #tests }
EmployeesRepositoryTest >> testCantAddEmployeeThatsAlreadyAdded [

	self assert: repo employees isEmpty.
	repo addEmployee: goku.
	self withTheOnlyOneIn: repo employees do: [ :employee | self assert: employee name equals: 'Goku' ].
	self
		should: [ repo addEmployee: goku ]
		raise: AssertionFailed
		withMessageText: 'Cant add employee because it is already added'
]
