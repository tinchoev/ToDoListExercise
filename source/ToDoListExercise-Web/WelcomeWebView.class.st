Class {
	#name : #WelcomeWebView,
	#superclass : #WAPainter,
	#category : #'ToDoListExercise-Web'
}

{ #category : #rendering }
WelcomeWebView >> renderContentOn: aCanvas [

	aCanvas render: ( HeadingWebView displaying: 'Welcome' withLevel: 1 )
]
