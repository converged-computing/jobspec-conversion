#!/bin/bash
#SBATCH --job-name=1000_runs
#SBATCH --account=cosc029884
#SBATCH --output=/user/home/um21226/out_directory/density_2.6__alpha_10/%a_density_2.6__alpha_10.out
#SBATCH --mail-user=um21226@bris.ac.uk
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=25000
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-1000

module purge
. ~/initConda.sh
conda activate diss
python -u ./code/main.py -density 2.3 -alpha 0
