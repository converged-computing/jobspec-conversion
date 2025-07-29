#!/bin/bash
#SBATCH --job-name=CESM2_SILHS_UWM_V2
#SBATCH --account=NTDD0004
#SBATCH --output=gpu.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=0
#SBATCH --time=00:20:00

export PGI_ACC_NOTIFY='2'
export PGI_ACC_TIME='1'

unset SLURM_MEM_PER_NODE
module use /glade/work/cponder/SHARE/Modules/Latest
module use /glade/work/cponder/SHARE/Modules/Legacy
module use --append /glade/work/cponder/SHARE/Modules/Bundles
for dir in /glade/work/cponder/SHARE/Modules/PrgEnv/*/*
do
    module use --append $dir
done
module purge
module load PrgEnv/PGI+OpenMPI/2019-04-30 
module load pgi
module load openmpi
ulimit -s unlimited
module list
export PGI_ACC_NOTIFY=2
echo $LD_LIBRARY_PATH
cd /glade/scratch/dennis/kernelOptimization/all/CESM2_SILHS_UWM_V2/v02
export PGI_ACC_TIME=1
srun ./kernel.exe
