#!/bin/bash
#SBATCH --job-name=building_friendster_LT
#SBATCH --account=m1641
#SBATCH --output=/global/homes/w/wadecap/building_friendster_LT.o
#SBATCH --error=/global/homes/w/wadecap/building_friendster_LT.e
#SBATCH --mail-user=wade.cappa@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=cpu,ntasks-per-node=1

export OMP_NUM_THREADS='128'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=128
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
srun -n 1 ~/ripples/build/release/tools/dump-graph -i /global/cfs/cdirs/m1641/network-data/test_data/com-friendster.ungraph.txt --distribution uniform -d LT -o /global/homes/w/wadecap/friendster_LT_binary.txt --scale-factor 0.1 --dump-binary
