#!/bin/bash
#SBATCH --job-name=hans
#SBATCH --output=cluster.out
#SBATCH --error=cluster.err
#SBATCH --mail-user=mohamed.hassan@kit.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=5

export KMP_AFFINITY='compact,1,0'

export KMP_AFFINITY=compact,1,0
module load compiler/intel/19.1
module load mpi/openmpi/4.0
mpirun --bind-to core --map-by core singularity exec --bind /scratch --bind /tmp --bind /pfs/work7/workspace/scratch/lr1762-flow --pwd=$PWD $HOME/programs/hans.sif python3 -m hans -i $(pwd)/channel1D_DH.yaml
