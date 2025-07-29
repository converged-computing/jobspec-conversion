#!/bin/bash
#SBATCH --job-name=sampling_mri
#SBATCH --output=sampling_mri%A_%a.out
#SBATCH --error=sampling_mri%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_no_sn'
export FIGURES_DIR='$SCRATCH/nsec_figures/sampling_no_sn_hd'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_no_sn
export FIGURES_DIR=$SCRATCH/nsec_figures/sampling_no_sn_hd
srun python ./nsec/mri/sampling.py -ns 100000 -b 2 -c CORPD_FBK -sn 0. --nps-train 50.0
