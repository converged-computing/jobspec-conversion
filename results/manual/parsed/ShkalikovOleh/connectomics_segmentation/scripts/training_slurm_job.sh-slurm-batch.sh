#!/bin/bash
#SBATCH --job-name=training
#SBATCH --account=p_pixel
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=48G
#SBATCH --time=12:00:00
#SBATCH --partition=alpha
#SBATCH --constraint=ntasks-per-node=1

export $(cut -d=' -f1 "$CFG_FILE")'

module switch release/23.04
module load GCCcore/12.2.0
module load Python/3.10.8
module load CUDA/11.8.0
nvidia-smi
CFG_FILE=$1
source "$CFG_FILE"
export $(cut -d= -f1 "$CFG_FILE")
source $VENV_DIR/bin/activate
python -m connectomics_segmentation.train "${@:2}"
