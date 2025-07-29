#!/bin/bash
#SBATCH --job-name=___
#SBATCH --account=research
#SBATCH --output=output_log_files/Labls_all_Q%j.out
#SBATCH --mail-user=sandeep.nagar@research.iiit.ac.in
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=3000
#SBATCH --time=4-00:00:00
#SBATCH --qos=medium

module load cudnn/7-cuda-10.0
 # python3 printing_the_files_name_in_the_directory.py
cd seeds_dataset
python download_images.py 
