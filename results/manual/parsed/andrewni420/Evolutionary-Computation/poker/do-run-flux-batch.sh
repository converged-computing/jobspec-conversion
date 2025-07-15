#!/bin/bash
#FLUX: --job-name=anxious-dog-5529
#FLUX: --queue=gpu-a5000-q
#FLUX: -t=1800
#FLUX: --priority=16

export DJL_DEFAULT_ENGINE='MXNet'
export MXNET_ENGINE_TYPE='NaiveEngine'
export OMP_NUM_THREADS='1'

module load amh-clojure
module load cudnn8.5-cuda11.7
module load nccl2-cuda11.7-gcc9
module load cuda11.7/toolkit
export DJL_DEFAULT_ENGINE=PyTorch
export MXNET_ENGINE_TYPE=NaiveEngine
export OMP_NUM_THREADS=1
srun ./run-file.clj
module load amh-clojure
export DJL_DEFAULT_ENGINE=PyTorch
export MXNET_ENGINE_TYPE=NaiveEngine
export OMP_NUM_THREADS=1
srun --overlap lein run
module load amh-clojure
export DJL_DEFAULT_ENGINE=PyTorch
export MXNET_ENGINE_TYPE=NaiveEngine
export OMP_NUM_THREADS=1
srun --mpi pmix --overlap lein run
module load cm-pmix4/4.1.1
module load openmpi4/gcc/4.1.
module load amh-clojure
export DJL_DEFAULT_ENGINE=PyTorch
export MXNET_ENGINE_TYPE=NaiveEngine
export OMP_NUM_THREADS=1
srun --mpi pmix --overlap lein run
k-best-2-4-6-8
hardexp-2-4-6-8
stdev-0.001-2-4-8
gputest do-run
module load amh-clojure
module load cudnn8.1-cuda11.2
module load nccl2-cuda11.2-gcc9
module load cuda11.2/toolkit
export DJL_DEFAULT_ENGINE=MXNet
python -c 'import torch; print(torch.cuda.get_device_name(torch.cuda.current_device()))'
srun lein run
