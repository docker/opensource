wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  tokens = "${env.JOB_NAME}".tokenize('/')
  pr = "${env.CHANGE_ID}"
  echo "running ${pr}, job ${env.BUILD_ID}"
  sh "env"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: "ERROR: <${env.CHANGE_URL}'|PR#${pr}> - see <${env.BUILD_URL}/console|the Jenkins console for job ${env.BUILD_ID}>"
    throw err
  }
}
