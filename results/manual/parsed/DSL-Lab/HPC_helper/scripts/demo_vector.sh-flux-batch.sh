#!/bin/bash
#FLUX: --job-name=demo_vector
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=8
#FLUX: --queue=rtx6000
#FLUX: -t=20
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'

MASTER_PORT=29400
module use /pkgs/environment-modules/
module load python/3.8
module load cuda-11.7
source /scratch/ssd004/scratch/qiyan/venvmtr/bin/activate
cd /fs01/home/qiyan/DSL-MTR/tools
cd ${SLURM_SUBMIT_DIR}
source venvhpc/bin/activate
export OMP_NUM_THREADS=6
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
CUDA_VISIBLE_DEVICES=0 python main.py --batch_size=512 -m=vector_demo_single_gpu
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
CUDA_VISIBLE_DEVICES=0,1,2,3 python main.py --batch_size=2048 --dp -m=vector_demo_single_node_dp
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
CUDA_VISIBLE_DEVICES=0,1,2,3 torchrun --nnodes=1 --nproc_per_node=4 --master_port=$MASTER_PORT main.py --batch_size=2048 --ddp -m=vector_demo_single_node_ddp
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
mpirun -np 8 \
-x MASTER_ADDR=$(hostname) \
-x MASTER_PORT=$MASTER_PORT \
-x PATH \
-bind-to none -map-by :OVERSUBSCRIBE \
-mca pml ob1 -mca btl ^openib \
python main.py --batch_size=2048 --ddp -m=vector_demo_multiple_node_mpi_ddp
(while true; do nvidia-smi; top -b -n 1 | head -20; sleep 10; done) &
srun --nodes=2 --ntasks-per-node=1 --ntasks=2 torchrun --nnodes=2 --nproc_per_node=4 \
--rdzv_id=$SLURM_JOB_ID --rdzv_backend=c10d --rdzv_endpoint=$(hostname):$MASTER_PORT \
main.py --batch_size=2048 --ddp -m=vector_demo_multiple_node_srun_ddp
