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
			def alpine

			steps {
				sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'
				alpine = docker.build("kleinf/alpine", "./alpine")
			}
		}
	}
}
