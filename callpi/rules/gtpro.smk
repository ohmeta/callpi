rule calling_snp_gtpro:
    input:
        os.path.join(config["output"]["raw"], "reads/{sample}/{sample}.json")
    output:
        res = os.path.join(
            config["output"]["calling"], "profiles/gtpro/{sample}/{sample}.tsv.gz"),
        res_anno = os.path.join(
            config["output"]["calling"], "profiles/gtpro/{sample}/{sample}.anno.tsv.gz")
    log:
        os.path.join(config["output"]["calling"], "logs/calling_snp_gtpro/{sample}.log")
    benchmark:
        os.path.join(config["output"]["calling"], "benchmark/calling_snp_gtpro/{sample}.txt")
    params:
        sample_id = "{sample}",
        db = config["params"]["gtpro"]["database"],
        db_anno = config["params"]["gtpro"]["database_annotation"],
        gtpro = config["params"]["gtpro"]["script"]
    shell:
        '''
        OUTDIR=$(dirname {output.res})
        rm -rf $OUTDIR
        mkdir -p $OUTDIR

        OUTTSV=${{output.res%.gz}}
        OUTTSVANNO=${{output.res_anno%.gz}}

        R1=$(jq -r -M '.PE_FORWARD' {input} | sed 's/^null$//g')
        R2=$(jq -r -M '.PE_REVERSE' {input} | sed 's/^null$//g')
        RS=$(jq -r -M '.SE' {input} | sed 's/^null$//g')

        if [ "$R1" != "" ];
        then
            if [ "$RS" != "" ];
            then
                zcat $R1 $R2 $RS | \
                {params.gtpro} genotype \
                -d {params.db} >$OUTTSV 2>{log}
            else
                seqtk mergepe $R1 $R2 | \
                {params.gtpro} genotype \
                -d {params.db} >$OUTTSV 2>{log}
            fi
        else
            zcat $RS | \
            {params.gtpro} genotype \
            -d {params.db} >$OUTTSV 2>{log}
        fi

        {params.gtpro} parse \
        --dict {params.db_anno} \
        --in $OUTTSV >$OUTTSVANNO 2>>{log}

        pigz -p {threads} $OUTTSV
        pigz -p {threads} $OUTTSVANNO
        '''


if config["params"]["gtpro"]["do"]:
    rule calling_snp_gtpro_all:
        input:
            expand([
                os.path.join(
                    config["output"]["calling"], "profiles/gtpro/{sample}/{sample}.tsv.gz"),
                os.path.join(
                    config["output"]["calling"], "profiles/gtpro/{sample}/{sample}.anno.tsv.gz")],
                sample=SAMPLES_ID_LIST
            )
else:
    rule calling_snp_gtpro_all:
        input:


rule calling_all:
    input:
        rules.calling_snp_gtpro_all.input


localrules:
    calling_snp_gtpro_all,
    calling_all