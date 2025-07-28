#!/bin/bash
#FLUX: --job-name=CANUAssembly
#FLUX: -n=200
#FLUX: --queue=defq
#FLUX: -t=1209600
#FLUX: --urgency=16

export PATH='$PATH:/home/unamur/URBE/jnarayan/CANUAssembly/canu/Linux-amd64/bin'

mkdir -p $GLOBALSCRATCH/$SLURM_JOB_ID
module load Java/1.8.0_45
module load gnuplot/4.6.6-intel-2014b
export PATH=$PATH:/home/unamur/URBE/jnarayan/CANUAssembly/canu/Linux-amd64/bin
canu -p AvagaHaploid -d AvagaHap -genomeSize=120m -pacbio-raw allPacBio_clean.fa -nanopore-raw ONT_choppedNcorrected.fa corOutCoverage=200 correctedErrorRate=0.20 -minReadLength=5000 -minOverlapLength=2500
~                             
