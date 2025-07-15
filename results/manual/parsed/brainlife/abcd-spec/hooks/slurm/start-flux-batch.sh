#!/bin/bash
#FLUX: --job-name=carnivorous-bits-8884
#FLUX: --priority=16

echo "----------------------"
date
hostname
whoami
echo "----------------------"
if [ ! -z $BRAINLIFE_LOCAL_VALIDATOR ] && [[ "$SERVICE" = brainlife/validator* ]]; then
        `dirname $0`/../direct/start
        exit $?
fi
set -e
rm -f exit-code
if [ -f brainlife ]; then
    main=brainlife
else
    if [ -f main ]; then
        main=main
    else
        echo "no main/brainlife script.. don't know how to start this"
        exit 1
    fi
fi
true > _jobheader
grep --regexp="^#PBS" $main >> _jobheader || true
grep --regexp="^#SBATCH" $main >> _jobheader || true
[ -f jobheader.sh ] && bash ./jobheader.sh >> _jobheader
[ ! -z "$SLURM_PARTITION" ] && echo "#SBATCH -p $SLURM_PARTITION" >> _jobheader
cp -aL $(which smon) .
sbatch_opt=""
if [[ $HOSTNAME == *"bridges.psc.edu" ]]; then
    sbatch_opt="-C EGRESS"
fi
if [ -z "$IGNORE_VMEM" ] && [[ $HOSTNAME != *".stampede2.tacc.utexas.edu" ]] && grep "vmem=" _jobheader > /dev/null; then
    mem=$(grep "vmem=" _jobheader | node -e '
        let str = "";
        process.stdin.on("data", (data)=>{ str += data; });
        process.stdin.on("close", ()=>{
                let pos = str.indexOf("vmem=");
                str = str.substring(pos+5).trim();
                let end = str.length;
                if(~str.indexOf(",")) end = str.indexOf(",");
                str = str.substring(0, end);
                console.log(str);
        });
    ')
    sbatch_opt="$sbatch_opt --mem=$mem"
fi
if [ ! -z "$IGNORE_PPN" ]; then
    #some cluster doesn't like ppn (like bridges2 gpu-shared - which treats it like cpus-per-gpu)
    echo "IGNORE_PPN set.. renmaing ppn":
    sed -i "s/ppn=/ppn_old=/g" _jobheader
fi
if [ ! -z "$IGNORE_VMEM" ]; then
    echo "IGNORE_VMEM set.. renaming vmem":
    sed -i "s/vmem=/vmem_old=/g" _jobheader
fi
if [ ! -z "$IGNORE_NODES" ]; then
    echo "IGNORE_NODES set.. renaming nodes":
    sed -i "s/nodes=/nodes_old=/g" _jobheader
fi
[ ! -z "$SBATCH" ] && sbatch_opt="$sbatch_opt $SBATCH"
if [[ $HOSTNAME == *"bridges.psc.edu" ]]; then
    echo "#!/bin/bash --login" > _main
else
    echo "#!/bin/bash" > _main
fi
cat _jobheader >> _main
if [ ! -z $APPEND_SLURM_JOBID_TMPDIR ]; then
        echo "export TMPDIR=\$TMPDIR/\$SLURM_JOBID" >> _main
        echo "mkdir -p \$TMPDIR" >> _main
fi
echo "[ ! -z \$TMPDIR ] && export SINGULARITY_LOCALCACHEDIR=\$TMPDIR" >> _main
echo "export SINGULARITYENV_MCR_CACHE_ROOT=\$PWD" >> _main
rm -f _smon.out
echo "./smon &" >> _main
echo "smonpid=\$!" >> _main
echo "./$main" >> _main
echo "echo \$? > .exit-code && mv .exit-code exit-code" >> _main
chmod +x $main #in case user forgets it
echo "kill \$smonpid" >> _main
set -x
sbatch $sbatch_opt --parsable -o "slurm-%j.log" -e "slurm-%j.err" _main | tail -1 > jobid
