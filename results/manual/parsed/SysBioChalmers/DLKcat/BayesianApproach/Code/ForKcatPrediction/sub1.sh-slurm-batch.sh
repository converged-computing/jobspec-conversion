#!/bin/bash
#SBATCH --account=C3SE2021-1-16
#SBATCH --output=out.txt
#SBATCH --mail-user=feiranl@chalmers.se
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load GCCcore/8.3.0
module load MATLAB intel/2018b GMP
module load Gurobi/8.0.0
a1=1
b1=40
matlab -nodesktop -singleCompThread -r "writeFile_pre_cluster($a1,$b1)"
