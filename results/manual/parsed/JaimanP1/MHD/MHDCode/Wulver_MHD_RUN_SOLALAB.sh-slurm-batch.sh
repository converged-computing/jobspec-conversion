#!/bin/bash
#SBATCH --job-name=mhd_run
#SBATCH --output=Out_files/mhd_run%j.out
#SBATCH --error=Err_files/mhd_run%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=144
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=3-00:00:00
#SBATCH --qos=high_wangj
#SBATCH --constraint=ntasks-per-node=72

module purge > /dev/null 2>&1
module load wulver
module load foss/2022b
module use /opt/site/easybuild/modules/all/Core
make
srun mhd_run
