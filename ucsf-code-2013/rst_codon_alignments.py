#!/usr/bin/python

import sys
import re

PRINTFLAG=False
skip=0

for line in sys.stdin:
	if line.startswith('List of extant and reconstructed sequences'):
		PRINTFLAG=True
		continue
	if line.startswith('Overall accuracy of the'):
		PRINTFLAG=False
		sys.exit()
	if PRINTFLAG:
		if skip > 2:
			line=line.rstrip('\n\r')
			if line != '':
				line = re.sub('\s\s+','\n', line)
				hdr, seq = line.split('\n')
				line = re.sub('\s+', '_', hdr) + '\n' + seq
				print '>' + line
		else:
			skip += 1

		
		

