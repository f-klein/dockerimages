pipeline {
 agent any;

 environment {
  TODAY = """${sh(
   returnStdout: true,
   script: '/bin/echo -ne `date +%Y%m%d`'
  )}"""
 }

 parameters {
  string(name: 'PREFIX', defaultValue: 'kleinf', description: 'Docker Hub prefix')
  booleanParam(name: 'PUSH', defaultValue: true, description: 'Upload to Docker Hub')
 }

 options {
  disableConcurrentBuilds()
  skipDefaultCheckout()
  timeout(time: 10, unit: 'MINUTES')
  timestamps()
 }

stages {
stage('Build Docker images') {

 matrix {
  axes {
   axis {
    name 'IMAGE'
    values 'alpine' 'squid'
   }
  }

  stages {
   stage('Show environment') {
    steps {
     echo "Job base name = $JOB_BASE_NAME"
     echo "Today = $TODAY"
     echo "Prefix = $PREFIX"
     echo "Push = $PUSH"
     sh "printenv"
    }
   }

   stage('Build Docker image') {
    steps {
     script {
      sh "docker build --no-cache --rm --force-rm -t ${PREFIX}/${IMAGE}:${TODAY} ./${IMAGE}"
     }
    }
   }

   stage('Test Docker image') {
    steps {
     sh 'docker run --rm ${PREFIX}/${IMAGE}:${TODAY} /bin/busybox id'
    }
   }

   stage('Push Docker images to repository') {
    when {
     environment name: 'PUSH', value: 'true'
    }
    steps {
     script {
      def dockerimage = docker.image("${PREFIX}/${IMAGE}:${TODAY}")
      docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
       dockerimage.push()
      }
     }
     sh 'docker rmi -f registry.hub.docker.com/${PREFIX}/${IMAGE}:${TODAY} || true'
    }
   }
  }
 }
 }
 }

 post {
  cleanup {
   sh 'docker image prune -f'
  }
 }
}
