#!/bin/bash
#FLUX: --job-name=arid-pot-3564
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --urgency=16

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
