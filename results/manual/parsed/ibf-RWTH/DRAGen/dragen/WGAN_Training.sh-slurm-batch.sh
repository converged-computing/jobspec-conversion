#!/bin/bash
#SBATCH --job-name=WGAN
#SBATCH --output=WGAN.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00

export PATH='$CONDA_ROOT/bin:$PATH'

source $HOME/miniconda3/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate WGAN
module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
python run_cwgangp.py
