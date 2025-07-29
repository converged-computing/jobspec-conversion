#!/bin/bash
#SBATCH --job-name=Partitioning of images
#SBATCH --account=ie-idi
#SBATCH --output=partition.out
#SBATCH --mail-user=sebastvi@stud.ntnu.no,ingebrin@stud.ntnu.no
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12000
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR} # /cluser/work/<username>/master-sau/slurm
uname -a
module purge
module load Python/3.8.6-GCCcore-10.2.0
cd ..
cd preprocessing
pwd
python -u transform.py
