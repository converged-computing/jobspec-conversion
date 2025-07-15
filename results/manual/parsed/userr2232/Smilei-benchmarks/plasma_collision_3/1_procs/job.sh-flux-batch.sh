#!/bin/bash
#FLUX: --job-name=smilei
#FLUX: --priority=16

srun --mpi=pmix_v2 /home/reynaldo.rojas/smilei/Smilei/Smilei-benchmarks/plasma_collision_3/1_procs/smilei /home/reynaldo.rojas/smilei/Smilei/Smilei-benchmarks/plasma_collision_3/1_procs/plasma_collision.py
