```bash
docker-compose up -d
```
```bash
docker container ls
```
```bash
docker exec -ti <CONTAINER ID> bash
```

```bash
docker-compose down --remove-orphans
```

```bash
docker volume rm $(docker volume ls -q) && docker rmi $(docker images -q) 
```


# Mysql
```bash
mysql --host=localhost --user=root --password=dockermysql dbmysql


SHOW DATABASES;
SHOW SCHEMAS;
create database databasename;
USE databasename;
SHOW tables;
DROP DATABASE databasename;
CREATE TABLE table_name (column_name column_type);

create table user(
   user_id INT NOT NULL AUTO_INCREMENT,
   firstName VARCHAR(255) NOT NULL,
   lastName VARCHAR(255) NOT NULL,
   created_at DATE,
   PRIMARY KEY ( user_id )
);
# insérer une données
INSERT INTO user (firstName, lastName, created_at) VALUES ("thomas", "mouchelet", NOW());
# afficher la liste des données
SELECT * FROM user;


https://rednafi.github.io/digressions/database/2020/03/15/mysql-install.html
```

# Mongo

```bash
mongosh -u "mongoroot" -p "mongoroot"

# afficher toutes les base de données
show dbs

# utiliser la base "madatabase"
use madatabase

# voir dans quelle base on est
db

# afficher les collections
show collections

db.createCollection("customer")
# renommer une collection
db.oldname.renameCollection("newname")

# effacer une collection
db.contacts.drop()

# effacer la base dans laquelle on est
db.dropDatabase()

# insertion
db.contacts.insert({ first: 'Quentin', last: 'Busuttil' })

# sélection
db.contacts.find()
db.contacts.find({ first: 'quentin' })
db.contacts.find({ first: 'quentin', last: 'busuttil' })

# sélectionner les documents dont un array contient une valeur x
db.contacts.find({ tags: 'business' })

# ou un élément parmi plusieurs
db.contacts.find({ tags: { $in: ['business', 'french'] } })

# ou la combinaison de plusieurs
db.contacts.find({ tags: { $all: ['business', 'french'] } })

# sous cette forme l'array correspond exactement à cela (ordre des éléments compris)
db.contacts.find({ tags: ['business', 'french'] })

# requêter selon des propriétés d'un sous-document
# admettons l'objet suivant :
# { nom: "Quentin", agenda: { lundi: "programmation", mardi: "dev", mercredi: "code" } }
# on pourra matcher depuis son sous document ainsi (notez bien les guillemets autour de agenda.mardi)
db.users.find({ 'agenda.mardi': 'dev' })

# requêter selon un match exact de sous-document
db.users.find({ agenda: { lundi: "programmation", mardi: "dev", mercredi: "code" } })

# OR sélectionner selon une condition ou une autre
# il faut utiliser $or avec un array dont chaque élément est un objet littéral de sélection
db.users.find({ $or: [{ _id:ObjectId("558d0b395fa02e7e218b4587") }, { _id:ObjectId("558d0b395fa02e7e218b4574") }] })

# récupérer seulement certains champs d'un document
db.users.find({}, { _, fild1: 1, fild2: 0 })

# type == food || snacks
db.inventory.find({ type: { $in: ['food', 'snacks'] } })

# sélectionner les documents comportant un champ particulier
db.users.find({ birthyear: { $exists: true } })

# sélectionner les documents dont la valeur est différente de
db.users.find({ birthyear: { $ne: 2000 } })

# ne récupérer que le sous-document (récup le sous-document d'id x dans le doc d'id z)
db.users.find({ _id: z, "contacts._id": x }, { "contacts.$._id" : 1 })

# ordonner la sélection
# 1 = croissant/alphabétique et -1 = décroissant/alphabétique inversé
db.users.find().sort({ addedOn: 1 })

# update
# on peut utiliser { multi: true } pour modifier plusieurs documents à la fois
# l'option { upsert: true } permet de créer le document s'il n'existe pas
db.users.update({ _id: x }, { $set: { "firstname": "Baboo" } })

# update en remplaçant le document par un nouvel objet
db.users.update({ _id: 'azert' }, obj)

# update un sous-document d'id y du doc d'id x (dans un tableau de sous-documents appelé contacts),
# on remplace le sous-doc par un autre objet
# le document à modifier resemble ici à
#{
#  _id: 'x',
#  name: 'azerty',
#  contacts: [
#    {
#      _id: 'y',
#      name: 'qwerty',
#      email: 'qwerty@heymail.fr'
#    }
#  ]
#}
db.users.update({ _id: x, "contacts._id": y }, { $set: { "contacts.$":myNewDocument } })

# effacer un champ
db.users.update({ _id: x }, { $unset: { contacts: "" } })

# renommer un champ
db.users.update({}, { $rename: { "ancien_nom": "nouveau_nom" } }, { multi: true })

# effacer un champ de tous les document d'une collection
# correspond à ALTER TABLE users DROP COLUMN zorglub
db.users.update({}, { $unset: { zorglub: "" } }, { multi: true } )

# retirer un élément d'un tableau
# (on retire l'ami "yyy" du tableau "friends" de l'utilisateur "xxx")
db.users.update({ _id: xxx }, { $pull: { friends: yyy } })

# on fait la même chose, mais on retire cet ami de tous les utilisateurs
# par exemple, l'ami yyy, s'est désinscrit
db.users.update({ friends: yyy }, { $pull: { friends: yyy } }, { multi: true })

# effacer un document
db.contacts.remove({ _id: ObjectId("55accc6c039c97c5db42f192") })

# effacer tous les documents d'une collection
db.contacts.remove({})

# effacer un sous-document d'id y du doc d'id x (dans un tableau de sous-documents)
db.users.update({ _id: x }, { $pull: { contacts: { _id: y } } })

# dans le même genre $pop permet d'enlever le dernier ou le premier élément d'un tableau
# respectivement en lui passant les valeurs 1 et -1
db.users.update({ _id: x }, { $pop: { contacts: -1 } })

# https://buzut.net/commandes-de-base-de-mongodb/
```

