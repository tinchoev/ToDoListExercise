Class {
	#name : #PendingTask,
	#superclass : #WAPainter,
	#category : #'ToDoListExercise-Web'
}

{ #category : #rendering }
PendingTask >> renderContentOn: aCanvas [

	"This is the main rendering method of WAPainter. It will be called with an instance of
	the Renderer class returned by #rendererClass whenever this Painter is asked to render
	itself. By convention, implementations of this method that expect a Canvas renderer
	use 'html' as the parameter name."

	| table |

	aCanvas header: 'Notes'.
	table := TableWebViewBuilder new
		addColumn: [ :colum | 
			colum
				titled: 'Description';
				rendering: [ :description | description ]
			];
		addColumn: [ :colum | 
			colum
				titled: 'Category';
				rendering: [ :category | category ]
			];
		addColumn: [ :colum | 
			colum
				titled: 'State';
				rendering: [ :state | state ]
			];
		addColumn: [ :colum | 
			colum
				titled: 'Ending Date';
				rendering: [ :endingDate | endingDate ]
			];
		addColumn: [ :colum | 
			colum
				titled: 'Assigned Employee';
				rendering: [ :anEmployee | anEmployee ]
			];
		buildApplying: [ :theTable |  ].
	table changeContentsTo: #('Hola')
]
