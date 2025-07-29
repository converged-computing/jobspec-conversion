#!/bin/bash
#SBATCH --job-name=build_kpi
#SBATCH --output=%x_%j_%a.out
#SBATCH --mail-user=hnesser@g.harvard.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=11
#SBATCH --mem=40000
#SBATCH --time=00:03:00

CHUNK="${SLURM_ARRAY_TASK_ID}"
DATA_DIR=${6}
echo "Activating python environment"
module load Anaconda3/5.0.1-fasrc01
source activate ~/python/miniconda/envs/TROPOMI_inversion
echo "Activated ${CONDA_PREFIX}"
rm -rf ${DATA_DIR}/dask-worker-space-${CHUNK}
echo "Initiating script"
python_dir=$(dirname `pwd`)
python -u ${python_dir}/python/build_k.py ${CHUNK} ${@}
rm -rf ${DATA_DIR}/dask-worker-space-${CHUNK}
