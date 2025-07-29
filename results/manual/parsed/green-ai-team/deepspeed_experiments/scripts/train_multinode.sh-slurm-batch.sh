#!/bin/bash
#SBATCH --job-name=MULTINODE
#SBATCH --output=multinode.log
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=12G

module load python/anaconda3 compilers/cmake-3.20 compilers/gcc-8.3.0 gpu/cuda-11.1
source activate mark15
nvidia-smi topo -m 
CMD="train_multinode.py --epochs 1 --batch_size 10 --fp16 \
                    --zero_stage 2 \
                    --dalle_output_file_name ../models/dalle-birds \
                    --image_text_folder ../data/birds-merged/ \
                    --vae_path ../models/vae-birds-final.pt \
                    --wandb_name dalle --wandb_entity darayavaus \
                    --distributed_backend deepspeed"
WORLD_SIZE=2 GPUS_PER_NODE=1 COMM_PATH=/trinity/home/d.cherniuk/transformer_project/scripts/comm.txt srun python $CMD
