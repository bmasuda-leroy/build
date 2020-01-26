docker_build() {
  # if [ -z "$CIRCLE_BRANCH" ]; then
  #   tag="$CIRCLE_TAG"
  # else
  #   tag="${GITHUB_REF##*/}"
  # fi
  tag="${GITHUB_REF##*/}"
  image=$USER/${GITHUB_REPOSITORY#*/}

  echo "Login in docker hub"
  docker login -u $USER -p $PASSWORD

  docker build -t "$image:$tag" .
  docker push "$image:$tag"

  if [ $tag = "master" ] ; then
    docker tag "$image:$tag" "$image:latest"
    docker push "$image:latest"
  fi
}
