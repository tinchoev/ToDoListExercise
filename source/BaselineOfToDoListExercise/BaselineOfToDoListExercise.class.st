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
		do: [ self
				setUpDependenciesIn: spec;
				setUpPackagesIn: spec;
				setUpGroupsIn: spec
			]
]

{ #category : #accessing }
BaselineOfToDoListExercise >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #accessing }
BaselineOfToDoListExercise >> setUpDependenciesIn: spec [

	spec
		baseline: 'Aconcagua' with: [ spec repository: 'github://ba-st/Aconcagua:v8/source' ];
		baseline: 'Chalten' with: [ spec repository: 'github://ba-st/Chalten:v8/source' ];
		baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6/source' ];
		baseline: 'WillowBootstrap'
			with: [ spec repository: 'github://ba-st/Willow-Bootstrap:v13/source' ];
		baseline: 'WillowSpinKit' with: [ spec repository: 'github://ba-st/Willow-SpinKit:v9/source' ]
]

{ #category : #accessing }
BaselineOfToDoListExercise >> setUpGroupsIn: spec [

	spec
		group: 'Deployment' with: #('ToDoListExercise-Model');
		group: 'Tests' with: #('ToDoListExercise-Tests');
		group: 'CI' with: 'Tests';
		group: 'Tools' with: #();
		group: 'Dependent-SUnit-Extensions' with: #();
		group: 'Development' with: #('Tools' 'Tests')
]

{ #category : #accessing }
BaselineOfToDoListExercise >> setUpPackagesIn: spec [

	spec
		package: 'ToDoListExercise-Model' with: [ spec requires: #('Aconcagua' 'Chalten' 'Buoy') ];
		package: 'ToDoListExercise-Tests' with: [ spec requires: 'ToDoListExercise-Model' ]
]
