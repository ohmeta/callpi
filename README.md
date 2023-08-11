# callpi (WIP)

## Feature
- metaSNV
- SGVFinder
- gt-pro

## Installation

```
git clone https://github.com/ohmeta/callpi
```

## Run

### Help

```
callpi --help

usage: callpi [-h] [-v]  ...

    ██████  █████  ██      ██      ██████  ██
   ██      ██   ██ ██      ██      ██   ██ ██
   ██      ███████ ██      ██      ██████  ██
   ██      ██   ██ ██      ██      ██      ██
    ██████ ██   ██ ███████ ███████ ██      ██

       Omics for All, Open Source for All

A general profiling system focus on robust microbiome research

options:
  -h, --help     show this help message and exit
  -v, --version  print software version and exit

available subcommands:

    init         init project
    simulate_wf  simulate reads
    calling_wf   metagenome-calling pipeline
```

### Init

```
usage: callpi init [-h] [-d WORKDIR] [--check-samples] [-s SAMPLES] [-b {simulate,calling}]

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  -s, --samples SAMPLES
                        desired input:
                        samples list, tsv format required.

                        if begin from trimming, rmhost, or calling:
                            if it is fastq:
                                the header is: [sample_id, short_forward_reads, short_reverse_reads]
                            if it is sra:
                                the header is: [sample_id, sra]

                        if begin from simulate:
                                the header is: [id, genome, abundance, reads_num, model]

  -b, --begin {simulate,calling}
                        pipeline starting point (default: calling)
```

### calling_wf

```
callpi calling_wf --help

usage: callpi calling_wf [-h] [-d WORKDIR] [--check-samples] [--config CONFIG] [--cores CORES]
                         [--local-cores LOCAL_CORES] [--jobs JOBS] [--list] [--debug] [--dry-run] [--run-local]
                         [--run-remote] [--cluster-engine {slurm,sge,lsf,pbs-torque}] [--wait WAIT] [--use-conda]
                         [--conda-prefix CONDA_PREFIX] [--conda-create-envs-only]
                         [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are prepare_reads_all, raw_all, calling_snp_gtpro_all, calling_all, all (default: all)

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  --config CONFIG       config.yaml (default: ./config.yaml)
  --cores CORES         all job cores, available on '--run-local' (default: 240)
  --local-cores LOCAL_CORES
                        local job cores, available on '--run-remote' (default: 8)
  --jobs JOBS           cluster job numbers, available on '--run-remote' (default: 30)
  --list                list pipeline rules
  --debug               debug pipeline
  --dry-run             dry run pipeline
  --run-local           run pipeline on local computer
  --run-remote          run pipeline on remote cluster
  --cluster-engine {slurm,sge,lsf,pbs-torque}
                        cluster workflow manager engine, support slurm(sbatch) and sge(qsub) (default: slurm)
  --wait WAIT           wait given seconds (default: 60)
  --use-conda           use conda environment
  --conda-prefix CONDA_PREFIX
                        conda environment prefix (default: ~/.conda/envs)
  --conda-create-envs-only
                        conda create environments only
```

### calling_wf example

```

```
