#!/bin/bash
#SBATCH --job-name=tempname
#SBATCH --output=res_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=2-00:00:00

module load intel
source /home/xsede/users/xs-adurden1/.bashrc
cd temppath
srun /cstor/xsede/users/xs-adurden1/terachem_xstream/terachem tempname.in > tempname.out
