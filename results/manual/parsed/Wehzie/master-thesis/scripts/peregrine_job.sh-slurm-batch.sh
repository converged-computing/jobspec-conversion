#!/bin/bash
#SBATCH --job-name=python_sweep
#SBATCH --output=job-%j.log
#SBATCH --mail-user=r.tappe.maestro@student.rug.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=regular

module purge
module load networkx
module load scikit-learn
module load tqdm
module load GCC
module load ngspice
module load matplotlib
srun python3 src/main.py --production
