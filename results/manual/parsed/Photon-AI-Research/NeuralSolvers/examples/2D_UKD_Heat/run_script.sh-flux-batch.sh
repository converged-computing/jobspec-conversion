#!/bin/bash
#FLUX: --job-name=salted-nunchucks-7443
#FLUX: -c=6
#FLUX: --priority=16

module load cuda/11.2
module load python
module load gcc/5.5.0
module load openmpi/3.1.2
source /home/zhdano82/hpmtraining/horoenv/bin/activate
cd /home/zhdano82/hpmtraining/ukd/NeuralSolvers/examples/2D_UKD_Heat
mpirun -np 4 \
    -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x PATH \
    -mca pml ob1 -mca btl ^openib \
    python pennes_hpm_.py --num_t 2999 --name 05_hpm --epochs_pt 1 --epochs 100 --path_data /home/zhdano82/hpmtraining/smooth_data/data_0_05/ --use_horovod 1 --batch_size 512  --weight_j 0.01 --pretrained 1 --pretrained_name '05'
