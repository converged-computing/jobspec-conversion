#!/bin/bash
#FLUX: --job-name=loopy-fudge-9631
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --urgency=16

PARRAY1=(0 1 2 3 4 5 6 7 8 9)
for i in {0..10}
    do
        let task_id=$i
        # printf $task_id"\n" # comment in for testing
        if [ "$task_id" -eq "$SLURM_ARRAY_TASK_ID" ]
        then
            p1=${PARRAY1[$i]}
            module load python/3.6
            mkdir -p $SLURM_TMPDIR/env/temp
            mkdir -p $SLURM_TMPDIR/data
            cp -r ~/Venv/temp/* $SLURM_TMPDIR/env/temp
            cp -r  ~/projects/rpp-bengioy/caotians/data/* $SLURM_TMPDIR/data
            #mkdir -p $SLURM_TMPDIR/data/NIHCC/images_224
            #tar -xzf $SLURM_TMPDIR/data/NIHCC/images_224.tar.gz -C $SLURM_TMPDIR/data/NIHCC/images_224 --strip-components=1
            tar -xzf $SLURM_TMPDIR/data/MURA/images_224.tar.gz -C $SLURM_TMPDIR/data/MURA
            tar -xf $SLURM_TMPDIR/data/PADChest/images-64.tar -C $SLURM_TMPDIR/data/PADChest
            tar -xzf $SLURM_TMPDIR/data/PADChest/images-299.tar.gz -C $SLURM_TMPDIR/data/PADChest
            unzip -q $SLURM_TMPDIR/data/malaria/cell_images.zip -d $SLURM_TMPDIR/data/malaria
            unzip -q $SLURM_TMPDIR/data/IDC/IDC_regular_ps50_idx5.zip -d $SLURM_TMPDIR/data/IDC
            source $SLURM_TMPDIR/env/temp/bin/activate
            python setup_datasets.py
            ln -sf $SLURM_TMPDIR/data workspace/datasets-$SLURM_JOBID
            export DISABLE_TQDM="True"
            python PCAM_eval_rand_seeds.py --root_path=workspace/datasets-$SLURM_JOBID --exp=PCAM_eval_seed_$p1 --seed=$p1 --batch-size=64 --no-visualize --save --workers=0
         fi
    done
