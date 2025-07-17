#!/bin/bash
#FLUX: --job-name=creamy-leader-2894
#FLUX: -n=10
#FLUX: --queue=ghpc
#FLUX: -t=86400
#FLUX: --urgency=16

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
hsp.py -i EC -t ~/data/dss/functional_analysis/tree.function.dss.tre -o ~/data/dss/functional_analysis/EC_predicted_genom_DSS.tsv.gz -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
