
#Voir les branches
git branch

#Créer une nouvelle branche nommée "MABRANCHE"
git branch MABRANCHE

#Supprimer la branche nommée "MABRANCHE"
git branch -d MABRANCHE

#Voir les braches non fusionnées
git branch --no-merged

#Annuler des modifications su run fichier non commité
git checkout -- FICHIER

#Cloner une branch specifique
git clone -b BRANCHE git@github.com:PATHGIT.git
git clone ssh://LOGIN@ftp.xxx.net/PATHGIT.git

#Pour Push dans mon fork (XXX)
git config -e
Ajouter dans [remote "origin"]
pushurl = git@github.com:XXX/PATHGIT.git

#Reinitialisation sur le dernier commit
git reset --hard HEAD

#Restaurer un fichier supprimé:
git rev-list -n 1 HEAD -- FICHIER
git checkout <le_commit_retourne_par_la_commande_precedante>^ -- <nom_du_fichier>
git commit FICHIER

#Récupérer les dernières modifications:
git pull origin master;

#Committer ses modifications
git add --all; #Add all
git commit -m "Message pour le log";
