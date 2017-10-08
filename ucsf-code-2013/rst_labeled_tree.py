#!/usr/bin/python

import sys

PRINTFLAG=False

for line in sys.stdin:
	if line.startswith("tree with node labels for Rod Page's TreeView"):
		PRINTFLAG=True
		continue
	if PRINTFLAG:
		print line.rstrip('\n\r')
		sys.exit()
