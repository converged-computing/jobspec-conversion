#!/bin/bash
#SBATCH --job-name=ArcOn_ITER
#SBATCH --account=Disc_Gal_Blobs
#SBATCH --output=ITER.o%j
#SBATCH --error=ITER.e%j
#SBATCH --mail-user=michoski@ices.utexas.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00

export MV2_ON_DEMAND_THRESHOLD='64'

export MV2_ON_DEMAND_THRESHOLD=64
ibrun ./ArcOn #-log_summary petsc_log_summary -ksp_view petsc_ksp_summary
   #ibrun ./ArcOn
