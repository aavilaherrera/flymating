#!/usr/bin/python

import sys
import re

PRINTFLAG=False

for line in sys.stdin:
	if line.startswith('The prediction for all ancestral nodes:'):
		PRINTFLAG=True
		continue
	if line.startswith('best point:'):
		PRINTFLAG=False
		sys.exit()
	if PRINTFLAG:
		line=line.rstrip('\n\r')
		if line != '':
			hdr, seq = line.rsplit(' ',1)
			hdrf = hdr.split()
			if len(hdrf) == 2:
				hdr = hdrf[1]
			else:
				hdr = "ANC_node_"+hdrf[0]
			line = hdr + '\n' + seq
			print '>' + line

		
		

