#!/bin/bash
#SBATCH --account=COMP90024
#SBATCH --output=1node1core-physical.txt
#SBATCH --mail-user=xuliny@student.unimelb.edu.au
#SBATCH --mail-type=End
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=physical
#SBATCH --constraint=ntasks-per-node=1

cd /home/$USER/COMP90024/HPC-Geo-Data-Processing/slurm
module load Python/3.6.1-intel-2017.u2
time mpirun python3 "../src/main.py" -country "../src/language.json" -data "../data/bigTwitter.json"
