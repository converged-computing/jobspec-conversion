#!/bin/bash
#FLUX: --job-name=ornery-general-1538
#FLUX: --urgency=16

echo "$SLURM_JOB_ID" > "$SLURM_JOB_ID"
eval "$(conda shell.bash hook)"
conda activate <path-to-conda-env>
echo "Hello World"
nvidia-smi
cfg="configs/real/r.txt"
python ddp_test_nerf.py --config "$cfg" --render_split train --testskip 10
python ddp_test_nerf.py --config "$cfg" --render_split drunk2 --testskip 10
python ddp_test_nerf.py --config "$cfg" --render_split drunk1 --testskip 10
python ddp_test_nerf.py --config "$cfg" --render_split drunk --testskip 10
echo Finished
