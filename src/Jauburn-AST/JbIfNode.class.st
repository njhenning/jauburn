Class {
	#name : #JbIfNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfNode >> condition [
	^ condition
]

{ #category : #accessing }
JbIfNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbIfNode >> evaluateIn: environment [ 

 ^ (environment at: condition) evaluate: trueStatements.
]

{ #category : #accessing }
JbIfNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbIfNode >> trueStatements: anObject [
	trueStatements := anObject
]
