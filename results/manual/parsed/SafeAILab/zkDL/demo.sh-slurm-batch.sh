#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=v100l:1
#SBATCH --mem=32000M
#SBATCH --time=00:00:59

set -e  # Exit immediately if a command exits with a non-zero status
module load gcc cuda/11.4 cmake protobuf cudnn python/3.10
virtualenv --no-download --clear $SLURM_TMPDIR/ENV && source $SLURM_TMPDIR/ENV/bin/activate
pip install torch numpy
python model.py
make clean
make demo
./demo traced_model.pt sample_input.pt
