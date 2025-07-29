#!/bin/bash
#SBATCH --job-name=A20interpolation
#SBATCH --account=nn9297k
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=1-23:00:00
#SBATCH --constraint=ntasks-per-node=1

SCRATCH_DIRECTORY=/cluster/projects/nn9412k/A20/DELTA/${SLURM_JOBID}
mkdir -p ${SCRATCH_DIRECTORY}
cd ${SCRATCH_DIRECTORY}
source /cluster/home/${USER}/.bashrc
conda activate OpenDrift
scp ${SLURM_SUBMIT_DIR}/interpolateNORESM_using_ESMF.py ${SCRATCH_DIRECTORY}
python interpolateNORESM_using_ESMF.py &> a20.output
exit 0
