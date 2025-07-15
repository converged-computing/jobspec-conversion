#!/bin/bash
#FLUX: --job-name=matrix_testing_bwe_blind_1000
#FLUX: -t=170999
#FLUX: --priority=16

export TORCH_USE_RTLD_GLOBAL='YES'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/pytorch2
module load gcc/8.4.0
export TORCH_USE_RTLD_GLOBAL=YES
n=65 #cocochorales strings
namerun=training
name="${n}_$namerun"
PATH_EXPERIMENT=experiments/$n
mkdir $PATH_EXPERIMENT
if [[ $n -eq 54 ]] 
then
    #ckpt="/scratch/work/molinee2/projects/ddpm/blind_bwe_diffusion/experiments/54_maestro_22k/22k_8s-850000.pt"
    ckpt="./experiments/maestro_piano/MAESTRO_22k_8s-850000.pt"
    exp=maestro22k_8s
    network=cqtdiff+
    tester=basic_tester       
    dset=maestro_allyears
    CQT=True
    diff_params=edm
    logging=basic_logging
elif [[ $n -eq 65 ]] 
then
    ckpt="./experiments/COCOChorales_strings/COCOChorales_strings_16k_11s-190000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=basic_tester       
    dset=CocoChorales_stems_strings
    CQT=True
    diff_params=edm_chorales
    logging=basic_logging
elif [[ $n -eq 93 ]] 
then
    ckpt="./experiments/COCOChorales_woodwind/COCOChorales_woodwind_22k_8s-480000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=basic_tester       
    dset=CocoChorales_stems_woodwind
    CQT=True
    diff_params=edm_chorales
    logging=basic_logging
elif [[ $n -eq 94 ]] 
then
    ckpt="./experiments/COCOChorales_brass/COCOChorales_brass_22k_8s-390000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=basic_tester       
    dset=CocoChorales_stems_brass
    CQT=True
    diff_params=edm_chorales
    logging=basic_logging
fi
python train.py model_dir="$PATH_EXPERIMENT" dset=$dset exp=$exp network=$network diff_params=$diff_params tester=$tester logging=$logging exp.batch=4
