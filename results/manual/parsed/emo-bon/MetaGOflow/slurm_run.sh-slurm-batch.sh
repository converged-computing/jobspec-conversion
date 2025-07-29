#!/bin/bash
#SBATCH --job-name=tara4IPS
#SBATCH --output=tara4cpusIPS.output
#SBATCH --mail-user=haris.zafr@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=40

conda deactivate
module load python/3.7.8
module load singularity/3.7.1 
./run_wf.sh -e ERR599171 -d TARA_OCEANS_SAMPLE -n ERR599171 -s -b
module purge
