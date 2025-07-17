#!/bin/bash
#FLUX: --job-name=wobbly-cupcake-2563
#FLUX: -c=32
#FLUX: --queue=nltmp
#FLUX: -t=428400
#FLUX: --urgency=16

echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Job id is $SLURM_JOBID"
echo "Job submission directory is : $SLURM_SUBMIT_DIR"
eval "$(conda shell.bash hook)"
conda activate moco_work
srun python /nlsasfs/home/nltm-pilot/ashishs/DeloresM/upstream_SSSD_wm/train_moco.py \
    --input /nlsasfs/home/nltm-pilot/ashishs/DECAR/libri_100_new.csv \
    --batch-size 256 \
    --save-path /nlsasfs/home/nltm-pilot/ashishs/DeloresM/upstream_SSSD_wm/checkpoint_libri_100_new_arch_linear_projector_lr_007_cln_256_wm
