#!/usr/bin/python
''' fasta --> paml-friendly phylip
				header and sequence on one line
				header is 8chrs alphanum + '_-'
				header and sequence separated by two spaces

'''

import sys
import re

def rdfa(fh):
	ali = dict()
	header = ''
	seq = ''

	for line in fh:
		line = line.rstrip('\n\r')
		if line == '':
			continue
		if line.startswith('>'):
			if header != '':
				ali[header] = re.sub("\s+", "", seq) # remove whitespace
				seq = ''
			header = line[1:].split(' ', 1)[0] #get header, lose comment
			continue
		seq += line
	ali[header] = re.sub("\s+", "", seq) # remove whitespace
	return ali

def prntphy(fh, ali):
	nseqs = len(ali)
	seqlen = len(ali.itervalues().next())
	print >>fh, ' %d %d' % (nseqs, seqlen)
	for h,s in ali.iteritems():
		new_h = re.sub("[^A-Za-z0-9_-]", "_", h)[0:8].ljust(8)
		print >>fh, new_h + '  ' + s
		print >>sys.stderr, '\t'.join((h, new_h))

if __name__ == "__main__":
	if "-h" in sys.argv:
		print >>sys.stderr, 'usage: %s < fa > paml'%sys.argv[0]
		sys.exit(1)
	prntphy(sys.stdout, rdfa(sys.stdin))
