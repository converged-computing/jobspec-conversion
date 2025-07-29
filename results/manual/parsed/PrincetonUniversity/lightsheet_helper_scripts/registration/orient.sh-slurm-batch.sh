#!/bin/bash
#SBATCH --output=/scratch/zmd/logs/orient.out
#SBATCH --error=/scratch/zmd/logs/orient.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50000
#SBATCH --time=08:20:00

module load anacondapy/5.3.1
source activate lightsheet
echo "In the directory: `pwd` "
echo "As the user: `whoami` "
echo "on host: `hostname` "
cat /proc/$$/status | grep Cpus_allowed_list
python fix_orientation_and_rerun_registration.py
