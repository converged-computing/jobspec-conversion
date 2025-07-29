#!/bin/bash
#SBATCH --job-name=gpu_mono
#SBATCH --output=meerkat_3600%j.out
#SBATCH --error=meerkat_3600%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00

export OMP_NUM_THREADS='30'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export OMP_NUM_THREADS=30
/gpfswork/rech/xdy/uze68md/GitHub/galaxy2galaxy/galaxy2galaxy/bin/g2g-datagen --problem=meerkat_3600 --data_dir=$WORK/data/meerkat_3600 --tmp_dir=$WORK/data/
