pipeline {
    agent any
        stages {
    stage('Slave') {
        agent {
            ecs {
                inheritFrom 'label-of-my-preconfigured-template'
                cpu 1024
                memory 2046
              //  image '$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/jenkins/java8:2019.7.29-1'
              //  logDriver 'fluentd'
              //  logDriverOptions([[name: 'foo', value:'bar'], [name: 'bar', value: 'foo']])
             //   portMappings([[containerPort: 22, hostPort: 22, protocol: 'tcp'], [containerPort: 443, hostPort: 443, protocol: 'tcp']])
            }
        }
       // steps {
       // stage('build-image') {
            steps {
               /* withAWS(credentials: 'AWS_CREDENTIALS', region: 'us-east-1') {
                         */
                        
                        sh 'cd docker_jenkins && ./deploy-image.sh'
                       
                }
            }
        }
    }



pipeline {
  agent none

  stages {
    stage('Test') {
        agent {
            ecs {
                inheritFrom 'label-of-my-preconfigured-template'
                cpu 1024
                memory 2046
              //  image '$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/jenkins/java8:2019.7.29-1'
              //  logDriver 'fluentd'
              //  logDriverOptions([[name: 'foo', value:'bar'], [name: 'bar', value: 'foo']])
             //   portMappings([[containerPort: 22, hostPort: 22, protocol: 'tcp'], [containerPort: 443, hostPort: 443, protocol: 'tcp']])
            }
        }
        steps {
            sh 'echo hello'
        }
    }
