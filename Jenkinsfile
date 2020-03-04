pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            args '--name jenkins-slave -u 0:0 -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    stages {
        
        stage('net for jenkins-slave') {
            steps {
                sh 'docker network connect pavel_project_net jenkins-slave'
            }
        }        
                
        stage('get source code') {
            steps {
                sh 'sleep 120'
                sh script: """
                    cd /go
                    git clone https://github.com/PavelCoup/word-cloud-generator.git
                """
            }
        }
        
        stage('make') {
            steps {
                sh script: """
                    cd /go/word-cloud-generator
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
