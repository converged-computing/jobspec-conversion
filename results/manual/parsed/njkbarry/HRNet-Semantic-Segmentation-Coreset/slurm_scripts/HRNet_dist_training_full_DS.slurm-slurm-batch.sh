#!/bin/bash
#FLUX: --job-name=HRNet-dist-training-full-DS
#FLUX: -c=16
#FLUX: --queue=gpu-a100
#FLUX: -t=82800
#FLUX: --urgency=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/gpfs/projects/punim1896/coresets/repositories/HRNet-Semantic-Segmentation/
module purge
module load fosscuda/2020b
module load pytorch/1.7.1-python-3.8.6
module load opencv/4.5.1-python-3.8.6-contrib
module load pyyaml/5.3.1-python-3.8.6
module load cython/0.29.22
module load ninja/1.10.1-python-3.8.6
module load tqdm/4.60.0
source venv/bin/activate
python -m torch.distributed.launch --nproc_per_node=4 tools/train.py --cfg experiments/cityscapes/seg_hrnet_ocr_w48_train_512x1024_sgd_lr1e-2_wd5e-4_bs_12_epoch484.yaml
my-job-stats -a -n -s
