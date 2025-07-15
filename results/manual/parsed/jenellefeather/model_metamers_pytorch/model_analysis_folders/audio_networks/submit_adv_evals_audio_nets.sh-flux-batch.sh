#!/bin/bash
#FLUX: --job-name=behavior_plot
#FLUX: -c=4
#FLUX: --queue=mcdermott
#FLUX: -t=129600
#FLUX: --urgency=16

export CONDA_ENVS_PATH='~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files'

NETWORK_LIST=("cochresnet50" "kell2018" "cochresnet50_l2_1_robust_waveform" "cochresnet50_l2_p5_robust_waveform" "cochresnet50_linf_p002_robust_waveform" "kell2018_l2_1_robust_waveform" "kell2018_linf_p002_robust_waveform" "cochresnet50_l2_1_robust_cochleagram" "cochresnet50_l2_p5_robust_cochleagram" "kell2018_l2_1_robust_cochleagram" "kell2018_l2_p5_robust_cochleagram" "cochresnet50_l2_1_random_step_cochleagram" "cochresnet50_l2_1_random_step_waveform" "cochresnet50_linf_p002_random_step_waveform" "kell2018_l2_1_random_step_cochleagram" "kell2018_l2_1_random_step_waveform" "kell2018_linf_p002_random_step_waveform")
BUILD_MODEL=${NETWORK_LIST[$SLURM_ARRAY_TASK_ID]}
echo $BUILD_MODEL
cd $BUILD_MODEL
module add openmind/miniconda/2020-01-29-py3.7
module add openmind/cudnn/9.1-7.0.5
module add openmind/cuda/9.1
cp /om4/group/mcdermott/user/jfeather/projects/robust_audio_networks/robustness/analysis_scripts_metamers_paper/ensemble_eval_range_eps_audio.py . 
export CONDA_ENVS_PATH=~/my-envs:/om4/group/mcdermott/user/jfeather/conda_envs_files
source activate /om4/group/mcdermott/user/jfeather/conda_envs_files/pytorch
for RAND_SEED in 0 1 2 3 4; do 
    echo $RAND_SEED
    python ensemble_eval_range_eps_audio.py -R $RAND_SEED -N 1024 -I 64 -E 1 -B 16 -T '2' -D 4 -L -3 -M 2 -U 2
    python ensemble_eval_range_eps_audio.py -R $RAND_SEED -N 1024 -I 64 -E 1 -B 16 -T 'inf' -D 4 -L -5 -U 2
    python ensemble_eval_range_eps_audio.py -R $RAND_SEED -N 1024 -I 64 -E 1 -B 16 -T '1' -D 4 -L -1 -M 3 -U 2
done
