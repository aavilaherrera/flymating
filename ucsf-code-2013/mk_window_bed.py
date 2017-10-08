#!/usr/bin/python
''' reads a one-line bed file
	turns the range specified in columns 2 and 3
	into a series of ranges of at least window size n
'''

import sys

def parseBed(bedfile_fn):
	bedfile = open(bedfile_fn, 'r')
	line = [ line.rstrip('\n\r') for line in bedfile.readlines() if not line.startswith('#') ][0]
	chrom, rangeStart, rangeEnd = line.split()
	return (chrom, int(rangeStart), int(rangeEnd))

def mkwindows(rangeStart, rangeEnd, windowSize):
	if not windowSize % 2:
		sys.exit("windowSize is even")
	return ((a, a+windowSize) for a in xrange(rangeStart, rangeEnd-windowSize+1))

def mainloop(bedfn, windowSize):
	chrom, rangeStart, rangeEnd = parseBed(bedfn)
	for start, end in mkwindows(rangeStart, rangeEnd, windowSize):
		print '\t'.join(map(str, (chrom, start, end)))

if __name__ == '__main__':
	if(len(sys.argv) != 3):
		print >>sys.stderr, "usage: %s bedfn windowsize > windowedbed"
		sys.exit(1)
	bedfn = sys.argv[1]
	windowSize = int(sys.argv[2])
	mainloop(bedfn, windowSize)





