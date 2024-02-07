process PARTIS_PARTITION {
    tag "$meta.id"
    label 'process_single'

    // conda "YOUR-TOOL-HERE"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/YOUR-TOOL-HERE':
        'quay.io/matsengrp/partis' }"

    input:
        tuple val(meta), path(fasta)


    output:
        tuple val(meta), path("*.yaml")             , emit: yaml
        tuple val(meta), path("*_params/*")                , emit: outfolder
        path "versions.yml"                         , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    /partis/bin/partis \\
        partition \\
        $args \\
        --infname ${fasta} \\
        --n-procs $task.cpus \\
        --parameter-dir ${prefix}_params \\
        --outfname ${prefix}.yaml

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        partis: \$(echo \$(/partis/bin/partis version 2>&1) | grep "tag" | sed 's/.*tag: //; s/ .*//' )
    END_VERSIONS
    """
    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    touch ${prefix}.yaml
    mkdir ${prefix}_params
    touch ${prefix}_params/stubTest.yaml
    mkdir ${prefix}_params/hmm
    mkdir ${prefix}_params/sw


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        partis: \$(echo \$(/partis/bin/partis version 2>&1) | grep "tag" | sed 's/.*tag: //; s/ .*//' )
    END_VERSIONS
    """
}
