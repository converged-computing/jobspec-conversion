#!/bin/bash
#SBATCH --job-name=scRNA_seq_inte
#SBATCH --mail-user=lixiaoy5@msu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64G
#SBATCH --time=05:00:00

module purge
module load GCCcore/10.3.0
conda activate env_
python -u node_feature.py > output.txt
scontrol show job $SLURM_JOB_ID           ### write job information to output file
js -j $SLURM_JOB_ID 
