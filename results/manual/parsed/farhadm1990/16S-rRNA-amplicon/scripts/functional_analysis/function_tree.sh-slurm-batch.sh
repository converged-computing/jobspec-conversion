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
place_seqs.py -s ~/data/dss/functional_analysis/refseqs.dss.fna --placement_tool sepp -o ~/data/dss/functional_analysis/tree.function.dss.tre -p 10
cd $SLURM_SUBMIT_DIR
rm -rf /scratch/$USER/$SLURM_JOBID
