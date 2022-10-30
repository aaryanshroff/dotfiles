gcm () {
    git commit -m "$1" && git push
}

tfa () {
    terraform apply
}

tfi () {
    terraform init
}

export -f gcm
export -f tfa
export -f tfi