#!/bin/bash
#FLUX: --job-name=fancy new architecture
#FLUX: --queue=iris-hi
#FLUX: -t=259200
#FLUX: --urgency=16

source /sailhome/kayburns/.bashrc
conda activate py3.8_torch1.10.1
cd /iris/u/kayburns/new_arch/r3m/evaluation/
for shift in none bottom_left_copy_crop bottom_left_red_rectangle bottom_left_white_rectangle bottom_left_no_blue_rectangle top_right_red_rectangle
    do
    python r3meval/core/hydra_launcher.py hydra/launcher=local hydra/output=local \
        env="kitchen_sdoor_open-v3" camera="left_cap2" pixel_based=true \
        embedding=resnet50 env_kwargs.load_path=r3m \
        bc_kwargs.finetune=true proprio=9 job_name=eval seed=125 \
        eval.eval=True env_kwargs.shift=$shift eval_num_traj=10 \
        env_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-10_12-45-18/try_r3m/iterations/embedding_533.pickle \
        bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-10_12-45-18/try_r3m/iterations/policy_533.pickle
done
    # env_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-08_03-44-50/try_r3m/iterations/embedding_733.pickle \ #cross embodiment on kitchen left to right
    # bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-08_03-44-50/try_r3m/iterations/policy_733.pickle
    # env_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-09_09-04-41/try_r3m/iterations/embedding_999.pickle \
    # bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-09_09-04-41/try_r3m/iterations/policy_999.pickle
    # bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/r3meval/core/outputs/BC_pretrained_rep/2022-10-10_08-32-11/try_r3m/iterations/policy_333.pickle
    # all finetuned
    # bc_kwargs.load_path="/iris/u/kayburns/new_arch/r3m/evaluation/outputs/BC_pretrained_rep/2022-10-05_18-05-13/r3m_repro_all/iterations/policy_999.pickle" # 
    # head 2
    # bc_kwargs.load_path="/iris/u/kayburns/new_arch/r3m/evaluation/outputs/BC_pretrained_rep/2022-10-04_11-11-50/r3m_repro/iterations/policy_2857.pickle" # 42, 42
    # head 3
    # bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/outputs/BC_pretrained_rep/2022-09-28_23-47-08/r3m_repro/iterations/policy_2857.pickle # 52, 66 -> 24
    # bc_kwargs.load_path=/iris/u/kayburns/new_arch/r3m/evaluation/outputs/BC_pretrained_rep/2022-10-03_17-57-00/r3m_repro/iterations/policy_2857.pickle # 44
    # r3m
    # bc_kwargs.load_path="/iris/u/kayburns/new_arch/r3m/evaluation/outputs/BC_pretrained_rep/2022-10-04_11-22-39/r3m_repro/iterations/policy_2857.pickle"
