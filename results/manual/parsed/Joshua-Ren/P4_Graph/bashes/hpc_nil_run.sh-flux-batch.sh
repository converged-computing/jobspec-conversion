#!/bin/bash
#FLUX: --job-name=pcba_nil
#FLUX: -c=2
#FLUX: --queue=ampere
#FLUX: -t=129600
#FLUX: --urgency=16

export NCCL_P2P_DISABLE='1'
export NCCL_IB_DISABLE='1'

export NCCL_P2P_DISABLE=1
export NCCL_IB_DISABLE=1
. /etc/profile.d/modules.sh
module purge
module load rhel8/default-amp
module load python/3.8 cuda/11.0 cudnn/8.0_cuda-11.1
source /home/sg955/glm-env/bin/activate
cd /home/sg955/GitWS/P4_Graph/
srun python main_nil.py --WD_ID joshua_shawn \
--config_file hiv_gcn_baseline
