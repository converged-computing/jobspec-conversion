#!/bin/bash
#SBATCH --job-name=gpu_mono
#SBATCH --output=cfht2hst_parametric%j.out
#SBATCH --error=cfht2hst_parametric%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=08:00:00

export OMP_NUM_THREADS='10'

module purge
module load tensorflow-gpu/py3/1.15.2
set -x
export OMP_NUM_THREADS=10
/gpfswork/rech/xdy/uze68md/GitHub/galaxy2galaxy/galaxy2galaxy/bin/g2g-datagen --problem=attrs2img_cosmos_parametric_cfht2hst --data_dir=$WORK/data/attrs2img_cosmos_parametric_cfht2hst --tmp_dir=$WORK/data/
