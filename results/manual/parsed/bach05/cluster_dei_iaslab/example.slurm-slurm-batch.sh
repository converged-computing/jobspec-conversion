#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=%x_output.txt
#SBATCH --error=%x_errors.txt
#SBATCH --mail-user=example@dei.unipd.it
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00

cd $WORKING_DIR
srun singularity exec --bind /nfsd/iaslab4/Users/rossi/example_code_repo:/mnt --nv /nfsd/iaslab4/Users/rossi/example_code_repo/example.sif python3 /mnt/example_train.py
