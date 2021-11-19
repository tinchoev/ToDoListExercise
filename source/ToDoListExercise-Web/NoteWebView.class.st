Class {
	#name : #NoteWebView,
	#superclass : #WAPainter,
	#instVars : [
		'table'
	],
	#category : #'ToDoListExercise-Web'
}

{ #category : #initialization }
NoteWebView >> initialize [

	table := TableWebViewBuilder new
		addColumn: [ :column | 
			column
				titled: 'Description';
				rendering: [ :content | content ]
			];
		addColumn: [ :column | 
			column
				titled: 'Categoría';
				rendering: [ :content | content ]
			];
		addColumn: [ :column | 
			column
				titled: 'Ending Date';
				rendering: [ :content | content ]
			];
		addColumn: [ :column | 
			column
				titled: 'Assigned Employee';
				rendering: [ :content | content ]
			];
		addColumn: [ :column | 
			column
				titled: 'State';
				rendering: [ :content | content ]
			];
		build
]

{ #category : #rendering }
NoteWebView >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	aCanvas render: table
]

{ #category : #rendering }
NoteWebView >> renderNotes: notes [

	table changeContentsTo: notes
]
