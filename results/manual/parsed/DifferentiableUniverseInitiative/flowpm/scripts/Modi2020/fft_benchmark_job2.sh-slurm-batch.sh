#!/bin/bash
#SBATCH --account=m1759
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --time=00:30:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1,gpu

module purge && module load  esslurm gcc/7.3.0 python3 cuda/10.1.243
for nc in 128; do 
    nx=16
    ny=1
    echo
    echo Starting $nx $ny
    if [[ $(find ./fft-timelogs/log_$nc-b1$nx-b2$ny -type f -size +1000c 2>/dev/null) ]]
       then
	   echo ./fft-timelogs/log_$nc-b1$nx-b2$ny exists
    else
	time srun python fft_benchmark.py --cube_size=$nc --batch_size=1 --mesh_shape="b1:$nx;b2:$ny" --layout="nx:b1;ny:b2" --output_file="timeline-b1$nx-b2$ny" > ./fft-timelogs/log_$nc-b1$nx-b2$ny
    fi
    nx=8
    ny=2
    echo
    echo Starting $nx $ny
    if [[ $(find ./fft-timelogs/log_$nc-b1$nx-b2$ny -type f -size +1000c 2>/dev/null) ]]
       then
	   echo ./fft-timelogs/log_$nc-b1$nx-b2$ny exists
    else
	time srun python fft_benchmark.py --cube_size=$nc --batch_size=1 --mesh_shape="b1:$nx;b2:$ny" --layout="nx:b1;ny:b2" --output_file="timeline-b1$nx-b2$ny" > ./fft-timelogs/log_$nc-b1$nx-b2$ny
    fi
    nx=4
    ny=4
    echo
    echo Starting $nx $ny
    if [[ $(find ./fft-timelogs/log_$nc-b1$nx-b2$ny -type f -size +1000c 2>/dev/null) ]]
       then
	   echo ./fft-timelogs/log_$nc-b1$nx-b2$ny exists
    else
	time srun python fft_benchmark.py --cube_size=$nc --batch_size=1 --mesh_shape="b1:$nx;b2:$ny" --layout="nx:b1;ny:b2" --output_file="timeline-b1$nx-b2$ny" > ./fft-timelogs/log_$nc-b1$nx-b2$ny
    fi
    nx=2
    ny=8
    echo
    echo Starting $nx $ny
    if [[ $(find ./fft-timelogs/log_$nc-b1$nx-b2$ny -type f -size +1000c 2>/dev/null) ]]
       then
	   echo ./fft-timelogs/log_$nc-b1$nx-b2$ny exists
    else
	time srun python fft_benchmark.py --cube_size=$nc --batch_size=1 --mesh_shape="b1:$nx;b2:$ny" --layout="nx:b1;ny:b2" --output_file="timeline-b1$nx-b2$ny" > ./fft-timelogs/log_$nc-b1$nx-b2$ny
    fi
    nx=1
    ny=16
    echo
    echo Starting $nx $ny
    if [[ $(find ./fft-timelogs/log_$nc-b1$nx-b2$ny -type f -size +1000c 2>/dev/null) ]]
       then
	   echo ./fft-timelogs/log_$nc-b1$nx-b2$ny exists
    else
	time srun python fft_benchmark.py --cube_size=$nc --batch_size=1 --mesh_shape="b1:$nx;b2:$ny" --layout="nx:b1;ny:b2" --output_file="timeline-b1$nx-b2$ny" > ./fft-timelogs/log_$nc-b1$nx-b2$ny
    fi
done
