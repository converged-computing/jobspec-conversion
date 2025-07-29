#!/bin/bash
#SBATCH --mail-user=diegodomenzain@u.boisestate.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=1-00:00:00
#SBATCH: --exclusive

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 10000
module load matlab/r2019b
job_path="../../$job_name/scripts/"
cd $job_path
matlab -nodisplay -nodesktop -r "run ./wdc_link_.m ; quit"
