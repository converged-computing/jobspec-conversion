#!/bin/bash
#SBATCH --account=ctb-lcharlin
#SBATCH --output=/home/haolun/projects/def-cpsmcgil/haolun/GPR4DUR/exp_out/online_gpu2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=40000M
#SBATCH --time=1-00:00:00

source /home/haolun/projects/def-cpsmcgil/haolun/GPR4DUR/venv_gpr4dur/bin/activate
module load cuda
nvidia-smi
python3 /home/haolun/projects/def-cpsmcgil/haolun/GPR4DUR/synthetic/synthetic_GPR_browsing.py
deactivate
