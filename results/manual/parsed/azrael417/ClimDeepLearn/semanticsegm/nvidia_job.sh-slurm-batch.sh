#!/bin/bash
#SBATCH --account=dasrepo
#SBATCH --mail-user=amahesh@lbl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=50
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --constraint=knl

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load python/2.7-anaconda-4.4
source activate createlabels
srun -n 3400 -c 4 --cpu_bind=cores python -u create_multichannel_cropped_labels.py
