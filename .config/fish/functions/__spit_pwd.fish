function __spit_pwd --description 'Spit pwd' --on-variable PWD
  status --is-command-substitution; and return
  echo $PWD
end
