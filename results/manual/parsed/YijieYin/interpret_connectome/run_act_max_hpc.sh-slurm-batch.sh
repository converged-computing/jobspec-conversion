#!/bin/bash
#SBATCH --job-name=act_max
#SBATCH --output=result_%A.out
#SBATCH --error=error_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=01:00:00
#SBATCH --array=1
#SBATCH --nodelist=fmg102

source ../.bashrc
conda activate act_max
inprop_path='data/adult_inprop_cb_neuron_no_CX_axonic_postsynapses.npz'
meta_path='data/adult_cb_neuron_meta_no_CX_axonic_postsynapses.csv'
num_iterations=60
optimised_input_path="/cephfs2/yyin/tangential/optimised_input/"
output_dir="/cephfs2/yyin/tangential/output/"
weights_path='/cephfs2/yyin/moving_bump/updated_weights/'
array_id=${SLURM_JOB_ID}
python activation_maximisation.py --inprop_path $inprop_path --meta_path $meta_path --num_iterations $num_iterations --optimised_input_path $optimised_input_path --output_path $output_dir --weights_path $weights_path --array_id $array_id  
