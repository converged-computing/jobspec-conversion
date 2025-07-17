#!/bin/bash
#FLUX: --job-name=phat-frito-2960
#FLUX: -n=10
#FLUX: --queue=ghpc
#FLUX: -t=86400
#FLUX: --urgency=16

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
place_seqs.py -s ~/data/dss/functional_analysis/refseqs.dss.fna --placement_tool sepp -o ~/data/dss/functional_analysis/tree.function.dss.tre -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
