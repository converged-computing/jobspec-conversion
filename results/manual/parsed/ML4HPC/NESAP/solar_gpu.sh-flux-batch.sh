#!/bin/bash
#FLUX: --job-name=solar_05
#FLUX: -N=32
#FLUX: -n=256
#FLUX: --queue=regular
#FLUX: -t=86400
#FLUX: --urgency=16

module load pytorch/v1.0.1
which python
echo "==================================="
echo ""
srun python ../../LSTNet_MPI_cpu.py --hidSkip 10 --batch_size 16 --data_amp_size 1 --epochs 20 --gpu 8 --data ../../data/solar_AL.txt --save ../../save/solar.pt --output_fun Linear > screen_solar_001N_08n.out
