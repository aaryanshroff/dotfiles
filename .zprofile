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

export -f mkcdir
export -f tfa
export -f tfd
export -f tfi
