#!/bin/bash
#SBATCH --job-name=DrQA_preprocess
#SBATCH --output=output/preprocess_%j.out
#SBATCH --mail-user=jp.park@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64GB
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

export CLASSPATH='$CLASSPATH:$SCRATCH/data/corenlp/*'

module purge
module load cuda/9.0.176
module load cudnn/9.0v7.0.5 
module load gcc/6.3.0
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
SRCDIR=$SCRATCH/DrQA/scripts/reader/
cd $RUNDIR
export CLASSPATH=$CLASSPATH:$SCRATCH/data/corenlp/*
$HOME/anaconda3/bin/python $SRCDIR/preprocess.py $SCRATCH/DrQA/data/datasets/ $SCRATCH/DrQA/data/processed --split="SQuAD-v1.1-dev"
