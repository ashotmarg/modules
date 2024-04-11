#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PARTIS_PARTITION as PARTIS_PARTITION } from '/Users/aoqn/Downloads/modules/modules/nf-core/partis/partition/main.nf'
include { PARTIS_PARTITION as PARTIS_PARTITION_EXTARGS } from '/Users/aoqn/Downloads/modules/modules/nf-core/partis/partition/main.nf'

workflow test_partis_partition {

    input = [
        [ id:'test', single_end:false ], // meta map
        // file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
        file("https://raw.githubusercontent.com/nf-core/test-datasets/modules/data/delete_me/partis/partisTestSmall.fa", checkIfExists: true)
    ]

    PARTIS_PARTITION ( input )
    PARTIS_PARTITION.out.yaml.view()
}

workflow test_partis_partition_extargs {

    input = [
        [ id:'test', single_end:false ], // meta map
        // file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
        file("/Users/aoqn/projects/partis/other/partisTestSmall.fa", checkIfExists: true)
    ]

    PARTIS_PARTITION_EXTARGS ( input )
}
