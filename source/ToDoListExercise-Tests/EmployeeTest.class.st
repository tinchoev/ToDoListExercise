Class {
	#name : #EmployeeTest,
	#superclass : #TestCase,
	#category : #'ToDoListExercise-Tests'
}

{ #category : #tests }
EmployeeTest >> testCantCreateAnEmployeeWithoutAName [

	self
		should: [ Employee named: '' ]
		raise: AssertionFailed
		withMessageText: 'Employee couldnt be created because it didnt have name'
]
