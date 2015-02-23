#GIT Trucs et astuces
 - [Corrections](#corrections)
 - [Branches](#branches)
 - [Configurations](#configurations)
 - [Participation au projet](#participation)
 
## <a name="corrections"></a> Corrections
**Annuler des modifications sur un fichier non commité**
```shell
git checkout -- FICHIER;
```
**Reinitialisation sur le dernier commit**
```shell
git reset --hard HEAD;
```
**Restaurer un fichier supprimé**
```shell
git rev-list -n 1 HEAD -- FICHIER;
git checkout <le_commit_retourne_par_la_commande_precedante>^ -- <nom_du_fichier>;
git commit FICHIER;
```

## <a name="branches"></a> Branches
**Voir les branches**
```shell
git branch;
```
**Créer une nouvelle branche nommée "MABRANCHE"**
```shell
git branch MABRANCHE;
```
**Supprimer la branche nommée "MABRANCHE"**
```shell
git branch -d MABRANCHE;
```
**Voir les branches non fusionnées**
```shell
git branch --no-merged;
```
**Cloner une branch specifique**
```shell
git clone -b BRANCHE git@github.com:PATHGIT.git;;
```
ou;
```shell
git clone ssh://LOGIN@ftp.xxx.net/PATHGIT.git;
```

**Lister les branches du dépôt**
```shell
git branch -a;
```
**Creation d'un branche distante ma_branche_distante sur le repository lougaou**
```shell
git checkout -b ma_branche_distante ;
git push -u lougaou ma_branche_distante ;
```
**Suppression de la branche distante ma_branche_distante sur le repository lougaou**
```shell
git push lougaou --delete ma_branche_distante;
```
**Suppression des réferences supprimée sur le repository distant lougaou**
```shell
git remote prune lougaou # Don't show branches that have already been deleted
```
## <a name="configurations"></a> Configurations
**Pour Push dans mon fork (XXX)**
```shell
git config -e;
```
Ajouter dans [remote "origin"]
pushurl = git@github.com:XXX/PATHGIT.git

## <a name="participation"></a> Participation au projet
**Récupérer les dernières modifications**
```shell
git pull origin master;
```
**Committer ses modifications**
```shell
git add --all; #Add all
git commit -m "Message pour le log";
```
**Lister les dépôts git distants en affichant leurs URLs**
```shell
git remote -v;
```
