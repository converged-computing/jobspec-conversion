#!/bin/bash
#SBATCH --account=proj16
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128
#SBATCH --time=01:00:00
#SBATCH --qos=bigjob
#SBATCH: --exclusive

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
