#!/bin/bash
#SBATCH --job-name=Simple_Language_Model
#SBATCH --account=HSTR_EinfacheSprache
#SBATCH --output=SLM1e-3_V1_EP20_PT3-%j.out
#SBATCH --error=SLM1e-3_V1_EP20_PT3-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=16384
#SBATCH --time=20:00:00

rhrk-singularity tensorflow_22.03-tf2-py3.simg python3 simple_language_model_test.py
