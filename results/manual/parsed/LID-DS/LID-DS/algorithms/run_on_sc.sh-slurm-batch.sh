#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=10:00:00
#SBATCH --partition=paula-gpu

module load matplotlib
pip install --upgrade pip
pip install --user -e ../
pip install --user -r ../requirements.txt
python ids_cluster.py -d $1 -s $2 -e $3 -n $4 -w $5 -t $6
