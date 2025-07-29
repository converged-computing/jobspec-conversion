#!/bin/bash
#SBATCH --job-name=EasyBuild
#SBATCH --account=hpcnow
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=06:00:00
#SBATCH --chdir=/sNow/easybuild/jobs

srun eb  GROMACS-4.6.5-ictce-5.5.0-mt.eb --try-toolchain=ictce,5.4.0 --robot --force
srun eb WRF-3.4-goalf-1.1.0-no-OFED-dmpar.eb -r
/sNow/apps/lmod/utils/BuildSystemCacheFile/createSystemCacheFile.sh
