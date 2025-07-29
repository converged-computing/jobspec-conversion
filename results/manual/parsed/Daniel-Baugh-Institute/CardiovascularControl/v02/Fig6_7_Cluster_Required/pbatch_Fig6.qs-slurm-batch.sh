#!/bin/bash
#SBATCH --job-name=RSA_GPR_robust
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=12G
#SBATCH --time=01:25:00
#SBATCH --partition=idle

vpkg_require matlab/default
. /opt/shared/slurm/templates/libexec/openmp.sh
UD_EXEC matlab -nodisplay -batch RSA_GPR_robust_v3
matlab_rc=$?
if [ $matlab_rc -ne 0 ]; then exit $matlab_rc; fi
