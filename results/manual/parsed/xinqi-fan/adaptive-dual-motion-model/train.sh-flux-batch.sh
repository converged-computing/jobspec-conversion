#!/bin/bash
#FLUX: --job-name=boopy-malarkey-2270
#FLUX: -c=6
#FLUX: --queue=gpu_7d1g
#FLUX: --urgency=16

module load gcc openmpi/4.0.5/gcc/8.3.0
module load cuda/11.0.2 cuda/blas/11.0.2 cuda/fft/11.0.2
source activate pytorch160
nvidia-smi
cd /home/xinqifan2/Project/adaptive-dual-motion-model
echo "casme2"
python run.py --config config/casme2-256.yaml --checkpoint checkpoints_casme2/vox-cpk.pth.tar
echo "smic"
python run.py --config config/smic-256.yaml --checkpoint checkpoints_smic/vox-cpk.pth.tar
echo "samm"
python run.py --config config/samm-256.yaml --checkpoint checkpoints_samm/vox-cpk.pth.tar
