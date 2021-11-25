Class {
	#name : #FailuresWebView,
	#superclass : #WAPainter,
	#instVars : [
		'workingContext',
		'okButton',
		'failureText'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
FailuresWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
FailuresWebView >> configureInteractions [

	okButton on trigger
		disable;
		serverDo: [ workingContext setCurrentWebViewTo: workingContext ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
FailuresWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeFailureText;
		initializeOkButton;
		configureInteractions
]

{ #category : #initialization }
FailuresWebView >> initializeOkButton [

	okButton := self componentSupplier
		asynchronicButtonLabeled: 'Ok'
		applying: [ :theButton | ]
]

{ #category : #rendering }
FailuresWebView >> renderContentOn: aCanvas [

	aCanvas
		render: failureText;
		render: okButton
]
