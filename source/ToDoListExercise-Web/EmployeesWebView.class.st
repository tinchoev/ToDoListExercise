Class {
	#name : #EmployeesWebView,
	#superclass : #WAPainter,
	#instVars : [
		'tableWebView',
		'workingContext',
		'registrationButton'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #'instance creation' }
EmployeesWebView class >> displayedIn: aWorkingContext [

	^ self new initializeDisplayedIn: aWorkingContext
]

{ #category : #initialization }
EmployeesWebView >> initializeDisplayedIn: aWorkingContext [

	workingContext := aWorkingContext.
	self
		initializeRegistrationButton;
		initializeTableWebView
]

{ #category : #initialization }
EmployeesWebView >> initializeRegistrationButton [

	registrationButton := self componentSupplier
		asynchronicButtonLabeled: 'Register Employee'
		applying: [ :theButton |  ].

	registrationButton on trigger
		serverDo: [ workingContext setCurrentWebViewTo: ( EmployeeRegistrationWebView displayedIn: workingContext ) ];
		render: workingContext identifiedCurrentWebView
]

{ #category : #initialization }
EmployeesWebView >> initializeTableWebView [

	tableWebView := TableWebViewBuilder new
		addColumn: [ :column | 
			column
				titled: 'Name';
				rendering: [ :anEmployee | anEmployee ]
			];
		buildApplying: [ :container | container addClass bootstrap3 table ]
]

{ #category : #rendering }
EmployeesWebView >> renderContentOn: aCanvas [

	tableWebView changeContentsTo: workingContext employees.

	aCanvas
		render: registrationButton;
		render: tableWebView
]
