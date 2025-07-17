#!/bin/bash
#FLUX: --job-name=chocolate-frito-1209
#FLUX: --queue=ce-mri
#FLUX: -t=259200
#FLUX: --urgency=16

source ~/modules/matlab-mcx/source
source ~/modules/nccl/nccl_2.9.8-1+cuda11.0_x86_64/source
matlab -nodesktop -nosplash -r "generate_data(2, 'train', [1e5 1e6 1e7 1e8 1e9], 500, './validation-2D-128x128', false, [0 4], [128 128], '1')"
