pipeline {
 agent any;

 environment {
  TODAY = """${sh(
   returnStdout: true,
   script: 'date +%Y%m%d'
  )}"""
 }

 stages {
  stage('Show environment') {
   steps {
    sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'
   }
  }

  stage('Build Alpine base image') {
   steps {
    script {
     docker.build("kleinf/alpine", "--rm", "--force-rm", "./alpine")
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
