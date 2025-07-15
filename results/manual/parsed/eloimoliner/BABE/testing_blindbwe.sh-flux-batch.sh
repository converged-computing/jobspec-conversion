#!/bin/bash
#FLUX: --job-name=matrix_testing_bwe_blind_1000
#FLUX: -t=3599
#FLUX: --priority=16

export TORCH_USE_RTLD_GLOBAL='YES'
export CUDA_LAUNCH_BLOCKING='1'

module load anaconda
source activate /scratch/work/molinee2/conda_envs/pytorch2
module load gcc/8.4.0
export TORCH_USE_RTLD_GLOBAL=YES
export CUDA_LAUNCH_BLOCKING=1
n=$SLURM_ARRAY_TASK_ID
n=93 #cocochorales brass
if [[ $n -eq 54 ]] 
then
    #ckpt="/scratch/work/molinee2/projects/ddpm/blind_bwe_diffusion/experiments/54_maestro_22k/22k_8s-850000.pt"
    ckpt="./experiments/maestro_piano/MAESTRO_22k_8s-850000.pt"
    exp=maestro22k_8s
    network=cqtdiff+
    #tester=blind_bwe_sweep
    #tester=bwe_formal_noguidance_3000_opt_2
    #tester=blind_bwe_formal_small_3000
    tester=blind_bwe_denoise       
    #tester=blind_bwe_mushra
    #tester=bwe_formal_1000_opt_robustness_1
    #tester=edm_DC_correction_longer
    dset=maestro_allyears
    CQT=True
    diff_params=edm
elif [[ $n -eq 65 ]] 
then
    ckpt="./experiments/COCOChorales_strings/COCOChorales_strings_16k_11s-190000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=blind_bwe_denoise_strings
    dset=CocoChorales_stems
    CQT=True
    diff_params=edm_chorales
elif [[ $n -eq 93 ]] 
then
    ckpt="./experiments/COCOChorales_brass/COCOChorales_brass_16k_11s-480000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=blind_bwe_denoise_brass
    dset=CocoChorales_stems
    CQT=True
    diff_params=edm_chorales
elif [[ $n -eq 94 ]] 
then
    ckpt="./experiments/COCOChorales_woodwind/COCOChorales_woodwind_16k_11s-390000.pt"
    exp=CocoChorales_16k_8s
    network=cqtdiff+
    tester=blind_bwe_denoise_woodwind
    dset=CocoChorales_stems
    CQT=True
    diff_params=edm_chorales
fi
PATH_EXPERIMENT=experiments/blind_bwe_tests/$n
mkdir $PATH_EXPERIMENT
python test.py model_dir="$PATH_EXPERIMENT" \
               dset=$dset \
               exp=$exp \
               network=$network \
               tester=$tester \
               tester.checkpoint=$ckpt \
               tester.filter_out_cqt_DC_Nyq=$CQT \
               diff_params=$diff_params 
