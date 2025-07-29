#!/bin/bash
#SBATCH --job-name=Act_sin_1
#SBATCH --output=/work/scratch/se55gyhe/log/output.out.%j
#SBATCH --error=/work/scratch/se55gyhe/log/output.err.%j
#SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=23:59:00

python3 /home/se55gyhe/Act_func/progs/meta.py sin 1 Adam 4 0.7087279355875828 493 0.0010470492554084177 lecun_uniform PE-infersent 
