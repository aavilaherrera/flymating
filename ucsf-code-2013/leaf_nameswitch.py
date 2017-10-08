#!/usr/bin/python
''' reads a tab, replaces field 1 with field 2 in input (hopefully newick string)

'''

import sys
import re

def read_tab(fh):
	tab = dict()
	for line in fh:
		line = line.rstrip('\n\r')
		if line == '':
			continue
		if line.startswith('#'):
			continue
		(f1, f2) = line.split('\t')[:2]
		tab[f1] = f2
	return tab

def read_tree(fh):
	nw_string = ''.join([ line.rstrip('\n\r') for line in fh.readlines() ])
	return nw_string

def name_switch(nw_string, tab):
	def nm_swch(matchobj):
		f1 = matchobj.group(1)
		if f1 in tab:
			f2 = tab[f1]
			return f2
		return f1
	return re.sub('(\w+)', nm_swch, nw_string) 

if __name__ == "__main__":
	if len(sys.argv) != 2:
		sys.exit("usage: %s tab < intree > outtree"%sys.argv[0])
	tab = read_tab(open(sys.argv[1], 'r'))
	nw_string = read_tree(sys.stdin)
	print name_switch(nw_string, tab)

