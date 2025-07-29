#!/bin/bash
#SBATCH --job-name=pico
#SBATCH --output=./pico.out.%j
#SBATCH --error=./pico.err.%j
#SBATCH --mail-user=simpson@ukp.informatik.tu-darmstadt.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8182
#SBATCH --time=1-00:00:00
#SBATCH: --exclusive
#SBATCH --constraint=avx

module load intel python/3.6.8
python -u ./src/run_pico_experiments.py
