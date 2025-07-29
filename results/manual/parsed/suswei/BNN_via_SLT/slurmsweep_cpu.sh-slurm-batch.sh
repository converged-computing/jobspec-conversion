#!/bin/bash
#SBATCH --job-name=icml
#SBATCH --mail-user=susan.wei@unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=2-00:00:00
#SBATCH --array=0-3839

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
source /usr/local/module/spartan_new.sh
module load gitpython/3.1.14
module load fosscuda/2020b
module load pytorch/1.10.0-python-3.8.6
MKL_THREADING_LAYER=GNU python3 experiments.py ${SLURM_ARRAY_TASK_ID}
