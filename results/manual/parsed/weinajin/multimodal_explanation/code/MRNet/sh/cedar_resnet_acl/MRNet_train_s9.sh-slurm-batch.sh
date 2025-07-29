#!/bin/bash
#SBATCH --job-name=s9_mrnet
#SBATCH --account=rrg-PIID
#SBATCH --output=/scratch/authorid/shortcut/log/MRNet/s9_1119_mrnet_%A.out
#SBATCH --mail-user=email@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=5-07:00:00

module load python/3.7
module load openslide
virtualenv --no-download $SLURM_TMPDIR/venv
source $SLURM_TMPDIR/venv/bin/activate
pip install --no-index --upgrade pip
pip install -r /scratch/authorid/BRATS_IDH/code/requirement.txt
cd /scratch/authorid/shortcut/MRNet/
srun python train.py --rundir /scratch/authorid/shortcut/log/MRNet/seed9 --task acl --backbone resnet18 --seed 9
