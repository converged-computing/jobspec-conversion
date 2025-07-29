#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.out
#SBATCH --error=myjob.err
#SBATCH --mail-user=dreambetter@gmail.com
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

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
