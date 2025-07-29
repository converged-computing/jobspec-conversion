#!/bin/bash
#SBATCH --account=GR79-29
#SBATCH --output=slurm%A_%a.out
#SBATCH --mail-user=mkmkl93@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=90000
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=[1-200]
#SBATCH --nodelist=rysy-n6

module load gpu/cuda/10.2 common/compilers/gcc/8.3.1
python3 ~/nasze-ca/src/prot-gen.py ${SLURM_ARRAY_TASK_ID}
