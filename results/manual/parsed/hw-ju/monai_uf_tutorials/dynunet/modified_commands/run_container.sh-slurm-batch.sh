#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=a100:1
#SBATCH --mem=64gb
#SBATCH --time=01:00:00

date;hostname;pwd
module load singularity
echo "pip3 freeze | grep ignite"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
pip3 freeze | grep ignite
echo "import ignite; print(ignite.__version__)"
singularity exec --nv /blue/vendor-nvidia/hju/monaicore1.0.1 \
python3 -c "import ignite; print(ignite.__version__)"
