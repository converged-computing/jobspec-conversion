#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GuohongXie/MLP_RO/south_2/train/all/all_u_s_4layers_128_64_32_1_Relu_BZ32_LR1e-4_WD1e-6_noStepLRSchedule_noBN_noResnet_noLastRelu_.pbs
