#!/bin/bash
#FLUX: --job-name=bricky-milkshake-6550
#FLUX: --priority=16

export BGLOCKLESSMPIO_F_TYPE='0x47504653'

module purge
echo "Running with nix/mvapich2-rdma" 
module load nix/mvapich2-rdma
module load nix/bench/ior
export BGLOCKLESSMPIO_F_TYPE=0x47504653
echo "SLURM_NTASKS: $SLURM_NTASKS" 
echo "SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE"
echo "SLURM_NODELIST: $SLURM_NODELIST"
outdir=$(mktemp -p . -d iorout_XXXXXX)
srun ior -a MPIIO -b 1g -w -r -F -t 64m -i 3  \
    -o $outdir/
rm -rf $outdir
