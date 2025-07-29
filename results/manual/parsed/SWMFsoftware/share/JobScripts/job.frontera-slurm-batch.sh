#!/bin/bash
#SBATCH --job-name=sub1
#SBATCH --account=BCS21001
#SBATCH --output=SWMF.o%j
#SBATCH --error=SWMF.e%j
#SBATCH --nodes=64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=normal

export I_MPI_ADJUST_REDUCE='1 '
export UCX_LOG_LEVEL='ERROR '

export I_MPI_ADJUST_REDUCE=1 
export UCX_LOG_LEVEL=ERROR 
ibrun ./SWMF.exe  > runlog_`date +%y%m%d%H%M`
