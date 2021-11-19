Class {
	#name : #EmployeeWebView,
	#superclass : #WAPainter,
	#instVars : [
		'table',
		'div'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #rendering }
EmployeeWebView >> changeEmployeesTo: employees [

	table changeContentsTo: employees
]

{ #category : #initialization }
EmployeeWebView >> initialize [

	table := TableWebViewBuilder new
		addColumn: [ :column | 
			column
				titled: 'Nombre';
				rendering: [ :content | content ]
			];
		build.
	"div := self componentSupplier
		divisionContainerWrapping: [ :canvas | canvas render: table ]
		applying: [  ].
	div beIdentifiable"
]

{ #category : #rendering }
EmployeeWebView >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	aCanvas render: table
]
