#!/bin/bash
#FLUX: --job-name=spicy-toaster-6593
#FLUX: -n=160
#FLUX: --exclusive
#FLUX: --queue=sandyb,westmere,bigmem,amd
#FLUX: -t=14400
#FLUX: --urgency=16

module load parallel
srun="srun --exclusive -N1 -n1 -c2"
parallel="parallel -j $SLURM_NTASKS --joblog log/parallel.log --resume"
$parallel "$srun ./hadisd.sh {1} &> log/{.}.log" :::: hadisd2012.files
