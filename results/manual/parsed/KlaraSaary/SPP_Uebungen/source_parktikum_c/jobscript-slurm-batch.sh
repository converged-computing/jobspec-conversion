#!/bin/bash
#SBATCH --job-name=my_job
#SBATCH --output=Job_name.out.%j
#SBATCH --error=Job_name.err.%j
#SBATCH --mail-user=felix.staniek@gmx.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=1800
#SBATCH --time=00:03:00
#SBATCH --partition=kurs1
#SBATCH: --exclusive

echo "This is Job $SLURM_JOB_ID"
module load gcc
cd /home/kurse/kurs1/ui31dymo/Lap1/SPP_Uebungen/source_parktikum_c
./main text1.txt text4.txt
