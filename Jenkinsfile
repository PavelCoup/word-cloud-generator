pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            args '-u 0:0 --name jenkins-slave --network=pavel_project_net -v /var/run/docker.sock:/var/run/docker.sock'
            //customWorkspace '/tmp'
        }
    }

    stages {
 
        stage('get source code') {
            steps {
                sh script: """
                    cd /go
                    git clone https://github.com/PavelCoup/word-cloud-generator.git
                """
            }
        }
        
        stage('make') {
            environment {
                GOPATH = "${WORKSPACE}"
                PATH = "$PATH:${WORKSPACE}/bin"
                }   
            steps {
                sh script: """
                    sed -i \'s/1.DEVELOPMENT/1.${BUILD_NUMBER}/g\' ./rice-box.go
                    make
                    md5sum artifacts/*/word-cloud-generator* >artifacts/word-cloud-generator.md5
                    gzip artifacts/*/word-cloud-generator*
                """
            }
        }

        stage('upload nexus') {
            environment { 
                AN_ACCESS_KEY = credentials('nexus-creds') 
            }
            steps {
                //sh "curl --fail -u ${AN_ACCESS_KEY} --upload-file /go/word-cloud-generator/artifacts/linux/word-cloud-generator.gz 'http://nexus:8081/repository/word-cloud-generator/'"
                nexusArtifactUploader artifacts: [[artifactId: 'word-cloud-generator', classifier: '', file: '/go/word-cloud-generator/artifacts/linux/word-cloud-generator.gz', type: 'gz']], credentialsId: 'nexus-creds', groupId: '1', nexusUrl: 'nexus:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'word-cloud-generator', version: '1.$BUILD_NUMBER'
            }
        }
    }
}
// docker network connect your-network-name container-name
