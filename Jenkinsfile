wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  tokens = "${env.JOB_NAME}".tokenize('/')
  pr = "${env.CHANGE_URL}"
  echo "running ${pr}, job ${env.BUILD_ID}"
  sh "env"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: "ERROR: <${env.CHANGE_URL}'|PR#${pr}> - see [jenkins job console](${env.BUILD_URL}/console)]"
    throw err
  }
}
