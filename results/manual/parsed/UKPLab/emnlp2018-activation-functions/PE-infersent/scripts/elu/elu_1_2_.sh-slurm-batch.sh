#!/bin/bash
#SBATCH --job-name=Act_elu_1
#SBATCH --output=/work/scratch/se55gyhe/log/output.out.%j
#SBATCH --error=/work/scratch/se55gyhe/log/output.err.%j
#SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=23:59:00

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Adamax 2 0.2970755532931561 171 0.001799642701972302 he_uniform PE-infersent 
