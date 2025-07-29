#!/bin/bash
#SBATCH --job-name=Opensees
#SBATCH --output=out_file.txt
#SBATCH --error=err_file.txt
#SBATCH --mail-user=michael.shields@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=5

module load python   
module load opensees/3.2.0
module load parallel
python run_opensees_UQpy.py       
