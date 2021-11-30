Class {
	#name : #WelcomeWebView,
	#superclass : #WAPainter,
	#category : #'ToDoListExercise-Web'
}

{ #category : #rendering }
WelcomeWebView >> headingStyle [
	
	^ [ :style | style textAlign: #center ]
]

{ #category : #rendering }
WelcomeWebView >> renderContentOn: aCanvas [

	aCanvas
		render:
			( HeadingWebView displaying: 'Welcome to the ToDoListExercise!' withLevel: 1 applying: [ :heading | heading setStyleTo: self headingStyle ] )
]
