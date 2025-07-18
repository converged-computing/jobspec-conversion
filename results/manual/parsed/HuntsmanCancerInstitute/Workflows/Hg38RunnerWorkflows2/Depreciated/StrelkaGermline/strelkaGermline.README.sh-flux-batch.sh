#!/bin/bash
#FLUX: --job-name=sticky-puppy-1415
#FLUX: --queue=hci-rw
#FLUX: -t=345600
#FLUX: --urgency=16

set -e; start=$(date +'%s'); rm -f FAILED COMPLETE QUEUED; touch STARTED
module load singularity/3.6.4
dataBundle=/uufs/chpc.utah.edu/common/PE/hci-bioinformatics1/TNRunner
myData=/scratch/general/pe-nfs1/u0028003
tmpDir=/scratch/local/$USER/$SLURM_JOB_ID/StrelkaGermline
container=$dataBundle/Containers/public_ILLUM_SM_1.sif
echo -e "\n---------- Rsyncing ToGenotype -------- $((($(date +'%s') - $start)/60)) min"
rm -rf $tmpDir &> /dev/null || true; mkdir -p $tmpDir || true
rsync -rLq ToGenotype/ $tmpDir/ToGenotype/ && echo 'Rsync COMPLETE' || echo 'Rsync FAILED'
jobDir=$(realpath .)
echo -e "\n---------- Launching Container -------- $((($(date +'%s') - $start)/60)) min"
SINGULARITYENV_tmpDir=$tmpDir SINGULARITYENV_dataBundle=$dataBundle SINGULARITYENV_jobDir=$jobDir \
singularity exec --containall --bind $dataBundle,$myData,$tmpDir $container bash $jobDir/*.sing
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv strelkaGermline* RunScripts/
mv -f slurm* *snakemake.stats.json Logs/ &> /dev/null || true
rm -rf .snakemake STARTED RESTART* QUEUED 
