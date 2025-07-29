#!/bin/bash
#SBATCH --job-name=solar_05
#SBATCH --account=m1759
#SBATCH --output=hostname_%j.out
#SBATCH --error=hostname_%j.err
#SBATCH --nodes=32
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=8

module load pytorch/v1.0.1
which python
echo "==================================="
echo ""
srun python ../../LSTNet_MPI_cpu.py --hidSkip 10 --batch_size 16 --data_amp_size 1 --epochs 20 --data ../../data/solar_AL.txt --save ../../save/solar.pt --output_fun Linear > screen_solar_001N_08n.out
