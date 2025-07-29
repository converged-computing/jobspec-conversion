#!/bin/bash
#SBATCH --job-name=custom_dataset_train
#SBATCH --account=gts-rs275
#SBATCH --output=Report-%j.out
#SBATCH --mail-user=cchen847@gatech.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:RTX_6000:2
#SBATCH --time=1-00:00:00
#SBATCH --partition=inferno

cd $SLURM_SUBMIT_DIR                            # Change to working directory
module load anaconda3/2022.05                   # Load module dependencies
conda create -n bm ipython python=3.8 -y
conda activate bm
conda install pytorch==1.12.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch
pip install -U -r requirements.txt
pip install -e .
python -m spacy download en_core_web_md
dora grid nmi.main_table --dry_run --init
dora run -f 557f5f8a -d
dora grid nmi.main_table '!seed' '!features' '!wer_random' --dry_run --init
