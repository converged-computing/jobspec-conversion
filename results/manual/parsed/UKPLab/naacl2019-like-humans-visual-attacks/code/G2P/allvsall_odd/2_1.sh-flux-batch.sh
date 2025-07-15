#!/bin/bash
#FLUX: --job-name=swampy-peanut-6305
#FLUX: --priority=16

python3 /home/se55gyhe/Act_func/sequence_tagging/arg_min/G2P-my_LSTM-act1_save_new_odd.py tanh 50 Adamax 1 0.32873413360732373 0.002314007172161447 orth 1.0 efile.norm.2_1 odd_G2P_2_1/
