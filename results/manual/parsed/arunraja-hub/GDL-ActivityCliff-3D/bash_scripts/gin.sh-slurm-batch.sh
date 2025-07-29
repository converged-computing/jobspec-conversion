#!/bin/bash
#SBATCH --job-name=gin
#SBATCH --output=/vols/opig/users/raja/slurm_outs/slurm_%j.out
#SBATCH --error=/vols/opig/users/raja/slurm_outs/slurm_%j.err
#SBATCH --mail-user=arun.raja@dtc.ox.ac.uk
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --chdir=/vols/opig/users/raja

echo $CUDA_VISIBLE_DEVICES 
source /vols/opig/users/raja/miniconda3/etc/profile.d/conda.sh
conda activate gin_conda
python GDL-ActivityCliff-3D/gin_exp.py --dataset postera_sars_cov_2_mpro --model knn >> GDL-ActivityCliff-3D/terminal_output/gin_knn2.txt
