pipeline {
 agent any;

 environment {
  TODAY = """${sh(
   returnStdout: true,
   script: 'date +%Y%m%d'
  )}"""
 }

 stages {
  stage('Build Alpine base image') {
   steps {
    sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'

    script {
     docker.build("kleinf/alpine:${TODAY}", "./alpine")
    }
   }
  }
  stage('Test Alpine image') {
   agent {
    docker {
     image "kleinf/alpine:${TODAY}"
    }
   }
   steps {
    sh 'echo "Test passed."'
   }
  }
 }
}
