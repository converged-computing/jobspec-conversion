#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=myjob.log
#SBATCH --mail-user=my-email@pdx.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20

pwd; hostname;
echo "Starting at wall clock time:"
date
echo "Running CMT on $SLURM_CPUS_ON_NODE CPU cores"
module load gcc-9.2.0
module load ngsolve/serial
module load intel
python3 $HOME/local/fiberamp/cmt/usage_examples/lase_thulium.py
echo "Ending at wall clock time:"
date
