#!/usr/bin/python
''' codon_align.py -- uses protein alignment to guide CDS alignment
	usage: codon_align.py protein-msa.fa cds.fa > cds-msa.fa

'''

import sys

print "ORDER MUST BE THE SAME; SAFEGUARDS NOT IN PLACE"
#sys.exit("don't use this script yet")



def rdfa(fh):
	seqs = list()
	seq = ''
	header = ''
	for line in fh:
		line = line.rstrip('\n\r')
		if line == '':
			continue
		if line[0] == '>':
			if seq == '':
				header = line
				continue
			seqs.append((header, seq))
			seq = ''
			header = line
		else:
			seq += line
	seqs.append((header, seq))
	return seqs

def codalign(p_seqs, n_seqs):
	an_seqs = list()
	for x,(header, ps) in enumerate(p_seqs):
		h2, ns = n_seqs[x]
		ali_ns = ''
		for char in ps:
			if char == '-':
				ali_ns += '---'
			else:
				a_ns, ns = strpop(ns, 0,3)
				ali_ns += a_ns
		an_seqs += [(header, ali_ns)]
	return an_seqs

def strpop(string, start, stop):
	return string[start:stop], string[stop:]

def prntali(an_seqs):
	for h,s in an_seqs:
		print h
		print s.upper()

if __name__ == "__main__":
	pfh = open(sys.argv[1], 'r')
	nfh = open(sys.argv[2], 'r')

	p_seqs = rdfa(pfh)
	n_seqs = rdfa(nfh)
	
	an_seqs = codalign(p_seqs, n_seqs)
	prntali(an_seqs)
	

