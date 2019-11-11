from configparser import ConfigParser

# Gets the connection string for MongoDB Cluster using a hidden variable
def getConnection():
    parser = ConfigParser()

    # Use parser variable to read file 'default.ini'
    parser.read('default.ini')

    # returns MongoURI as string
    return parser.get('db', 'mongoURI')
