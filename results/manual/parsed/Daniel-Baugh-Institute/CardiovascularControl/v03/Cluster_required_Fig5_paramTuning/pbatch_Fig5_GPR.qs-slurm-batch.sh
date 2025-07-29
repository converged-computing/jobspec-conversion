#!/bin/bash
#SBATCH --job-name=Fig8_mdlStruct
#SBATCH --mail-user=youremail@udel.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=24G
#SBATCH --time=03:25:00
#SBATCH --partition=idle

vpkg_require matlab/default
. /opt/shared/slurm/templates/libexec/openmp.sh
UD_EXEC matlab -nodisplay -batch Fig5_GPR_cluster
matlab_rc=$0
if [ $matlab_rc -ne 0 ]; then exit $matlab_rc; fi
