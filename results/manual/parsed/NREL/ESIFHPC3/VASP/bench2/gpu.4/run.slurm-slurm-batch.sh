#!/bin/bash
#SBATCH --job-name=gb2.4
#SBATCH --output=std.out
#SBATCH --error=std.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=04:00:00

module purge
module use /nopt/nrel/apps/modules/centos74/modulefiles/
module load intel-mpi/2018.0.3 mkl/2018.3.222 cuda/10.2.89 
module list
input_path=../input
vasp_run=/projects/nafion/openmp/vasp6/dist3/vasp.6.1.2/bin/vasp_gpu
cp $input_path/INCAR  .
cp $input_path/KPOINTS .
cp $input_path/POSCAR .
cp $input_path/POTCAR .
nnodes=$SLURM_NNODES
rankspernode=8
ntasks=$((nnodes*rankspernode))
time srun --ntasks=$ntasks --tasks-per-node=$rankspernode $vasp_run >& LOG
