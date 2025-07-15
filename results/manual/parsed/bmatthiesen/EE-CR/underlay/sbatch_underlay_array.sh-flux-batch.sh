#!/bin/bash
#FLUX: --job-name=muffled-nunchucks-8029
#FLUX: -t=172799
#FLUX: --priority=16

export UNDERLAY_HPC_SAVEDIR='/scratch/p_mimo/bho/underlay_OOBIF-2'
export UNDERLAY_WP_SUFFIX='_PIF1=-10dBW_d1=1000m_PIF2=-30dBW_d2=600m'

export UNDERLAY_HPC_SAVEDIR="/scratch/p_mimo/bho/underlay_OOBIF-2"
export UNDERLAY_WP_SUFFIX="_PIF1=-10dBW_d1=1000m_PIF2=-30dBW_d2=600m"
module load matlab
srun matlab -nodesktop -nodisplay -nosplash -r underlay_EE
