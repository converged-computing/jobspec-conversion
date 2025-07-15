#!/bin/bash
#FLUX: --job-name=job-1d
#FLUX: -t=1800
#FLUX: --urgency=16

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
      for p in 32
         do
         for b in 8
            do
            srun -n 1 build/ray -r $r -p $p -b $b
         done
      done
   done
done
