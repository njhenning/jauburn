"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [

^ #abs -> [ :f | f abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [

^ #concat -> [ :s1 :s2 | s1 , s2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	(self class selectors select: [:each | each endsWith: 'Binding'])
		do: [ :s |
			|binding bindingMethod|
			binding := self perform: s.
			bindingMethod :=JbPrimitive new block: binding value.
			environment at: binding key put: bindingMethod ].
]

{ #category : #primitives }
JbInterpreter >> inputBinding [

^ #input -> [ :prompt | UIManager default request: prompt ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [

^ #length -> [ :s | s size ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [

^ #mod -> [ :a :b | a \\ b ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [

^  #not -> [ :a | a not ]

]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^ #print -> [ :value |  ]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [
	^ #println -> [ :value |  ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]
