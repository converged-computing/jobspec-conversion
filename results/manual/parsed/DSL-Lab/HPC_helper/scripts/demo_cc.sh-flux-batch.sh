#!/bin/bash
#FLUX: --job-name=expressive-pancake-1753
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=8
#FLUX: -t=20
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'

MASTER_PORT=29400
module load gcc
module load cuda
module load nccl
module load openmpi
cd ${SLURM_SUBMIT_DIR}
source venvhpc/bin/activate
export OMP_NUM_THREADS=6
CUDA_VISIBLE_DEVICES=0 python main.py --batch_size=768 -m=cc_demo_single_gpu
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py --batch_size=3072 --dp -m=cc_demo_single_node_dp
CUDA_VISIBLE_DEVICES=0,1,2,3 torchrun --nnodes=1 --nproc_per_node=4 --master_port=$MASTER_PORT main.py --batch_size=3072 --ddp -m=cc_demo_single_node_ddp
mpirun -np 8 \
-x MASTER_ADDR=$(hostname) \
-x MASTER_PORT=$MASTER_PORT \
-x PATH \
-bind-to none -map-by :OVERSUBSCRIBE \
-mca pml ob1 -mca btl ^openib \
python main.py --batch_size=6144 --ddp -m=cc_demo_multiple_node_mpi_ddp
srun --nodes=2 --ntasks-per-node=1 --ntasks=2 torchrun --nnodes=2 --nproc_per_node=4 \
--rdzv_id=$SLURM_JOB_ID --rdzv_backend=c10d --rdzv_endpoint=$(hostname):$MASTER_PORT \
main.py --batch_size=6144 --ddp -m=cc_demo_multiple_node_srun_ddp
