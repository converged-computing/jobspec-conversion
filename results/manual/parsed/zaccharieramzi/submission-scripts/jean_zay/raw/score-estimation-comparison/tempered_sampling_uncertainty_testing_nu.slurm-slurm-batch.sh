#!/bin/bash
#SBATCH --job-name=tempered_sampling
#SBATCH --output=tempered_sampling%A_%a.out
#SBATCH --error=tempered_sampling%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-2

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_nofc_3scales'
export FIGURES_DIR='$SCRATCH/nsec_figures/tempered_sampling_testing_nu_nofc_3scales_sn${opt[$SLURM_ARRAY_TASK_ID]}'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
opt[0]="1.2"
opt[1]="0.7"
opt[2]="0.5"
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_nofc_3scales
export FIGURES_DIR=$SCRATCH/nsec_figures/tempered_sampling_testing_nu_nofc_3scales_sn${opt[$SLURM_ARRAY_TASK_ID]}
srun python ./nsec/mri/tempered_sampling_reconstruction.py -n 1000 -b 2 -c CORPD_FBK -sn 2.0  -nps 50 --no-fcon -sc 3 -nr 7 -e 10 -dcs 0.1 -si 100 -nu ${opt[$SLURM_ARRAY_TASK_ID]}
