#!/bin/bash
#SBATCH --job-name=baker_preprocessing_0_single
#SBATCH --output=baker_preprocessing_0_single-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=512G
#SBATCH --time=1-00:00:00

source /lab/barcheese01/mdiberna/OpticalPooledScreens_david/venv/bin/activate
cd /lab/barcheese01/screens/baker/preprocessing_0
python3 preprocessing_single.py
