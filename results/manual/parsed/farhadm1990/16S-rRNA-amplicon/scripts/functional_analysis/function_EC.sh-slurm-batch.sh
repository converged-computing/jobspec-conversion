#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=120G
#SBATCH --time=1-00:00:00
#SBATCH --partition=ghpc

TMPDIR=/scratch/$USER/$SLURM_JOBID
export TMPTDIR
mkdir -p $TMPDIR
source activate picrust2
hsp.py -i EC -t ~/data/dss/functional_analysis/tree.function.dss.tre -o ~/data/dss/functional_analysis/EC_predicted_genom_DSS.tsv.gz -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
