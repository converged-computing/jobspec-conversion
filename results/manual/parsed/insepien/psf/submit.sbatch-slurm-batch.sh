#!/bin/bash
#SBATCH --output=submit.h%a.out
#SBATCH --mail-user=mydo@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=6G
#SBATCH --time=02:00:00
#SBATCH --partition=kipac
#SBATCH --array=91-130

source ~/setup.sh
conda activate wfsim
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightPsfws --outfile outh_psfws_$SLURM_ARRAY_TASK_ID.pkl --usePsfws
python simtest.py --atmSeed $SLURM_ARRAY_TASK_ID --outdir heightRand --outfile outh_rand_$SLURM_ARRAY_TASK_ID.pkl --useRand
