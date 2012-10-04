Red/System [
	Title:   "Action! datatype runtime functions"
	Author:  "Nenad Rakocevic"
	File: 	 %action.reds
	Rights:  "Copyright (C) 2011 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt
	}
]

action: context [
	verbose: 0
	
	push: func [
		/local
			cell  [red-action!]
	][
		#if debug? = yes [if verbose > 0 [print-line "action/push"]]
		
		cell: as red-action! stack/push
		cell/header: TYPE_ACTION
		;...TBD
	]
	
	;-- Actions -- 
	
	make: func [
		return:    [red-value!]						;-- return action cell pointer
		/local
			arg	   [red-value!]
			action [red-action!]
			spec   [red-block!]
	][
		#if debug? = yes [if verbose > 0 [print-line "action/make"]]

		arg:    stack/arguments
		action: as red-action! arg
		spec:   as red-block!  arg + 1
		
		assert TYPE_OF(spec) = TYPE_BLOCK
		
		action/header:  TYPE_ACTION					;-- implicit reset of all header flags
		action/spec:    spec/node					; @@ copy spec block if not at head
		;action/symbols: clean-spec spec 			; @@ TBD
		
		as red-value! action
	]
	
	form: func [
		part	[integer!]
		return: [integer!]
		/local
			str [red-string!]
	][
		#if debug? = yes [if verbose > 0 [print-line "action/form"]]

		str: as red-string! stack/arguments + 1
		assert TYPE_OF(str) = TYPE_STRING

		string/concatenate-literal str "?action?"
		part											;@@ implement full support for /part
	]

	datatype/register [
		TYPE_ACTION
		;-- General actions --
		:make
		null			;random
		null			;reflect
		null			;to
		:form
		null			;mold
		null			;get-path
		null			;set-path
		null			;compare
		;-- Scalar actions --
		null			;absolute
		null			;add
		null			;divide
		null			;multiply
		null			;negate
		null			;power
		null			;remainder
		null			;round
		null			;subtract
		null			;even?
		null			;odd?
		;-- Bitwise actions --
		null			;and~
		null			;complement
		null			;or~
		null			;xor~
		;-- Series actions --
		null			;append
		null			;at
		null			;back
		null			;change
		null			;clear
		null			;copy
		null			;find
		null			;head
		null			;head?
		null			;index-of
		null			;insert
		null			;length-of
		null			;next
		null			;pick
		null			;poke
		null			;remove
		null			;reverse
		null			;select
		null			;sort
		null			;skip
		null			;swap
		null			;tail
		null			;tail?
		null			;take
		null			;trim
		;-- I/O actions --
		null			;create
		null			;close
		null			;delete
		null			;modify
		null			;open
		null			;open?
		null			;query
		null			;read
		null			;rename
		null			;update
		null			;write
	]
]