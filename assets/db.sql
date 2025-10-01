 CREATE TABLE activity (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image TEXT,
    label TEXT,
    description TEXT
 );

 INSERT INTO activity (image, label, description) VALUES ('indoor.png', 'Indoor', 'Enjoy museums, cozy cafés, and unique shops');
 INSERT INTO activity (image, label, description) VALUES ('outdoor.png', 'Outdoor', 'Discover parks, iconic streets, and outdoor sights');
 INSERT INTO activity (image, label, description) VALUES ('both.png', 'Both', 'Get a mix of the best indoor and outdoor experiences');