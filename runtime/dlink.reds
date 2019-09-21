Red/System [
	Title:	"Doubly Linked List implementation"
	Author: "Xie Qingtian"
	File: 	%dlink.reds
	Tabs:	4
	Rights: "Copyright (C) 2017 Xie Qingtian. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

list-entry!: alias struct! [
	next	[list-entry!]
	prev	[list-entry!]
]

dlink: context [
	init: func [
		list	[list-entry!]
	][
		list/next: list
		list/prev: list
	]

	insert: func [
		list	[list-entry!]
		entry	[list-entry!]
	][
		insert-next list entry
	]

	append: func [
		list	[list-entry!]
		entry	[list-entry!]
	][
		insert-next list/prev entry
	]

	insert-next: func [
		"insert an entry next to the node entry"
		node	[list-entry!]
		entry	[list-entry!]
	][
		node/next/prev: entry
		entry/next: node/next
		entry/prev: node
		node/next: entry
	]

	remove: func [
		"remove an entry next to the node entry"
		entry	[list-entry!]
		return:	[list-entry!]
	][
		remove-entry entry/prev entry/next
	]

	remove-head: func [
		list	[list-entry!]
		return:	[list-entry!]
	][
		remove-entry list list/next/next
	]

	remove-last: func [
		list	[list-entry!]
		return:	[list-entry!]
	][
		remove-entry list/prev/prev list
	]

	remove-entry: func [
		"remove an entry between entry1 and entry2"
		entry1	[list-entry!]
		entry2	[list-entry!]
		return:	[list-entry!]
		/local
			p	[list-entry!]
	][
		p: entry1/next
		entry1/next: entry2
		entry2/prev: entry1
		p
	]

	clear: func [
		list	[list-entry!]
		/local
			p	[list-entry!]
			q	[list-entry!]
	][
		p: list/next
		while [p <> list][
			q: p/next
			free as byte-ptr! p
			p: q
		]
		list/next: list
		list/prev: list
	]

	empty?: func [
		list	[list-entry!]
		return:	[logic!]
	][
		either all [
			list/next = list
			list/prev = list
		][true][false]
	]

	length?: func [
		list	[list-entry!]
		return:	[integer!]
		/local
			entry	[list-entry!]
			p		[list-entry!]
			len		[integer!]
	][
		len: 0
		entry: list/next
		while [entry <> list][
			len: len + 1
			entry: entry/next
		]
		len
	]
]