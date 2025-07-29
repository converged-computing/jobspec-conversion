#!/bin/bash
#SBATCH --job-name=Xerostomia
#SBATCH --output=slurm-%j.log
#SBATCH --mail-user=d.h.chu@rug.nl
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=23:59:59

module purge
module load fosscuda/2020b
module load OpenCV/4.2.0-foss-2020a-Python-3.8.2-contrib
module load Python/3.8.6-GCCcore-10.2.0
source /data/$USER/.envs/xerostomia_38/bin/activate
python3 main.py
