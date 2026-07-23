# Carrega o script do prompt do git
source /usr/lib/git-core/git-sh-prompt

# Configura o visual do prompt (PS1)
# \u: usuario | \h: host | \w: diretorio | %s: branch do git
export PS1='\[\e[32m\]\u@\h\[\e[m\]:\[\e[34m\]\w\[\e[31m\]$(__git_ps1 " (%s)")\e[0m\n~ '

