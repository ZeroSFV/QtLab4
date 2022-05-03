#include "doglistsql.h"
#include "QObject"

dogListSQL::dogListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{
    QSqlDatabase::removeDatabase("myConnection");

//    db = QSqlDatabase::addDatabase("QODBC3", "myConnection");

//    QString connectString = "Driver={SQL Server Native Client 11.0};";
//    connectString.append("Server=localhost\\SQLEXPRESS;");
//    connectString.append("Database=Lab4Students;");
//    connectString.append("Trusted_Connection=yes;");

//    db.setDatabaseName(connectString);

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");
    db.setHostName("localhost");
        db.setPort(5432);
        db.setUserName("postgres");
        db.setPassword("XD");
        db.setDatabaseName("dogs");

     _isConnectionOpen = true;

    //db.open();

    if(!db.open())
        {
            qDebug() << db.lastError().text();
            _isConnectionOpen = false;
        }


    QString m_schema = QString( "CREATE TABLE IF NOT EXISTS Dogs (Id SERIAL PRIMARY KEY, DogName Text, DogAge Integer, DogBreed Text, DogOwner Text)");

        QSqlQuery qry(m_schema, db);

        qry.exec();

        refresh();
}

QSqlQueryModel* dogListSQL::getModel(){
    return this;
}
bool dogListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> dogListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "DogName";
    roles[Qt::UserRole + 2] = "DogAge";
    roles[Qt::UserRole + 3] = "DogBreed";
    roles[Qt::UserRole + 4] = "DogOwner";
    roles[Qt::UserRole + 5] = "Id_dog";

    return roles;
}


QVariant dogListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* dogListSQL::SQL_SELECT =
        "SELECT DogName, DogAge, DogBreed, DogOwner, Id "
        "FROM dogs";

void dogListSQL::refresh()
{
    this->setQuery(dogListSQL::SQL_SELECT,db);
}

void dogListSQL::add(const QString& nameDog, const int ageDog, const QString& breedDog, const QString& ownerDog) {
    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO Dogs (DogName, DogAge, DogBreed, DogOwner) VALUES ('%1', %2, '%3', '%4')")
            .arg(nameDog)
            .arg(ageDog)
            .arg(breedDog)
            .arg(ownerDog);
    query.exec(strQuery);

    refresh();
}

void dogListSQL::edit(const QString& nameDog, const int ageDog, const QString& breedDog, const QString& ownerDog, const int Id_dog) {
    QSqlQuery query(db);
    QString strQuery= QString("UPDATE dogs SET DogName = '%1', DogAge = %2, DogBreed = '%3', DogOwner = '%4' WHERE Id = %5")
            .arg(nameDog)
            .arg(ageDog)
            .arg(breedDog)
            .arg(ownerDog)
            .arg(Id_dog);
    query.exec(strQuery);

    refresh();

}
void dogListSQL::del(const int Id_dog){
    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM Dogs WHERE Id = %1")
            .arg(Id_dog);
    query.exec(strQuery);

    refresh();
}

QString dogListSQL::count(const QString& textBreed)
{
    QSqlQuery query(db);
    QString strQuery= QString("SELECT COUNT(Id) FROM dogs WHERE DogBreed = '%1'")
            .arg(textBreed);

    query.exec(strQuery);
    QString info;
    while (query.next())
    {
        info = query.value(0).toString();
        qDebug() << info;
    }

    return(info);
}

