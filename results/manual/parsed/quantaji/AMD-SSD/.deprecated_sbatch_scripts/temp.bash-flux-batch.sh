#!/bin/bash
#FLUX: --job-name="forl-proj"
#FLUX: -c=6
#FLUX: -t=900
#FLUX: --priority=16

echo $SLURM_NTASKS
module load gcc/8.2.0 python_gpu/3.10.4 cuda/11.8.0 git-lfs/2.3.0 git/2.31.1 eth_proxy cudnn/8.4.0.27
source "${SCRATCH}/.python_venv/forl-proj/bin/activate"
ray_temp_dir="${SCRATCH}/.tmp_ray"
if [ ! -d ${ray_temp_dir} ]; then
    mkdir ${ray_temp_dir}
fi
python sbatch_scripts/amd_wolfpack.py
