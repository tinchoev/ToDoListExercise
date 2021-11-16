Class {
	#name : #EmployeeOutputWebView,
	#superclass : #WAPainter,
	#instVars : [
		'table'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #initialization }
EmployeeOutputWebView >> initialize [

	table := TableWebViewBuilder new
		addColumn: [ :column | 
			column
				titled: 'Nombre';
				rendering: [ :content | content ]
			];
		build
]

{ #category : #rendering }
EmployeeOutputWebView >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	aCanvas render: table
]
