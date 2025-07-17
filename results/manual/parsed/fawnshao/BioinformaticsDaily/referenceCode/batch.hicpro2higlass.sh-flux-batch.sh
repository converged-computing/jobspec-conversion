#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: --queue=normal
#FLUX: -t=28800
#FLUX: --urgency=16

export PATH='~/myTools/HiChIP/HiC-Pro/bin/utils/:$PATH'
export PYTHONPATH=''

export PATH=~/myTools/HiChIP/HiC-Pro/bin/utils/:$PATH
export PYTHONPATH=""
genomesize=/home1/04935/shaojf/myTools/HiChIP/HiC-Pro/annotation/chrom_hg19.sizes
source activate py36
for f in *_allValidPairs
do
	hicpro2higlass.sh -i $f -r 5000 -c $genomesize 1> $f.log 2>&1 &
	sleep 10m
done
source deactivate py36
for f in *_allValidPairs
do
	~/Documents/GitHub/HiC-Pro/bin/utils/hicpro2higlass.sh -i $f -r 5000 -c hg19.chrom.sizes
done
