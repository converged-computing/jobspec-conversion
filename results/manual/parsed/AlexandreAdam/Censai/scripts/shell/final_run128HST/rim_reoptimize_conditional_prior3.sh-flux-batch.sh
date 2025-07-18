#!/bin/bash
#FLUX: --job-name=Optim_RIM_over_posterior
#FLUX: -c=3
#FLUX: -t=86400
#FLUX: --urgency=16

source $HOME/environments/censai3.8/bin/activate
python $CENSAI_PATH/scripts/rim_reoptimize_conditional_prior.py\
  --experiment_name=optim3_posterior_mse_highSNR\
  --dataset=lenses128hst_TNG_rau_200k_control_denoised_testset_validated\
  --model=RIMSU128hstv4_augmented_003_K3_L5_BCL2_211124140837_continue_lr6e-05_211129202839\
  --source_vae=VAE1_COSMOSFR_001_F16_NLleaky_relu_LS32_betaE0.1_betaDS100000_220112114306\
  --kappa_vae=VAE1_128hstfr_002_LS16_dr0.7_betaE0.2_betaDS5000_211115153537\
  --size=3000\
  --sample_size=2\
  --buffer_size=1000\
  --observation_coherence_bins=40\
  --source_coherence_bins=40\
  --kappa_coherence_bins=40\
  --seed=42\
  --learning_rate=1e-5\
  --re_optimize_steps=2000
