#!/bin/bash
#SBATCH --job-name=hw4_v100_computations
#SBATCH --output=%x.out
#SBATCH --mail-user=aditya.wagh@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=64GB
#SBATCH --time=01:00:00

module purge
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 1 -e 2 -bs 32"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 1 -e 2 -bs 128"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 1 -e 2 -bs 512"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 1 -e 2 -bs 2048"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 1 -e 2 -bs 8192"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 2 -e 2 -bs 32"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 2 -e 2 -bs 128"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 2 -e 2 -bs 512"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 2 -e 2 -bs 2048"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 2 -e 2 -bs 8192"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 2 -bs 32"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 2 -bs 128"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 2 -bs 512"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 2 -bs 2048"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 2 -bs 8192"
singularity exec --nv \
--overlay /scratch/amw9425/images/pytorch/my_pytorch.ext3:ro \
/scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python lab4.py -ndev 4 -e 5 -bs 2048"
