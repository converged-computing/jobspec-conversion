#!/bin/bash
#SBATCH --account=def-lelis
#SBATCH --output=log/%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=00:24:00

module load python/3 cuda cudnn
source tensorflow/bin/activate
cd src/
python3 bee.py -t ${t} -d 0 -l ${t}_${a}_${m}.log -m bustle_model_0${m}.hdf5 -b bustle_benchmarks.txt -a "${a}" -p 14000000
