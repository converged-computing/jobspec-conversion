#!/bin/bash
#SBATCH -p ai2es
#SBATCH --nodes=1-1
#SBATCH -n 4
#SBATCH --exclusive
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:30:00
#SBATCH --job-name="regress_case_study"
#SBATCH --mail-user=robjk3-22@rhodes.edu
#SBATCH --mail-type=ALL
#SBATCH --mail-type=END
#SBATCH --output=/ourdisk/hpc/ai2es/jRobinson/R-%x.%j.out
#SBATCH --error=/ourdisk/hpc/ai2es/jRobinson/R-%x.%j.err

#Running using Modules
echo "loading modules"
module load TensorFlow/2.4.1-fosscuda-2020a-Python-3.8.2
#echo "installing packages"
pip install keras-unet-collection
pip install Pillow
pip install xarray
pip install netCDF4
pip install dask
pip install scikit-learn

#echo "loading python"
source .bashrc
bash

echo "running python"
conda activate hagelslag
python regress_caseStudy.py