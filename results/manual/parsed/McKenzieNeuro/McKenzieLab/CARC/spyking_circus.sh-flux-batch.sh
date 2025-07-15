#!/bin/bash
#FLUX: --job-name=goodbye-bicycle-0790
#FLUX: -c=8
#FLUX: --queue=neuro-hsc
#FLUX: -t=36000
#FLUX: --urgency=16

datadir="/carc/scratch/projects/mckenzie2016183/data/spikeSorting/spikeDemo"
module load parallel
module load miniconda3
module load matlab/R2022a
find $datadir -name "*.dat" | parallel --jobs $SLURM_NTASKS --joblog $SLURM_JOB_NAME.joblog --resume /carc/scratch/projects/mckenzie2016183/code/BASH/run_circus.sh {}
