#!/bin/bash
#SBATCH --job-name=pp1953
#SBATCH --output=output/slurm_%j.out
#SBATCH --mail-user=pp1953p@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=100000
#SBATCH --time=12:00:00

. ~/.bashrc
module load anaconda3/5.3.1
conda activate PPUU
conda install -n PPUU nb_conda_kernels
chikka=$1
echo $chikka
cd 
cd /home/pp1953/code/official
python config_trainer.py --focus=map --dataset=mars --opt=$chikka --name=_mars_cl_centers_ --cl-centers >>  ~/code/official/output/mars_cl_centers_$chikka.out
