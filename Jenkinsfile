pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              //archive 'target/*.jar' 
			  //new command for create artifact
			  //test
				archiveArtifacts 'target/*.jar'
			}
        }   
    }
}