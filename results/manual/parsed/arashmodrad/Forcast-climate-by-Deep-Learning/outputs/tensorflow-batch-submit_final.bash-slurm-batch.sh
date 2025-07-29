#!/bin/bash
#SBATCH --job-name=Final
#SBATCH --account=amodaresirad
#SBATCH --output=outputs/results_final.o%j
#SBATCH --error=outputs/errors_final.e%j
#SBATCH --mail-user=arashmodaresirad@u.boisestate.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=28
#SBATCH --time=5-00:00:00

ulimit -v unlimited
ulimit -s unlimited
ulimit -u 1000
module load cuda10.0/toolkit/10.0.130 # loading cuda libraries/drivers 
module load python/intel/3.7          # loading python environment
env_out_file=outputs/environment.out
module load python/intel/3.7          # loading python environment
module load anaconda
source /cm/shared/apps/anaconda3/etc/profile.d/conda.sh
conda activate base
conda create -n Arash-project python=3.7 -c conda-forge -y -q > $env_out_file
echo "(Arash-project) environment created" >> $env_out_file
conda activate Arash-project
conda install -c conda-forge mamba -y -q >> $env_out_file
echo "mamba installed" >> $env_out_file
mamba env update -n Arash-project -f environment.yml --prune -q >> $env_out_file
conda activate Arash-project
echo "(Arash-project) environment updated" >> $env_out_file
echo "Running scripts..."
python3 Model_proj_final.py
conda deactivate
