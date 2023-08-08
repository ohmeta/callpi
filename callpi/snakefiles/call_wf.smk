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


include: "../rules/raw.smk"


rule all:
    input:
        rules.raw_all.input


