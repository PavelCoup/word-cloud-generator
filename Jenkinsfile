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
        
        stage('tests') {
            //environment {
            //    NEXUS_CREDS = credentials('nexus-creds')
            //}
            
            steps {
                sh 'docker build -t alpine_wcg -f ./wcg/Dockerfile .'
                sh 'docker run -d -u 0:0 --name alpine_wcg --network=pavel_project_net alpine_wcg'
                sh script: """
                    res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://alpine_wcg:8888/version | jq '. | length'`
                    if [ "1" != "\$res" ]; then
                      exit 99
                    fi

                    res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://alpine_wcg:8888/api | jq '. | length'`
                    if [ "7" != "\$res" ]; then
                      exit 99
                    fi
                """
                sh 'docker rm -f alpine_wcg'
                sh 'docker rmi alpine_wcg'
            }
        }
        
    }
}
