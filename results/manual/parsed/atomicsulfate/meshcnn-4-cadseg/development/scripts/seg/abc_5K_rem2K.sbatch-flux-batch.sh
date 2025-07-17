#!/bin/bash
#FLUX: --job-name=MeshCNNABC5KRem2K
#FLUX: -c=40
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

echo $PWD
echo "Entering working directory"
echo $PWD
cd /home/users/m/mandadoalmajano/dev
echo "Activating virtual environment"
source /home/users/m/mandadoalmajano/.venvs/meshcnn/bin/activate 
type python
echo "running training"
python train.py --dataroot datasets/abc_5K_rem2K --name abc_5K_rem2K --arch meshunet --dataset_mode segmentation --ncf 32 64 128 256 512 --ninput_edges 2000 --pool_res 1600 1280 1024 850 --resblocks 3 --lr 0.001 --batch_size 32 --num_aug 1 --gpu_ids 0,1 
exitCode=$?
echo "done training. Exit code was $exitCode"
deactivate
exit $exitCode
