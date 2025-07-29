#!/bin/bash
#SBATCH --job-name=myDrQA
#SBATCH --output=output/slurm_%j.out
#SBATCH --mail-user=jp.park@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem=64GB
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export CLASSPATH='$CLASSPATH:$SCRATCH/data/corenlp/*'

module purge
module load cuda/9.0.176
module load cudnn/9.0v7.0.5 
module load gcc/6.3.0
RUNDIR=$SCRATCH/my_project/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
SRCDIR=$SCRATCH/DrQA/scripts/pipeline/
cd $RUNDIR
export CLASSPATH=$CLASSPATH:$SCRATCH/data/corenlp/*
$HOME/anaconda3/bin/python $SRCDIR/interactive.py < $SCRATCH/DrQA/input.txt 
