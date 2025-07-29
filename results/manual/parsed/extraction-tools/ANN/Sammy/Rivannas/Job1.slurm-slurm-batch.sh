#!/bin/bash
#SBATCH --account=spinquest
#SBATCH --output=sammyTest_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=standard

module purge
module load anaconda/2019.10-py3.7
module load singularity
module load tensorflow/2.1.0-py37
singularity run --nv /home/$USER/tensorflow-2.1.0-py37.sif /home/sl8rn/Rivannas/General2.py ${SLURM_ARRAY_TASK_ID}
