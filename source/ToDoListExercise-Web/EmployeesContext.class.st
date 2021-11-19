Class {
	#name : #EmployeesContext,
	#superclass : #Object,
	#instVars : [
		'workingContext'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
EmployeesContext class >> workingWith: aWorkingContext [

	^ self new initializeWorkingWith: aWorkingContext
]

{ #category : #registration }
EmployeesContext >> addEmployee: anEmployee [

	workingContext employeesRepository addEmployee: anEmployee
]

{ #category : #accessing }
EmployeesContext >> employees [

	^ workingContext employeesRepository employees
]

{ #category : #accessing }
EmployeesContext >> identifiedCurrentWebView [

	^ workingContext identifiedCurrentWebView
]

{ #category : #initialization }
EmployeesContext >> initializeWorkingWith: aWorkingContext [

	workingContext := aWorkingContext
]

{ #category : #accessing }
EmployeesContext >> setCurrentWebViewTo: aWebView [

	workingContext setCurrentWebViewTo: aWebView
]
