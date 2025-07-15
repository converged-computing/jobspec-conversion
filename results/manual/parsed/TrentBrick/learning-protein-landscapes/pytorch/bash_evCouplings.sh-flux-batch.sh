#!/bin/bash
#FLUX: --job-name=bumfuzzled-despacito-8300
#FLUX: --urgency=16

                                           # -N 1 means all cores will be on th$
hostname
pwd
module load gcc/6.2.0 cuda/9.0
srun stdbuf -oL -eL ~/anaconda3/bin/python run.py --tda 10000 \
--protein_length 0 --model_type neuralSpline --is_discrete False \
--gaussian_cov_noise 1.0 10.0 --exp_base_name Cont_Full_Len_GPU \
--MLepochs 600 --KLepochs 1000 --MLbatch 256 --KLbatch 1024 --KLweight 0.5 1.0 \
--random_seed 27 28 29 --save_partway_inter 0.2
