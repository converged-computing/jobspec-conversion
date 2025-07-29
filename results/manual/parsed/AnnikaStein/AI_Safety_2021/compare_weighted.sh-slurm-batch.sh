#!/bin/bash
#SBATCH --account=rwth0583
#SBATCH --output=output.%J.txt
#SBATCH --mail-user=annika.stein@rwth-aachen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=160G
#SBATCH --constraint=ntasks-per-node=1

cd /home/um106329/aisafety
source ~/miniconda3/bin/activate
conda activate my-env
python3 compare_weighted.py ${FROM} ${TO} ${MODE} ${FIXRANGE} ${EVALDATASET} ${TRAINDATASET}
