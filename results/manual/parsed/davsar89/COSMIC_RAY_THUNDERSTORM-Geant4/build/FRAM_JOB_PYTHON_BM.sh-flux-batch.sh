#!/bin/bash
#FLUX: --job-name=cosmic_t
#FLUX: --queue=bigmem
#FLUX: -t=172800
#FLUX: --urgency=16

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module restore system   # Restore loaded modules to the default
module load foss/2020b
module load CMake/3.9.1
module load OpenMPI/2.1.1-GCC-6.4.0-2.28
module load gompi/2017b
module load Python/3.6.2-foss-2017b
module load Boost/1.66.0-foss-2018a-Python-2.7.14
module load GCC/10.2.0
module load GCCcore/10.2.0
module list             # List loaded modules, for easier debugging
echo "Running code..."
cd ${SLURM_SUBMIT_DIR}
srun python python_job_fram_BM.py
wait
echo "Done."
