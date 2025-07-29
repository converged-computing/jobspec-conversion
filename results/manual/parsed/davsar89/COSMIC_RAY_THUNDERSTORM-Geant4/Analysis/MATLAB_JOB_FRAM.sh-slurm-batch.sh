#!/bin/bash
#SBATCH --job-name=MAKE_BDF
#SBATCH --account=NN9526K
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=08:00:00
#SBATCH --partition=normal
#SBATCH --constraint=ntasks-per-node=1

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module restore system
module load MATLAB/2020b
echo "starting..."
cd ${SLURM_SUBMIT_DIR}
matlab -nodisplay -nodesktop -nojvm -r "DO_ALL"
echo "done"
