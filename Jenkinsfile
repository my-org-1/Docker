pipeline {
    agent any
        stages {
    stage('Docker-build') {
         agent { label 'fargate-jnlp-slave '}    //or use this label: fargate-jnlp-slave or ec2-jnlp-slave
            steps {
              //  withAWS(credentials: 'AWS_CREDENTIALS', region: 'us-east-1') {
                        
                        
                        sh 'cd docker_jenkins && ./deploy-image.sh'
                       
                }
            }
        }
    }




