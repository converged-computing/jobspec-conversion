#!/bin/bash
#SBATCH --job-name=build-graph-precluster
#SBATCH --account=m3443
#SBATCH --mail-user=ameyathete11@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --partition=regular
#SBATCH --constraint=cpu

module load python
conda activate pytorch-gnn
echo "...building pre-clustering"
python equivariant-tracking/graph-construction/build_pre-clustering.py equivariant-tracking/graph-construction/configs/pre-clustering.yaml --start-evtid=1000 --end-evtid=2500
echo "...done"
