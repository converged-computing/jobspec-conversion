#!/bin/bash
#SBATCH --account=def-simine
#SBATCH --output=slurm-%a.out
#SBATCH --error=slurm-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=249G
#SBATCH --time=00:10:00
#SBATCH --array=0-4

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'
export KMP_BLOCKTIME='0'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1}
export KMP_BLOCKTIME=0
module load julia
frame1=10000
nframes=1000
step=10
Ts=(40 100 200 300 400)
T=${Ts[SLURM_ARRAY_TASK_ID]}
tempdir="${T}K_initplanar_norotate"
if [[ ! -d  $tempdir ]]; then
	mkdir "$tempdir"
fi
cd $tempdir
cp ../run_files/* .
echo "Starting at: $(date)"
julia run_QuickArpackBigMAC_MD_multiframes.jl $T $frame1 $nframes $step
echo "Ending at: $(date)"
