#!/bin/bash
#SBATCH --job-name=python_sweep_test
#SBATCH --output=test-job-%j.log
#SBATCH --mail-user=r.tappe.maestro@student.rug.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500MB
#SBATCH --time=00:01:00

module purge
module load matplotlib
module load networkx
module load scikit-learn
module load tqdm
module load GCC
module load ngspice
srun python3 src/main.py
