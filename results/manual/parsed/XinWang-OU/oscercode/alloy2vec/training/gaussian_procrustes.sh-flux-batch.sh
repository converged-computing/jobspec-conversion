#!/bin/bash
#FLUX: --job-name=faux-platanos-9980
#FLUX: --queue=cm3atou
#FLUX: -t=360000
#FLUX: --urgency=16

module load Python/3.8.6-GCCcore-10.2.0
source /home/xinwang/my_python_envs/python38/bin/activate
python "/ourdisk/hpc/cm3atou/dont_archive/xinwang/alloy2vec-main/alloy2vec/training/gaussian_procrustes.py" "/ourdisk/hpc/cm3atou/dont_archive/xinwang/alloy2vec-main/alloy2vec/training/models/updated_1model_all" "/ourdisk/hpc/cm3atou/dont_archive/xinwang/alloy2vec-main/alloy2vec/training/timeslice_model/" --output "/ourdisk/hpc/cm3atou/dont_archive/xinwang/alloy2vec-main/alloy2vec/training/aligned_timeslice_models/"
