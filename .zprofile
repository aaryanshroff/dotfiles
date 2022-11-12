gcm () {
    git commit -m "$1" && git push
}

mkcdir () {
  mkdir -p -- "$1" && cd -P -- "$1"
}


tfa () {
    terraform apply
}

tfd () {
    terraform destroy
}

tfi () {
    terraform init
}

export -f gcm
export -f mkcdir
export -f tfa
export -f tfd
export -f tfi
