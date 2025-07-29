#!/bin/bash
#SBATCH --account=project_2000599
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=00:10:00

module load geoconda
datadir=/appl/data/geo/sentinel/s2_example_data/L2A
srun python dask_multinode2.py $datadir $SLURM_JOB_ACCOUNT
