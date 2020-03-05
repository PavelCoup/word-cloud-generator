pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            args '-u 0:0 --name jenkins-slave --network=pavel_project_net -v /var/run/docker.sock:/var/run/docker.sock'
            //customWorkspace '/tmp'
        }
    }

    stages {
        
        stage('make') {
            steps {
                sh script: """
                    export GOPATH="${WORKSPACE}"
                    export PATH="\$PATH:${WORKSPACE}/bin"
                    sed -i \'s/1.DEVELOPMENT/1.${BUILD_NUMBER}/g\' ./rice-box.go
                    make
                    md5sum artifacts/*/word-cloud-generator* >artifacts/word-cloud-generator.md5
                    gzip artifacts/*/word-cloud-generator*
                """
            }
        }

        stage('upload nexus') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'word-cloud-generator', classifier: '', file: 'artifacts/linux/word-cloud-generator.gz', type: 'gz']], credentialsId: 'nexus-creds', groupId: '1', nexusUrl: 'nexus:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'word-cloud-generator', version: '1.$BUILD_NUMBER'
            }
        }
        
        
    }
}
// docker network connect your-network-name container-name
