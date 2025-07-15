#!/bin/bash
#FLUX: --job-name=quirky-underoos-4217
#FLUX: --queue=hci-rw
#FLUX: --priority=16

udocker=/uufs/chpc.utah.edu/common/HIPAA/u0028003/BioApps/UDocker/udocker-1.1.1/udocker
mount=/scratch/mammoth/serial/u0028003/
set -e; start=$(date +'%s')
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
name=${PWD##*/}
tumor=`readlink -f tumor.bam`
normal=`readlink -f normal.bam`
jobDir=`readlink -f .`
echo -e "\n---------- Launching Container -------- $((($(date +'%s') - $start)/60)) min"
$udocker run \
--env=tumor=$tumor --env=normal=$normal --env=name=$name --env=jobDir=$jobDir \
--volume=$mount:$mount \
SnakeMakeBioApps_1 < somExoCaller_*.udocker
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
mkdir -p RunScripts
mv somExoCaller* RunScripts/
mv *_SnakemakeRun.log Logs/
mv slurm* Logs/
rm -rf .snakemake
