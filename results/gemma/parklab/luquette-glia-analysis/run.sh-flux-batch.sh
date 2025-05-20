#!/bin/bash
# Flux batch script

# Resources
# Flux uses a different syntax for resource requests.  We'll translate the Slurm requests.
# Flux doesn't have partitions or accounts in the same way.  We'll use tags for similar effect.
# Flux uses a single --cpus argument for core count.
# Flux uses --mem for memory.
# Flux uses --time for walltime.

# Set tags to mimic Slurm partition and account
export FLUX_TAGS="partition=priopark,account=park_contrib"

# Walltime (HH:MM:SS)
export FLUX_TIME="2:00:00"  # 120 minutes converted to 2 hours

# Memory (in MB)
export FLUX_MEM="32768" # 32GB converted to MB

# Number of cores (adjust based on snakemake flags)
# The script dynamically sets the number of cores.  We'll start with a default and adjust.
export FLUX_CPUS=12

# Software setup
module load slurm-drmaa  # While not directly used by Flux, the script requires it.

# Check for sentieon
which sentieon
if [ "x$?" == "x1" ]; then
    echo "sentieon is not on your \$PATH and might not be properly enabled. be sure to set the"
    echo "following environment variables:"
    echo "export SENTIEON_LICENSE=address_of_license_server:portnumber"
    echo "export SENTIEON_INSTALL_DIR=/path/to/sentieon_toplevel"
    echo "export PATH=\$PATH:/path/to/sentieon_toplevel/bin"
    exit 1
fi

word=$1
shift

flags='-s=snakemake/Snakefile --dir=. --latency-wait=60 --resources localjob=1 roadmap_download=10 encode_download=10 ucsc_download=10 --rerun-incomplete'
jobflag='-j=10'
kgflag=''
drmaaflag=''
usedrmaa='false'

if [ "x$word" == 'xdry' ]; then
    flags="$flags $@ --dryrun --quiet"
elif [ "x$word" == 'xdryreason' ]; then
    flags="$flags $@ --dryrun --reason"
elif [ "x$word" == 'xunlock' ]; then
    flags="$flags --unlock"
elif [ "x$word" == 'xmake_pcawg_metadata' ]; then
    flags="$flags --config make_pcawg_metadata=1 --until metadata/pcawg_metadata.csv"
elif [ "x$word" == 'xtest' ]; then
    flags="$flags $@"
    jobflag='-j=1'
    kgflag=''
elif [ "x$word" == 'xlocal' ]; then
    flags="$flags $@"
    jobflag='-j=6'
    kgflag='--keep-going'
elif [ "x$word" == "xcluster" ]; then
    mkdir -p cluster-logs
    usedrmaa='true'
    jobflag='-j=1000'
    kgflag='--keep-going'
    flags="$flags $@ --max-status-checks-per-second=0.5"
    export FLUX_CPUS=1000 # Increase cores for cluster mode
else
    echo "usage: $0 {dry,unlock,make_pcawg_metadata,test,local,cluster} [optional snakemake arguments]"
    exit 1
fi

# Run snakemake
if [ $usedrmaa == "true" ]; then
    snakemake $flags $kgflag $jobflag --slurm --default-resources slurm_account=park_contrib slurm_partition=priopark runtime=2880
else
    echo "snakemake $flags $kgflag --max-threads=12 $jobflag"
    snakemake $flags $kgflag --max-threads=12 $jobflag
fi