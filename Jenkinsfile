pipeline {
//    agent any
    agent { label 'fargate-jnlp-slave '}
        stages {
//    stage('Docker-build') {
            stage('docker1') {
      //   agent { label 'fargate-jnlp-slave '}    //or use this label: fargate-jnlp-slave or ec2-jnlp-slave
            steps {
              //  withAWS(credentials: 'AWS_CREDENTIALS', region: 'us-east-1') {
                        
                        
                        sh 'cd docker_jenkins && ./deploy-image.sh'
                       
                }
            }
        }
    }




