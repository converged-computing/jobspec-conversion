#!/bin/bash
#SBATCH --job-name=netflix
#SBATCH --output=netflix_%j.out
#SBATCH --mail-user=rrs480@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python3/intel/3.6.3
module load cuda/9.2.88
module load tensorflow/python3.6/1.5.0
COREDIR=$SCRATCH/netflix/core/
LOCALPY=$SCRATCH/netflix/bin/python3.6
RUNDIR=$SCRATCH/netflix-runs/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cp -r $COREDIR/* $RUNDIR/.
OUTDIR=$RUNDIR/results
$LOCALPY $RUNDIR/main.py
