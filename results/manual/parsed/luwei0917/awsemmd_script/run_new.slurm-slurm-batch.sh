#!/bin/bash
#SBATCH --job-name=CTBP_WL
#SBATCH --mail-user=luwei0917@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=1-00:00:00

echo "My job ran on:"
echo $SLURM_NODELIST
srun ~/lammps_awsemmd_20161125/bin/lmp_serial -in PROTEIN.in
