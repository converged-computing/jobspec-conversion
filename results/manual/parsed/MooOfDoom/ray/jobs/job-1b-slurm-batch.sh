#!/bin/bash
#SBATCH --job-name=job-1b
#SBATCH --output=stats/job-1b.o%j
#SBATCH --error=stats/job-1b.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=knl

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export OMP_SCHEDULE='static'

export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export OMP_SCHEDULE=static
for t in 1
   do
   export OMP_NUM_THREADS=$t
   for r in 256
      do
      for p in 1 2 4 8 16
         do
         for b in 8
            do
            srun -n 1 build/ray -r $r -p $p -b $b
         done
      done
   done
done
