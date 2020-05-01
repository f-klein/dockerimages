pipeline {
 agent any;

 environment {
  TODAY = """${sh(
   returnStdout: true,
   script: '/bin/echo -ne `date +%Y%m%d`'
  )}"""
  PREFIX = "kleinf"
  IMAGE = "alpine"
 }

 stages {
  stage('Show environment') {
   steps {
    sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'
   }
  }

  stage('Build Docker image') {
   steps {
    script {
     sh "docker build --no-cache --rm --force-rm -t ${PREFIX}/${IMAGE}:${TODAY} ./${IMAGE}"
    }
   }
  }

  stage('Test Alpine image') {
   steps {
    sh 'docker run --rm ${PREFIX}/${IMAGE}:${TODAY} echo "Test passed."'
   }
  }
  stage('Push Docker images to repository') {
   steps {
    script {
     def dockerimage = docker.image("${PREFIX}/${IMAGE}:${TODAY}")
     docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
      dockerimage.push()
     }
    }
   }
  }
  stage('Remove temporary Docker images') {
   steps {
    sh 'docker rmi -f registry.hub.docker.com/${PREFIX}/${IMAGE}:${TODAY} || true'
    sh 'docker image prune -f'
   }
  }
 }
}
