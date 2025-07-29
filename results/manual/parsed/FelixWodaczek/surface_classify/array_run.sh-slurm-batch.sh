#!/bin/bash
#SBATCH --job-name=arraySurfaceClass
#SBATCH --output=SurfaceClass.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=02:00:00
#SBATCH: --no-requeue

unset SLURM_EXPORT_ENV
module load python/3.9.7
source SURFCLASS_VENV01/bin/activate
python3 slurm_classify.py -m 'soap_sort' # soap_sort, lmbtr_sort, soap_gendescr, lmbtr_gendescr
deactivate
