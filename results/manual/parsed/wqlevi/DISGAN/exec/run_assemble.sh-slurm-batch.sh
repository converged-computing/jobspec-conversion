#!/bin/bash
#SBATCH --job-name=TORCH-GPU
#SBATCH --output=./log/assem.out.%j
#SBATCH --error=./log/assem.err.%j
#SBATCH --mail-user=qi.wang@tuebingen.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64000
#SBATCH --time=00:30:00
#SBATCH --constraint=cpu,ntasks-per-node=1
#SBATCH --chdir=./

module purge 
module load anaconda/3/2020.02
module load nibabel/2.5.0
srun python /u/wangqi/torch_env/crop_gan/assemble_crop_v3.py --path /ptmp/wangqi/MPI_subj3/gen_data --subj MPRAGE --scale 2
echo "Jobs finished"
