#!/bin/bash
#SBATCH --job-name=recon_map_mri
#SBATCH --output=recon_map_mri%A_%a.out
#SBATCH --error=recon_map_mri%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-5
#SBATCH --dependency=379904

export FASTMRI_DATA_DIR='$SCRATCH/'
export CHECKPOINTS_DIR='$SCRATCH/nsec_complex'
export FIGURES_DIR='$SCRATCH/nsec_figures/map_recon_hd_sn${opt[$SLURM_ARRAY_TASK_ID]}/'

set -x
cd $WORK/score-estimation-comparison
module purge
conda deactivate fastmri-tf-2.1.0
module load tensorflow-gpu/py3/2.3.0
opt[0]='0.1'
opt[1]='0.5'
opt[2]='1.0'
opt[3]='2.0'
opt[4]='5.0'
opt[5]='10.0'
export FASTMRI_DATA_DIR=$SCRATCH/
export CHECKPOINTS_DIR=$SCRATCH/nsec_complex
export FIGURES_DIR=$SCRATCH/nsec_figures/map_recon_hd_sn${opt[$SLURM_ARRAY_TASK_ID]}/
srun python ./nsec/mri/map_reconstruction.py -n 1000000 -b 2 -c CORPD_FBK -nps 50 -h -e 0.000001 -sn ${opt[$SLURM_ARRAY_TASK_ID]}
