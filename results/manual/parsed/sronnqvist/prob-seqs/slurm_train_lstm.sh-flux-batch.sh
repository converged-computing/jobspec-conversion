#!/bin/bash
#FLUX: --job-name=placid-ricecake-6898
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

export DATA_DIR='data'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
export DATA_DIR=data
export OUTPUT_DIR=output
srun python model_prob_seqs.py
echo "END: $(date)"
