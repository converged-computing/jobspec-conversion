#!/bin/bash
#FLUX: --job-name=A20interpolation
#FLUX: -N=4
#FLUX: --queue=bigmem
#FLUX: -t=169200
#FLUX: --priority=16

SCRATCH_DIRECTORY=/cluster/projects/nn9412k/A20/DELTA/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
source /cluster/home/${USER}/.bashrc
conda activate OpenDrift
scp ${SLURM_SUBMIT_DIR}/interpolateNORESM_using_ESMF.py ${SCRATCH_DIRECTORY}
python interpolateNORESM_using_ESMF.py &> a20.output
exit 0
