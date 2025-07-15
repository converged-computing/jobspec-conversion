#!/bin/bash
#FLUX: --job-name=confused-chair-7347
#FLUX: -N=2
#FLUX: --queue=nvgpu
#FLUX: --priority=16

export MPICH_MAX_THREAD_SAFETY='multiple'
export MIMALLOC_EAGER_COMMIT_DELAY='0'
export MIMALLOC_LARGE_OS_PAGES='1'
export CUDA_VISIBLE_DEVICES='\$SLURM_LOCALID'

export MPICH_MAX_THREAD_SAFETY=multiple
export MIMALLOC_EAGER_COMMIT_DELAY=0
export MIMALLOC_LARGE_OS_PAGES=1
hostname
nvidia-smi
mpichversion
cat > gpu2ranks <<EOF
set -eu
export CUDA_VISIBLE_DEVICES=\$SLURM_LOCALID
eval "\$@"
EOF
chmod +x gpu2ranks
srun -u -n 1 --cpu-bind=mask_cpu:ffff000000000000ffff000000000000,ffff000000000000ffff00000000,ffff000000000000ffff0000,ffff000000000000ffff \
    ./gpu2ranks ctest -L RANK_1
srun -u -n 2 --cpu-bind=mask_cpu:ffff000000000000ffff000000000000,ffff000000000000ffff00000000,ffff000000000000ffff0000,ffff000000000000ffff \
    ./gpu2ranks ctest -L RANK_2
srun -u -n 4 --cpu-bind=mask_cpu:ffff000000000000ffff000000000000,ffff000000000000ffff00000000,ffff000000000000ffff0000,ffff000000000000ffff \
    ./gpu2ranks ctest -L RANK_4
srun -u -n 6 --cpu-bind=mask_cpu:ffff000000000000ffff000000000000,ffff000000000000ffff00000000,ffff000000000000ffff0000,ffff000000000000ffff \
    ./gpu2ranks ctest -V -L RANK_6
