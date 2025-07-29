#!/bin/bash
#SBATCH --job-name=stud_exp
#SBATCH --mail-user=sreerag.naveenachandran@tu-braunschweig.de
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2-00:00:00

source activate studiarbeit
nvidia-smi
echo -e "Node: $(hostname)"
echo -e "Job internal GPU id(s): $CUDA_VISIBLE_DEVICES"
echo -e "Job external GPU id(s): ${SLURM_JOB_GPUS}"
srun python -u main.py
