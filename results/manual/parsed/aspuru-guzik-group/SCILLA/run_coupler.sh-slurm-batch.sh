#!/bin/bash
#SBATCH --job-name=run_coupler
#SBATCH --output=run_coupler.out
#SBATCH --error=run_coupler.err
#SBATCH --mail-user=tim_menke@g.harvard.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=256000
#SBATCH --time=2-00:00:00
#SBATCH --partition=unrestricted

module load centos6/0.0.1-fasrc01
module load Anaconda3/5.0.1-fasrc01
module load mathematica/11.1.1-fasrc01
source activate Qcirc
python circuit_searcher.py
echo Finished!
