pipeline {
 agent any;

 environment {
  TODAY = """${sh(
   returnStdout: true,
   script: 'echo -ne `date +%Y%m%d`'
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
     sh "docker build --rm --force-rm -t kleinf/alpine:${TODAY} ./alpine"
    }
   }
  }

  stage('Test Alpine image') {
   steps {
    sh 'docker run --rm -ti kleinf/alpine:${TODAY} echo "Test passed."'
   }
  }
  stage('Removing temporary Docker images') {
   steps {
    sh 'docker image prune'
   }
  }
 }
}
