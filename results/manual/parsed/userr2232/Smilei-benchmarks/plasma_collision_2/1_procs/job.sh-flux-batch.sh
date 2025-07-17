#!/bin/bash
#FLUX: --job-name=smilei
#FLUX: --urgency=16

srun --mpi=pmix_v2 /home/reynaldo.rojas/smilei/Smilei/Smilei-benchmarks/plasma_collision_2/1_procs/smilei /home/reynaldo.rojas/smilei/Smilei/Smilei-benchmarks/plasma_collision_2/1_procs/plasma_collision.py
