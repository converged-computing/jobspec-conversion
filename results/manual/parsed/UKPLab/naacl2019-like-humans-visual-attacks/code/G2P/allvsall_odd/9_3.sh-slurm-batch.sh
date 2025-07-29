#!/bin/bash
#SBATCH --job-name=Act_tanh_1
#SBATCH --output=/work/scratch/se55gyhe/log/output.out.%j
#SBATCH --error=/work/scratch/se55gyhe/log/output.err.%j
#SBATCH --mail-user=eger@ukp.informatik.tu-darmstadt.de
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000
#SBATCH --time=23:59:00

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.9_3 odd_G2P_9_3/
