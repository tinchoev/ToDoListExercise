Class {
	#name : #MainWebView,
	#superclass : #WAPainter,
	#instVars : [
		'buttonsWebView',
		'identifiedCurrentWebView'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #accessing }
MainWebView >> identifiedCurrentWebView [

	^ identifiedCurrentWebView
]

{ #category : #initialization }
MainWebView >> initialize [

	super initialize.
	self
		initializeButtonsWebView;
		initializeIdentifiedCurrentWebView
]

{ #category : #initialization }
MainWebView >> initializeButtonsWebView [

	buttonsWebView := ButtonsWebView new
]

{ #category : #initialization }
MainWebView >> initializeIdentifiedCurrentWebView [

	identifiedCurrentWebView := self componentSupplier
		divisionContainerWrapping: [ :aCanvas | aCanvas render: self session applicationContext currentWebView ]
		applying: [  ].

	identifiedCurrentWebView beIdentifiable
]

{ #category : #rendering }
MainWebView >> renderContentOn: aCanvas [

	aCanvas
		render: buttonsWebView;
		render: identifiedCurrentWebView
]
