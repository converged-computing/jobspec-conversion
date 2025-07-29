#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --mem=100GB
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export CUDA_VISIBLE_DEVICES='0,1,2,3'

source satori/setup_satori.sh
cat > launch.sh << EoF_s
export CUDA_VISIBLE_DEVICES=0,1,2,3
exec \$*
EoF_s
chmod +x launch.sh
if $PROFILE; then
   NSYS="nsys profile --trace=nvtx,cuda,mpi --output=${COMMON}/report_N${SLURM_JOB_NUM_NODES}_R${RESOLUTION}_${PRECISION}"
fi
$NSYS srun --mpi=pmi2 ./launch.sh $JULIA --check-bounds=no --project experiments/run.jl ${RESOLUTION:=3}
