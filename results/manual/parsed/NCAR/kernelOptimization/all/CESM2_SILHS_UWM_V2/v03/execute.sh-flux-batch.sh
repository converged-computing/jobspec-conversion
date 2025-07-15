#!/bin/bash
#FLUX: --job-name=arid-motorcycle-7064
#FLUX: --urgency=16

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
