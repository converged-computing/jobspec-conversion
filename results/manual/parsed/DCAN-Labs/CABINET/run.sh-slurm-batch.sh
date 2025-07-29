#!/bin/bash
#SBATCH --job-name=cabinet
#SBATCH --account={ACCOUNT}
#SBATCH --output=/path/to/logs/%A_cabinet.out
#SBATCH --error=/path/to/logs/%A_cabinet.err
#SBATCH --mail-user={MAIL_USER}
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=240gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=v100

module load singularity
module load python
singularity=`which singularity`
./run.py $1
