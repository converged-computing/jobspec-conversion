#!/bin/bash
#SBATCH --job-name=swat_callib_x
#SBATCH --mail-user=alexander.kmoch@ut.ee
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=20:00:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/gpfs/hpc/home/kmoch/swat

module load python-3.7.1
source activate daskgeo2020a
$HOME/.conda/envs/daskgeo2020a/bin/python run_for.py -m $MD1 -s $SP1 -r $REP1 -p $PAR1
