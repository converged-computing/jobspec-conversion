#!/bin/bash
#SBATCH --job-name=tjpcov-clusters-run
#SBATCH --account=m1727
#SBATCH --output=/pscratch/sd/m/mkwiecie/tjpcov/tjpcov-clusters-run.log-%j.txt
#SBATCH --mail-user=youremail@yourdomain.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=8
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=256000
#SBATCH --time=02:00:00
#SBATCH --qos=regular
#SBATCH --constraint=cpu
#SBATCH --licenses=cfs,SCRATCH

input=your_config.yaml
output=your_output.sacc
source /global/common/software/lsst/common/miniconda/setup_current_python.sh
python3 run_tjpcov.py $input -o $output
