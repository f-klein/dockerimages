pipeline {
	agent any;

	environment {
		TODAY	= """${sh(
			returnStdout: true,
			script: 'date +%Y%m%d'
		)}"""
	}

	stages {
		stage('Build Alpine base image') {
			steps {
				sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'
				def alpine = docker.build("kleinf/alpine", "./alpine")
			}
		}
	}
}
