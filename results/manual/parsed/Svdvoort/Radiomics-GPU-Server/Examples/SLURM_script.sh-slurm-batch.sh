#!/bin/bash
#SBATCH --output=/path/to/out/out_%j.log
#SBATCH --error=/path/to/out/error_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:Quadro:1
#SBATCH --mem-per-cpu=14G
#SBATCH --time=01:00:00
#SBATCH --partition=GPU

MY_TMP_DIR=/slurmtmp/${SLURM_JOB_USER}.${SLURM_JOB_ID}
mv <path/to/your/data/> ${MY_TMP_DIR}
module purge
module load python/3.6.7
module load tensorflow/1.12.0
echo "Hello world"
