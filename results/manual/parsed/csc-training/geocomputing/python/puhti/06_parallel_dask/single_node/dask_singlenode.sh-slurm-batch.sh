#!/bin/bash
#SBATCH --account=project_200xxxx
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --mem=6G
#SBATCH --time=00:05:00

module load geoconda
datadir=/appl/data/geo/sentinel/s2_example_data/L2A
srun python dask_singlenode.py $datadir
