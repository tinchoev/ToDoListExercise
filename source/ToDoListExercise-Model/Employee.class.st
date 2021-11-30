Class {
	#name : #Employee,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ToDoListExercise-Model'
}

{ #category : #asserting }
Employee class >> assertNameIsntEmpty: aName [

	AssertionChecker
		refuse: [ aName isEmpty ]
		because: 'Employee couldnt be created because it didnt have name'
		raising: AssertionFailed
]

{ #category : #'instance creation' }
Employee class >> named: aName [

	self assertNameIsntEmpty: aName.
	^ self new initializeNamed: aName
]

{ #category : #initialization }
Employee >> initializeNamed: aName [

	name := aName
]

{ #category : #accessing }
Employee >> name [

	^ name
]

{ #category : #printing }
Employee >> printOn: aStream [

	aStream print: name
]
