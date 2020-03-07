pipeline {
    agent any
    stages {
        stage('build-image') {
            steps {
               
                         ansiColor('xterm') {
 
                    
                        sh 'cd docker_jenkins && ./deploy-image.sh'
                         }
             
            }
        }
    }
}


