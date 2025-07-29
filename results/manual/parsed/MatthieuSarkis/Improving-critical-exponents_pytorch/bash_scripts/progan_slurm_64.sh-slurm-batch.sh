#!/bin/bash
#SBATCH --job-name=ProGAN
#SBATCH --output=OUTPUT_%j.out
#SBATCH --error=ERROR_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=1-00:00:00
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='1'

ulimit -s unlimited
export OMP_NUM_THREADS=1
module load lang/Python
. /home/users/msarkis/git_repositories/Improving-critical-exponents_pytorch/.env/bin/activate
module load toolchain/intel
python src/progan/main.py --max_image_size 64
