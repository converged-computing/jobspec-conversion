#!/bin/bash
#FLUX: --job-name=misunderstood-latke-8549
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=259200
#FLUX: --urgency=16

export MALLOC_ARENA_MAX='4'

export MALLOC_ARENA_MAX=4
module load java/default
module load cuda/default
module load matlab/R2019b
module load openmpi/gnu
source ~/OpenFOAM-plus/etc/bashrc
destFolderName="/scratch/jkrusk2s/sailCFD/"
baseFolderName="/home/jkrusk2s/Code/sail/domains/escooter/pe/v1906/"
nCases=10;
startCase=200;
for (( i=$startCase; i<$startCase+$nCases; i++ ))
do
	caseName=$destFolderName"case$i"
	echo $caseName
    rm -rf $caseName
	cp -TR $baseFolderName $caseName
	sbatch -D "$caseName" $caseName/submit.sh
done 
matlab -batch "escooter_runSail('nCases',$nCases,'caseStart',$startCase)"
for (( i=$startCase; i<$startCase+$nCases; i++ ))
do
    caseName=$destFolderName"case$i"
	touch "$caseName/stop.signal"
done 
