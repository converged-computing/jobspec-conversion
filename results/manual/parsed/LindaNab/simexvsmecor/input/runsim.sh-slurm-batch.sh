#!/bin/bash
#SBATCH --job-name=simexvsmecor
#SBATCH --output=/exports/clinicalepi/Linda/simexvsmecor/job%A_scen_%a.out
#SBATCH --error=/exports/clinicalepi/Linda/simexvsmecor/job%A_scen_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=15

scenario=${SLURM_ARRAY_TASK_ID}
module purge
module add statistical/R/4.0.2/gcc.8.3.1
Rscript --vanilla ./input/output.R 197 $scenario "./output/"
