#!/bin/bash
#SBATCH --job-name=my_pfn
#SBATCH --account=higgsgpu
#SBATCH --output=/hpcfs/cepc/higgsgpu/wuzuofei/My_Net/ParticleFlowNetwork/output/my_log/PFN_gputest.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem-per-cpu=4096
#SBATCH --partition=gpu
#SBATCH --qos=debug

 ulimit -d unlimited
 ulimit -f unlimited
 ulimit -l unlimited
 ulimit -n unlimited
 ulimit -s unlimited
 ulimit -t unlimited
 srun -l hostname
 /usr/bin/nvidia-smi -L
 echo "Allocate GPU cards : ${CUDA_VISIBLE_DEVICES}"
 nvidia-smi
 # >>> conda initialize >>>
 # !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$('/hpcfs/cepc/higgsgpu/wuzuofei/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
 if [ $? -eq 0 ]; then
     eval "$__conda_setup"
 else    
     if [ -f "/hpcfs/cepc/higgsgpu/wuzuofei/miniconda3/etc/profile.d/conda.sh" ]; then
         . "/hpcfs/cepc/higgsgpu/wuzuofei/miniconda3/etc/profile.d/conda.sh"
     else   
         export PATH="/hpcfs/cepc/higgsgpu/wuzuofei/miniconda3/bin:$PATH"
     fi      
 fi
 unset __conda_setup
 # <<< conda initialize <<<
 conda activate weaver
 which python 
python -u script_GPUonly/my_train_DDP.py gputest
