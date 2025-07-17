#!/bin/bash
#FLUX: --job-name=crusty-citrus-1884
#FLUX: -c=20
#FLUX: --queue=gpu
#FLUX: -t=21599
#FLUX: --urgency=16

export PYTHONPATH='/home/shanli/visnav_semantics:$PYTHONPATH'

cd /home/shanli/visnav_semantics/Cycada/cyclegan
source /home/shanli/visnav_semantics/baseline/venvs/seg/bin/activate
module load gcc cmake python
export PYTHONPATH=/home/shanli/visnav_semantics:$PYTHONPATH
python test.py --name comballaz_pairwise --which_epoch 20 --model cycle_gan_semantic --dataroot /work/topo/VNAV/remade-data-fullsize/comballaz --phase train_sim train_drone_real
cp -r /work/topo/VNAV/remade-data-fullsize/comballaz/train_sim/styled_as_target/comballaz_pairwise/train_drone_sim_20/images/fake_B/* /work/topo/VNAV/remade-data-fullsize/comballaz/train_sim/styled_as_target
rm -rf /work/topo/VNAV/remade-data-fullsize/comballaz/train_sim/styled_as_target/comballaz_pairwise
