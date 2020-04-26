pipeline {
    agent any
        stages {
    stage('Docker-build') {
         agent { label 'fargate-slave'}
            steps {
               /* withAWS(credentials: 'AWS_CREDENTIALS', region: 'us-east-1') {
                         */
                        
                        sh 'cd docker_jenkins && ./deploy-image.sh'
                       
                }
            }
        }
    }




