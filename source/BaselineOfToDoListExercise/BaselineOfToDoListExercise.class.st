Class {
	#name : #BaselineOfToDoListExercise,
	#superclass : #BaselineOf,
	#category : #BaselineOfToDoListExercise
}

{ #category : #accessing }
BaselineOfToDoListExercise >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ 
			self setUpDependencies: spec.

			spec
				package: 'ToDoListExercise-Model' with: [ spec requires: #('Aconcagua' 'Chalten' 'Buoy') ]
			]
]

{ #category : #accessing }
BaselineOfToDoListExercise >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfToDoListExercise >> setUpDependencies: spec [

	spec 
		baseline: 'Aconcagua' 
			with: [ spec repository: 'github://ba-st/Aconcagua:v8/source' ].

	spec 
		baseline: 'Chalten' 
			with: [ spec repository: 'github://ba-st/Chalten:v8/source' ].
	spec 
		baseline: 'Buoy' 
			with: [ spec repository: 'github://ba-st/Buoy:v6/source' ].
	
	spec
		baseline: 'WillowBootstrap'
			with: [ spec repository: 'github://ba-st/Willow-Bootstrap:v13/source' ].

	spec 
		baseline: 'WillowSpinKit' 
			with: [ spec repository: 'github://ba-st/Willow-SpinKit:v9/source' ].
]
