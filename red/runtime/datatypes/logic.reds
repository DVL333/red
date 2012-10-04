Red/System [
	Title:   "Logic! datatype runtime functions"
	Author:  "Nenad Rakocevic"
	File: 	 %logic.reds
	Rights:  "Copyright (C) 2011 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt
	}
]

true-value: declare red-logic!							;-- preallocate TRUE value
true-value/header: TYPE_LOGIC
true-value/value: true

false-value: declare red-logic!							;-- preallocate FALSE value
false-value/header: TYPE_LOGIC
false-value/value: false


logic: context [
	verbose: 0
		
	true?: func [
		return:  [logic!]
		/local
			arg	 [red-logic!]
			type [integer!]
	][
		#if debug? = yes [if verbose > 0 [print-line "logic/true?"]]
		arg: as red-logic! stack/last-value
		type: TYPE_OF(arg)
		
		not any [										;-- true if not none or false
			type = TYPE_NONE
			all [type = TYPE_LOGIC not arg/value]
		]	
	]
	
	;-- Actions -- 

	make: func [
		return:	 [red-value!]							;-- return cell pointer
		/local
			cell [red-logic!]
			args [red-value!]
			id	 [red-integer!]
	][
		#if debug? = yes [if verbose > 0 [print-line "logic/make"]]

		args: stack/arguments
		cell: as red-logic! args
		id: as red-integer! args + 1
		
		assert TYPE_OF(cell) = TYPE_DATATYPE
		assert TYPE_OF(id)   = TYPE_INTEGER
		
		cell/header: TYPE_LOGIC							;-- implicit reset of all header flags
		cell/value: id/value <> 0
		as red-value! cell
	]
	
	form: func [
		part	 [integer!]
		return:  [integer!]
		/local
			str	 [red-string!]
			size [integer!]
	][
		#if debug? = yes [if verbose > 0 [print-line "logic/form"]]

		boolean: as red-logic! stack/arguments
		str: as red-string! boolean + 1
		assert TYPE_OF(str) = TYPE_STRING

		string/concatenate-literal str either boolean/value ["true"]["false"]
		part											;@@ implement full support for /part
	]
	
	compare: func [
		arg1      [red-logic!]							;-- first operand
		arg2	  [red-logic!]							;-- second operand
		op	      [integer!]							;-- type of comparison
		return:   [logic!]
		/local
			type  [integer!]
			res	  [logic!]
	][
		#if debug? = yes [if verbose > 0 [print-line "logic/compare"]]

		type: TYPE_OF(arg2)
		switch op [
			COMP_EQUAL 			[res:     all [type = TYPE_LOGIC arg1/value = arg2/value]]
			COMP_STRICT_EQUAL	[res: not all [type = TYPE_LOGIC arg1/value = arg2/value]]
			default [
				print-line ["Error: cannot use: " op " on logic!"]
			]
		]
		res
	]
	
	datatype/register [
		TYPE_LOGIC
		;-- General actions --
		:make
		null			;random
		null			;reflect
		null			;to
		:form
		null			;mold
		null			;get-path
		null			;set-path
		:compare
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