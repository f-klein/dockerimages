pipeline {
	agent any;

	environment {
		TODAY	= """${sh(
			returnStdout: true,
			script: 'date +%Y%m%d'
		)}"""
	}

	stages {
		stage('Print environment') {
			steps {
				sh 'echo "Job base name = $JOB_BASE_NAME, Today = $TODAY"'
			}
		}
	}
}
