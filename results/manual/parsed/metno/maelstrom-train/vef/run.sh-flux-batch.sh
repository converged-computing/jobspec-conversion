#!/bin/bash
#FLUX: --job-name=maelstrom-vef
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=24
#FLUX: --queue=booster
#FLUX: -t=1800
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export LD_PRELOAD='/p/home/jusers/nipen1/juwels/local/lib/libvefprospector_full.so'
export files='/p/scratch/deepacf/maelstrom/maelstrom_data/ap1/air_temperature//5TB/202???01T*.nc '

cd ..
module load Stages/2022 && module load GCCcore/.11.2.0 && module load TensorFlow/2.6.0-CUDA-11.5 && module load GCC/11.2.0 && module load OpenMPI/4.1.2 && module load mpi4py/3.1.3 && module load Horovod/0.24.3; source /p/project/deepacf/maelstrom/nipen1/maelstrom-train/jube/../.venv_jwb/bin/activate;
export SRUN_CPUS_PER_TASK="${SLURM_CPUS_PER_TASK}"
export LD_PRELOAD=/p/home/jusers/nipen1/juwels/local/lib/libvefprospector_full.so
export files=/p/scratch/deepacf/maelstrom/maelstrom_data/ap1/air_temperature//5TB/202???01T*.nc 
srun maelstrom-train --config etc/d1-4/opt1_e1.yml etc/d1-4/loader_debug.yml etc/d1-4/common.yml -m unet_f16_l6_c1_p2 -o results/vef --test=0
