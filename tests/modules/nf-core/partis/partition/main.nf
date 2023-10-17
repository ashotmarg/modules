#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PARTIS_PARTITION as PARTIS_PARTITION } from '../../../../../modules/nf-core/partis/partition/main.nf'
include { PARTIS_PARTITION as PARTIS_PARTITION_EXTARGS } from '../../../../../modules/nf-core/partis/partition/main.nf'

workflow test_partis_partition {

    input = [
        [ id:'test', single_end:false ], // meta map
        // file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
        file("/Users/aoqn/projects/deleteMe/exampleSmall.fa", checkIfExists: true)
    ]
    // parameter_directory = []

    PARTIS_PARTITION ( input  )
}

workflow test_partis_partition_extargs {

    input = [
        [ id:'test', single_end:false ], // meta map
        // file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
        file("/Users/aoqn/projects/deleteMe/exampleSmall.fa", checkIfExists: true)
    ]

    // ${meta.id}
    PARTIS_PARTITION_EXTARGS ( input  )
}
