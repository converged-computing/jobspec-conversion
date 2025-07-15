#!/bin/bash
#FLUX: --job-name=OSU-coll
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=1800
#FLUX: --priority=16

nr_ranks=128
echo -e "Case run:\n"
cat $0
echo -e "\n\n##########\n\n"
ml LUMI/%toolchainversion% partition/C
ml lumi-CPEtools/%CPEtoolsversion%-%toolchain%-%toolchainversion%%suffix%
ml OSU-Micro-Benchmarks/%OSUversion%-%toolchain%-%toolchainversion%%suffix%%cleanup%
echo -e "\nLoaded modules:\n"
module list 2>&1
echo -e "\n##########\n\nSingle-node runs:\n"
srun -N 1 -n $nr_ranks -c 1 mpi_check -r
echo -e "\nTwo-node runs:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 mpi_check -r
echo -e "\nOSU collectives bcast test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_bcast
echo -e "\nOSU collectives bcast test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_bcast
echo -e "\nOSU collectives barrier test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_barrier
echo -e "\nOSU collectives barrier test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_barrier
echo -e "\nOSU collectives alltoall test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_alltoall
echo -e "\nOSU collectives alltoall test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_alltoall
echo -e "\nOSU collectives allgather test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_allgather
echo -e "\nOSU collectives allgather test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_allgather
echo -e "\nOSU collectives allreduce test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_allreduce
echo -e "\nOSU collectives allreduce test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_allreduce
echo -e "\nOSU collectives gather test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_gather
echo -e "\nOSU collectives gather test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_gather
echo -e "\nOSU collectives reduce test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_reduce
echo -e "\nOSU collectives reduce test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_reduce
echo -e "\nOSU collectives scatter test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_scatter
echo -e "\nOSU collectives scatter test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_scatter
echo -e "\nOSU collectives ibcast test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_ibcast
echo -e "\nOSU collectives ibcast test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_ibcast
echo -e "\nOSU collectives ibarrier test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_ibarrier
echo -e "\nOSU collectives ibarrier test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_ibarrier
echo -e "\nOSU collectives ialltoall test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_ialltoall
echo -e "\nOSU collectives ialltoall test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_ialltoall
echo -e "\nOSU collectives iallgather test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_iallgather
echo -e "\nOSU collectives iallgather test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_iallgather
echo -e "\nOSU collectives iallreduce test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_iallreduce
echo -e "\nOSU collectives iallreduce test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_iallreduce
echo -e "\nOSU collectives igather test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_igather
echo -e "\nOSU collectives igather test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_igather
echo -e "\nOSU collectives ireduce test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_ireduce
echo -e "\nOSU collectives ireduce test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_ireduce
echo -e "\nOSU collectives iscatter test, 1 node:\n"
srun -N 1 -n $nr_ranks -c 1 osu_iscatter
echo -e "\nOSU collectives iscatter test, 2 nodes:\n"
srun -N 2 -n $(($nr_ranks*2)) -c 1 osu_iscatter
