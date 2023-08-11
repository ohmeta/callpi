#!/usr/bin/env snakemake

import sys
from pprint import pprint
import pandas as pd
from snakemake.utils import min_version

min_version("7.0")
shell.executable("bash")

sys.path.insert(0, "/home/jiezhu/toolkit/callpi")
import callpi


CALLPI_DIR = callpi.__path__[0]
WRAPPER_DIR = os.path.join(CALLPI_DIR, "wrappers")

pprint(CALLPI_DIR)

SAMPLES, DATA_TYPE = callpi.parse_samples(config["params"]["samples"])

SAMPLES_ID_LIST = SAMPLES.index.unique()


include: "../rules/raw.smk"
include: "../rules/gtpro.smk"


rule all:
    input:
        rules.raw_all.input,
        rules.calling_all.input


