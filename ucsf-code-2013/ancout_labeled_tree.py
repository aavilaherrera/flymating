#!/usr/bin/python

import sys
import re

PRINTFLAG=False

for line in sys.stdin:
	if line.startswith('The tree structure:'):
		PRINTFLAG=True
		continue
	if PRINTFLAG:
		print line.rstrip('\n\r')

