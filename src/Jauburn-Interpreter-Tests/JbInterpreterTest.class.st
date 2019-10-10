Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testBooleanExpression [

	self interpret: 'var x = 3; var y = x > 10;'.
	self assert: (interpreter environment at: 'y') equals: false. 
	
	self interpret: 'var x = 10; var y = x > 1;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 10; var y = x == 10;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 3; var y = x == 10;'.
	self assert: (interpreter environment at: 'y') equals: false.
	
	self interpret: 'var x = 1; var y = x < 10;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 10; var y = x < 1;'.
	self assert: (interpreter environment at: 'y') equals: false. 
	
	self interpret: 'var x = 10; var y = x <= 10;'.
	self assert: (interpreter environment at: 'y') equals: true. 
	
	self interpret: 'var x = 10; var y = x <= 7;'.
	self assert: (interpreter environment at: 'y') equals: false. 
	
	self interpret: 'var x = 1; var y = x >= 10;'.
	self assert: (interpreter environment at: 'y') equals: false. 
	
	self interpret: 'var x = 10; var y = x >= 2;'.
	self assert: (interpreter environment at: 'y') equals: true. 
	
	self interpret: 'var x = 2; var y = x != 4;'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var x = 2; var y = x != 2;'.
	self assert: (interpreter environment at: 'y') equals: false. 
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	

	self interpret: 'var x = 10 - 8 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 6.
	


]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCall [

	self interpret: 'var x = 1; var y = function() {x = x + 1;}; var z = y();'.
	
	self assert: (interpreter environment at: 'x') equals: 2.
	
	self interpret: 'var y = function(a, b, c) (return a + b + c;);var z = y(1, 2, 3);'.
	self assert: (interpreter environment at: 'y') equals: 4.
]

{ #category : #tests }
JbInterpreterTest >> testFunctionDefinition [

 	self interpret: 'var x = function(a,b,c) {};'.
	
	self assert: (interpreter environment at: 'x') parameters size equals: 3.
	self assert: (interpreter environment at: 'x') body size equals: 0.
	self assert: (interpreter environment at: 'x') environment equals: interpreter environment.
	self assert: (interpreter environment at: 'x') parameters first equals: 'a'.
	self assert: (interpreter environment at: 'x') parameters second equals: 'b'.
	
	self interpret: 'var x = 3;var y = function(a,b,c) {x = x+1;};'.
	
	self assert: (interpreter environment at: 'y') body size equals: 1.
	self assert: (interpreter environment at: 'y') parameters third equals: 'c'.
	
	
	

]

{ #category : #tests }
JbInterpreterTest >> testPrimitives [

	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false. 
	
	self interpret: 'var x = abs(-12);'.
	self assert: (interpreter environment at: 'x') equals: 12.
	

	
	
]

{ #category : #tests }
JbInterpreterTest >> testUniaryNegation [

	self interpret: 'var x = -10;'.
	self assert: (interpreter environment at: 'x') equals: -10.
	
]
