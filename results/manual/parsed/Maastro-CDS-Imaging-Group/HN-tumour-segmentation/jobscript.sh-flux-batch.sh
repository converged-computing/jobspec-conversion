#!/bin/bash
#FLUX: --job-name=crFHN-msam3d-petct-cvCHUM-gtvweighted-histfix
#FLUX: -c=4
#FLUX: -t=432000
#FLUX: --urgency=16

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
