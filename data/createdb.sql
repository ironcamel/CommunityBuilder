CREATE TABLE user (
    id       VARCHAR(100) NOT NULL PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    email    VARCHAR(100)
);

CREATE TABLE cluster (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    VARCHAR(100) NOT NULL UNIQUE,
    country    VARCHAR(100) NOT NULL DEFAULT 'United States',
    region     VARCHAR(100) NOT NULL DEFAULT 'Southeastern States',
    name       VARCHAR(100) NOT NULL DEFAULT 'Fairfax',
    geo_size   INT NOT NULL DEFAULT 0,
    population INT NOT NULL DEFAULT 0,
    num_lsa    INT NOT NULL DEFAULT 0,
    num_comm   INT NOT NULL DEFAULT 0,
    FOREIGN KEY(user_id) REFERENCES user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE core_team_member (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    cluster_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL DEFAULT '',
    last_name  VARCHAR(100) NOT NULL DEFAULT '',
    phone      VARCHAR(100) NOT NULL DEFAULT '',
    email      VARCHAR(100) NOT NULL DEFAULT '',
    role       VARCHAR(100) NOT NULL DEFAULT '',
    active     INT NOT NULL DEFAULT 1,
    date_appointed DATE,
    FOREIGN KEY (cluster_id) REFERENCES cluster (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE neighborhood (
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    cluster_id   INT NOT NULL,
    name         VARCHAR(100) NOT NULL DEFAULT '',
    coordinator  VARCHAR(100) NOT NULL DEFAULT '',
    address      VARCHAR(200) NOT NULL DEFAULT '',
    city         VARCHAR(100) NOT NULL DEFAULT '',
    state        VARCHAR(2)   NOT NULL DEFAULT 'VA',
    zip_code     VARCHAR(100) NOT NULL DEFAULT '',
    office_name  VARCHAR(100) NOT NULL DEFAULT '',
    office_title VARCHAR(100) NOT NULL DEFAULT '',
    office_phone VARCHAR(100) NOT NULL DEFAULT '',
    office_email VARCHAR(100) NOT NULL DEFAULT '',
    notes        TEXT NOT NULL DEFAULT '',
    FOREIGN KEY (cluster_id) REFERENCES cluster (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE teaching_team_member (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    neighborhood_id INT NOT NULL,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    phone           VARCHAR(100),
    email           VARCHAR(100),
    role            VARCHAR(100),
    availability    VARCHAR(100),
    active          INT NOT NULL DEFAULT 1,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhood (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE home (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    neighborhood_id INT,
    name            VARCHAR(100),
    address         VARCHAR(200),
    city            VARCHAR(100),
    state           VARCHAR(2),
    zip_code        VARCHAR(100),
    phone           VARCHAR(100),
    anna            INT NOT NULL DEFAULT 0,
    devotional      INT NOT NULL DEFAULT 0,
    created         DATE,
    modified        DATE,
    notes           TEXT,
    FOREIGN KEY (neighborhood_id) REFERENCES neighborhood (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE seeker (
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    home_id   INT,
    name      VARCHAR(100),
    phone     VARCHAR(100),
    email     VARCHAR(100),
    anna      INT NOT NULL DEFAULT 0,
    declared  DATE,
    created   DATE,
    modified  DATE,
    notes     TEXT,
    FOREIGN KEY (home_id) REFERENCES home (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
