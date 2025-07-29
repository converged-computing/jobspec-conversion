#!/bin/bash
#SBATCH --account=conroy_lab
#SBATCH --output=xmatch_phot.out
#SBATCH --error=xmatch_phot.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128000
#SBATCH --time=00:02:00

module load python
source ~/.bashrc
conda activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 00_xmatch_phot.py
