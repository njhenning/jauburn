Class {
	#name : #JbWhileLoopNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileLoopNode >> condition [ 
^condition
]

{ #category : #accessing }
JbWhileLoopNode >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhileLoopNode >> trueStatements: anObject [
	trueStatements := anObject
]
