git config --global user.email "latini.giuliano@gmail.com"
git config --global user.name "Giuliano Latini"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.a add
git config --global alias.c commit
git config --global alias.cho checkout
git config --global alias.s status
git config --global core.sshcommand "'C:\Program Files\OpenSSH-Win64\ssh.exe'"
git config --global alias.pr "!f() { exec vsts code pr '$@'; }; f"
git config --global alias.repo "!f() { exec vsts code repo '$@'; }; f"

# with GnuPG
git config --global user.signingkey XXXXXXXXXXXX
git config --global gpg.program "C:/Program Files (x86)/GnuPG/bin/gpg.exe"
git config --global commit.gpgsign true
git config --global user.email "giulianolatini@codegen2021.it"