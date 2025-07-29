#!/bin/bash
#SBATCH --job-name=crFHN-msam3d-petct-cvCHUM-gtvweighted-histfix
#SBATCH --output=slurm_job_logs/crFHN-msam3d-petct-cvCHUM-gtvweighted-histfix.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:pascal:2
#SBATCH --mem=16G
#SBATCH --time=5-00:00:00

module load cuda
echo; echo
nvidia-smi
echo; echo
python_interpreter="../../maastro_env/bin/python3"
python_file="./training_script.py"
data_config_file="./config_files/data-crFHN_rs113-petct_default.yaml"
nn_config_file="./config_files/nn-msam3d_default.yaml"
trainval_config_file="./config_files/trainval-default.yaml"
run_name="crFHN-msam3d-petct-cvCHUM-gtvweighted-histfix"
$python_interpreter $python_file --data_config_file $data_config_file \
                                 --nn_config_file $nn_config_file \
                                 --trainval_config_file $trainval_config_file \
                                 --run_name $run_name 
