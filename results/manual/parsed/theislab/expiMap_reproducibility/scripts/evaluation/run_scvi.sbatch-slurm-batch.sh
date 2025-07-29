#!/bin/bash
#SBATCH --job-name=integration_scVI
#SBATCH --output=/storage/groups/ml01/workspace/sergei.rybakov/data_integr/integration_scVI_%j.job
#SBATCH --error=/storage/groups/ml01/workspace/sergei.rybakov/data_integr/integration_scVI_%j.job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu_p
#SBATCH --qos=gpu

source $HOME/.bashrc
source activate work-gpu
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/lung_travaglini_preproc.h5ad tech_sample
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/liver_popescu_preproc.h5ad orig.ident
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/colon_smilie_preproc.h5ad Source
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/blood_azimuth_preproc.h5ad donor
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/heart_scvi_preproc.h5ad cell_source
