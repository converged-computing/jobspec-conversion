#!/bin/bash
#SBATCH --job-name=NACO-CQTau
#SBATCH --account=pd87
#SBATCH --output=pipeline_output%j.out
#SBATCH --error=pipeline_output_error%j.err
#SBATCH --mail-user=<iain.hammond@monash.edu>
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=8000
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='$OMP_NUM_THREADS'
export MKL_NUM_THREADS='$OMP_NUM_THREADS'

module load cuda
nvidia-smi
deviceQuery
env # print environmental variables if you wish, good for debugging
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=$OMP_NUM_THREADS
export MKL_NUM_THREADS=$OMP_NUM_THREADS
source /home/ihammond/miniconda3/etc/profile.d/conda.sh # initialise conda shell
conda activate VIPenv # activate personal VIP conda environment
ulimit -s unlimited # recommended by M3 support team to prevent stack size memory error
python run_script.py # runs the script
