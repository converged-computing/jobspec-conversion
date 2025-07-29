#!/bin/bash
#SBATCH --job-name=gwecc-search
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G

/home/susobhan/Data/susobhan/miniconda/envs/gwecc/bin/activate
PYTHON=$CONDA_PREFIX/bin/python
JULIA=$CONDA_PREFIX/bin/julia
source print_info.sh
echo
$PYTHON run_1psr_analysis.py fix-wn_vary-rn_no-ecw.json
