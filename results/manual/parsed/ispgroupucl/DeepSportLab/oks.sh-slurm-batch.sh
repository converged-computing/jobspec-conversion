#!/bin/bash
#SBATCH --output=OKS-%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --nodelist=belldevcv01

python oks.py $@
