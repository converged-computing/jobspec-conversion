#!/bin/bash
#SBATCH --mail-user=noah_rousell@brown.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

export APPTAINER_BINDPATH='/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data'
export PYTHONUNBUFFERED='TRUE'

module purge
unset LD_LIBRARY_PATH
cd src
export APPTAINER_BINDPATH="/oscar/home/$USER,/oscar/scratch/$USER,/oscar/data"
export PYTHONUNBUFFERED=TRUE
srun apptainer exec --nv ../tensorflow-24.03-tf2-py3.simg python -m main --train --seed 3 --name $SLURM_JOB_NAME
