Red/System [
	Title:   "Port! datatype runtime functions"
	Author:  "Nenad RAKOCEVIC"
	File: 	 %port.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2018 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

port: context [
	verbose: 0

	;-- actions --
	
	make: func [
		proto	[red-value!]
		spec	[red-value!]
		type	[integer!]
		return:	[red-object!]
		/local
			new		[red-object!]
	][
		#if debug? = yes [if verbose > 0 [print-line "port/make"]]

		new: as red-object! stack/push*

		object/copy
			as red-object! #get system/standard/port
			as red-object! new
			null
			no
			null

		new/class:  0
		new/on-set: null
		
		new: object/make new spec type
		new/header: TYPE_PORT							;-- implicit reset of all header flags
		new/class:  0
		new
	]

	form: func [
		obj		[red-object!]
		buffer	[red-string!]
		arg		[red-value!]
		part 	[integer!]
		return:	[integer!]
	][
		#if debug? = yes [if verbose > 0 [print-line "port/form"]]

		mold obj buffer no no no arg part 0
	]

	mold: func [
		obj		[red-object!]
		buffer	[red-string!]
		only?	[logic!]
		all?	[logic!]
		flat?	[logic!]
		arg		[red-value!]
		part	[integer!]
		indent	[integer!]
		return: [integer!]
	][
		#if debug? = yes [if verbose > 0 [print-line "port/mold"]]

		string/concatenate-literal buffer "make port! ["
		part: object/serialize obj buffer only? all? flat? arg part - 13 yes indent + 1 yes
		if indent > 0 [part: object/do-indent buffer indent part]
		string/append-char GET_BUFFER(buffer) as-integer #"]"
		part - 1
	]

	init: does [
		datatype/register [
			TYPE_PORT
			TYPE_OBJECT
			"port!"
			;-- General actions --
			:make			;make
			null			;random
			INHERIT_ACTION	;reflect
			null			;to
			:form
			:mold
			null			;eval-path
			null			;set-path
			INHERIT_ACTION	;compare
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
			INHERIT_ACTION	;copy
			INHERIT_ACTION	;find
			null			;head
			null			;head?
			null			;index?
			null			;insert
			null			;length?
			null			;move
			null			;next
			null			;pick
			null			;poke
			null			;put
			null			;remove
			null			;reverse
			INHERIT_ACTION	;select
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
]