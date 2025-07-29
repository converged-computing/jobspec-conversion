#!/bin/bash
#SBATCH --job-name=par_pi_job
#SBATCH --output=%x-%j.SLURMout
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:30:00
#SBATCH --constraint=amr

darts=(1e3 1e6 1e9)
processors=(1 2 4 8 16 32)
for d in "${darts[@]}"; do
    for p in "${processors[@]}"; do
        srun -n $p --time=1:00:00 par_pi_calc_Q3.exe $d >> output.txt
    done
done
