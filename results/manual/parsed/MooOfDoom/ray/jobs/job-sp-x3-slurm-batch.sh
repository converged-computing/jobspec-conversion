#!/bin/bash
#SBATCH --job-name=job-sp-x3
#SBATCH --output=stats/job-sp-x3.o%j
#SBATCH --error=stats/job-sp-x3.e%j
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
for t in 64
   do
   export OMP_NUM_THREADS=$t
   for r in 512
      do
      for p in 16
         do
         for b in 4
            do
            for n in 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536
               do
               for s in 64
                  do
                  srun -n 1 build/ray -s data/rand_${n}_${s}.scn -r $r -p $p -b $b
               done
            done
         done
      done
   done
done
