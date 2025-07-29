#!/bin/bash
#SBATCH --job-name=MAKE_BDF
#SBATCH --account=NN9526K
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=4G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module restore system
module load MATLAB/2019a
echo "starting..."
cd ${SLURM_SUBMIT_DIR}
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = 22; MAKE_BIG_DATAFILES"
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = 11; MAKE_BIG_DATAFILES"
matlab -nodisplay -nodesktop -nojvm -r "global RECORD_PDG_TO_PROCESS; RECORD_PDG_TO_PROCESS = -11; MAKE_BIG_DATAFILES"
echo "done"
