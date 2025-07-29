#!/bin/bash
#SBATCH --job-name=swat_preprocessing
#SBATCH --mail-user=alexander.kmoch@ut.ee
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=00:15:00
#SBATCH --partition=main
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/gpfs/hpc/home/kmoch/swat

module load python-3.7.1
for i in pori3 hwsd isric10km isric5km isric1km isric250m; do
    $HOME/.conda/envs/daskgeo2020a/bin/python run_for.py -m $i
done
