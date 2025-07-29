#!/bin/bash
#SBATCH --job-name=dr_default
#SBATCH --account=sscheid1_deep_replication
#SBATCH --output=/scratch/adidishe/fop/out/FOP.out
#SBATCH --error=/scratch/adidishe/fop/out/FOP.err
#SBATCH --mail-user=antoine.didisheim@unil.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --chdir=/scratch/adidishe/fop

module purge
module load my list of modules
module load cuda
nvidia-smi
module load gcc/9.3.0 python/3.8.8
source /work/FAC/HEC/DF/sscheid1/deep_replication/sq/venv/bin/activate
python3 /scratch/adidishe/fop/get_forecast.py
