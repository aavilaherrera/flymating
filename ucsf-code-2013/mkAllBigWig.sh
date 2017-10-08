#!/bin/bash

echo "converting bed to bedGraph"

for i in gr??a/gr??a_regulatory-region_windows*allBranches.phylop_out; do
	bash mkBedGraphLOGTX.sh ${i} 1,2,3,7 > ${i}.bedGraph
done

for i in gr??a/gr??a_regulatory-region_windows*dm3.phylop_out; do
	bash mkBedGraphLOGTX.sh ${i} 1,2,3,9 > ${i}.bedGraph
done

echo "concatenating bedGraphs"
cat gr??a/gr??a_regulatory-region_windows-lrt-conacc-allBranches.phylop_out.bedGraph > grXXa_regulatory-region_windows-lrt-conacc-allBranches.phylop_out.bedGraph
cat gr??a/gr??a_regulatory-region_windows-lrt-conacc-dm3.phylop_out.bedGraph > grXXa_regulatory-region_windows-lrt-conacc-dm3.phylop_out.bedGraph

echo "concatenating wiggles"
cat gr??a/gr??a_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out > grXXa_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out.wiggle
cat gr??a/gr??a_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out > grXXa_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out.wiggle

echo "converting to BigWig"
bedGraphToBigWig grXXa_regulatory-region_windows-lrt-conacc-allBranches.phylop_out.bedGraph dm3.chrom.sizes grXXa_regulatory-region_windows-lrt-conacc-allBranches.phylop_out.bigWig
bedGraphToBigWig grXXa_regulatory-region_windows-lrt-conacc-dm3.phylop_out.bedGraph dm3.chrom.sizes grXXa_regulatory-region_windows-lrt-conacc-dm3.phylop_out.bigWig

wigToBigWig grXXa_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out.wiggle dm3.chrom.sizes grXXa_regulatory-region_wiggle-lrt-conacc-allBranches.phylop_out.bigWig
wigToBigWig grXXa_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out.wiggle dm3.chrom.sizes grXXa_regulatory-region_wiggle-lrt-conacc-dm3.phylop_out.bigWig


