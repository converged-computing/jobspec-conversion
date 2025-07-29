#!/bin/bash
#SBATCH --account=phy210030p
#SBATCH --output=/ocean/projects/phy210030p/akshay2/Slurm_logs/baryfft_slurm_%j.log
#SBATCH --mail-user=akshay2
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=4

SINGULARITY_CONT=$PROJECT/psrsearch.sif
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
singularity exec -B /local $SINGULARITY_CONT $CMDDIR/baryfft.cmd
