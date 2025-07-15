#!/bin/bash
#FLUX: --job-name=nerdy-house-0719
#FLUX: -t=72000
#FLUX: --priority=16

. /etc/profile.d/modules.sh
module purge
module load rhel8/default-amp
module load python/3.8 cuda/11.2 cudnn/8.1_cuda-11.2
module load miniconda/3
source /home/ir-mien1/.bashrc
source /home/ir-mien1/anaconda3/bin/activate ctlearn
/home/ir-mien1/anaconda3/envs/ctlearn/bin/python3 /home/ir-mien1/anaconda3/envs/ctlearn/bin/ctlearn -d TRN -i /home/ir-mien1/rds/rds-iris-ip007/ir-niet1/datasets/DL1_Prod5_merged/gamma-diffuse/train/ -o /home/ir-mien1/rds/rds-iris-ip007/ir-mien1/logs/LSTCam_TRN_energy_ctlearn6/ -t LST_LST_LSTCam -r energy -z 50 -l 0.2 -e 5 -b 64 --log_to_file --mode train -s $SLURM_ARRAY_TASK_ID
