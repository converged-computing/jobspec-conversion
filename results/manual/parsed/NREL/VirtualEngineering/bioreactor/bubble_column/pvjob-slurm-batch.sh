#!/bin/bash
#SBATCH --job-name=pvpost
#SBATCH --account=bpms
#SBATCH --output=pv_post_log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --qos=high

module purge
module load openmpi/1.10.7/gcc-7.3.0
module load gcc
module load paraview
source /projects/bpms/openfoam/OpenFOAM-dev/etc/bashrc
rm -rf 0.0/
rm -rf 0/
reconstructPar -withZero -newTimes
mv 0/ 0.0/
pvpython pv_extract_analyze_script.py 
