wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  pr = minus("${env.BUILD_ID}", "PR-")

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: " ERROR: see pull request ${pr}"
    throw err
  }
}
