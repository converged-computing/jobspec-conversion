#!/bin/bash
#SBATCH --output=/home/dalmiapriyam/bpp/slurmoutput/slurm-%j.out
#SBATCH --mail-user=dalmiap@student.unimelb.edu.au
#SBATCH --mail-type=fail
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --qos=gpgpumse

module load pytorch/1.5.1-python-3.7.4
python3 trainers/tprey.py
