#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

export QT_QPA_PLATFORM='offscreen'

export QT_QPA_PLATFORM='offscreen'
cd $PBS_O_WORKDIR
python tst_paper_results.py
