#!/bin/bash
#SBATCH --job-name=bench
#SBATCH --account=2017-12-20
#SBATCH --output=SLURM.bench.%J.stdout
#SBATCH --error=SLURM.bench.%J.stderr
#SBATCH --mail-user=avmo@kth.se
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:58
#SBATCH --constraint=ntasks-per-node=32

export FLUID_PROC_MESH='2x32'

N0=512
N1=512
N2=128
source /etc/profile
module load gcc/7.2.0
module swap PrgEnv-cray PrgEnv-intel
module swap intel intel/18.0.0.128
module add cdt/17.10 # add cdt module
export FLUID_PROC_MESH='2x32'
aprun -n $(nproc) \
       test_bench.out --N0=$N0 --N1=$N1 --N2=$N2
