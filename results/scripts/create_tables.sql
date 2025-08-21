-- Drop tables if they already exist (to reset schema)
DROP TABLE IF EXISTS UserRelationship;
DROP TABLE IF EXISTS UserLikes;
DROP TABLE IF EXISTS UserImages;
DROP TABLE IF EXISTS ConversationParticipant;
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS UserConversation;
DROP TABLE IF EXISTS UserHobby;
DROP TABLE IF EXISTS Hobby;
DROP TABLE IF EXISTS Image;
DROP TABLE IF EXISTS Conversation;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Location;

-- Table: User
CREATE TABLE User
(
    ID             INTEGER PRIMARY KEY,
    FirstName      TEXT        NOT NULL,
    LastName       TEXT        NOT NULL,
    Email          TEXT UNIQUE NOT NULL,
    Street         TEXT,
    HouseNumber    TEXT,
    City           TEXT,
    BirthDate      DATE,
    Gender         TEXT,
    InterestedIn   TEXT,
    Phone          TEXT,
    ProfilePicture TEXT,
    ZipCode        TEXT,
    FOREIGN KEY (ZipCode) REFERENCES Location (ZipCode)
);

-- Table: Location
CREATE TABLE Location
(
    ZipCode TEXT PRIMARY KEY,
    City    TEXT
);

-- Table: UserHobby (m:n relation User - Hobby)
CREATE TABLE UserHobby
(
    UserID   INTEGER,
    HobbyID  INTEGER,
    Priority INTEGER,
    PRIMARY KEY (UserID, HobbyID),
    FOREIGN KEY (UserID) REFERENCES User (ID) ON DELETE CASCADE,
    FOREIGN KEY (HobbyID) REFERENCES Hobby (ID) ON DELETE CASCADE
);

-- Table: Hobby
CREATE TABLE Hobby
(
    ID          INTEGER PRIMARY KEY,
    Description TEXT
);

-- Table: Conversation
CREATE TABLE Conversation
(
    ID INTEGER PRIMARY KEY
);

-- Table: UserConversation (m:n relation User - Conversation)
CREATE TABLE UserConversation
(
    UserID         INTEGER,
    ConversationID INTEGER,
    PRIMARY KEY (UserID, ConversationID),
    FOREIGN KEY (UserID) REFERENCES User (ID) ON DELETE CASCADE,
    FOREIGN KEY (ConversationID) REFERENCES Conversation (ID) ON DELETE CASCADE
);

-- Table: ConversationParticipant
CREATE TABLE ConversationParticipant
(
    ConversationID INTEGER,
    ParticipantID  INTEGER,
    PRIMARY KEY (ConversationID, ParticipantID),
    FOREIGN KEY (ConversationID) REFERENCES Conversation (ID) ON DELETE CASCADE,
    FOREIGN KEY (ParticipantID) REFERENCES User (ID) ON DELETE CASCADE
);

-- Table: Message
CREATE TABLE Message
(
    ID             INTEGER PRIMARY KEY,
    ConversationID INTEGER,
    SenderID       INTEGER,
    Content        TEXT,
    FOREIGN KEY (ConversationID) REFERENCES Conversation (ID) ON DELETE CASCADE,
    FOREIGN KEY (SenderID) REFERENCES User (ID) ON DELETE CASCADE
);

-- Table: Image
CREATE TABLE Image
(
    ID   INTEGER PRIMARY KEY,
    Path TEXT
);

-- Table: UserImages (m:n relation User - Image)
CREATE TABLE UserImages
(
    UserID  INTEGER,
    ImageID INTEGER,
    PRIMARY KEY (UserID, ImageID),
    FOREIGN KEY (UserID) REFERENCES User (ID) ON DELETE CASCADE,
    FOREIGN KEY (ImageID) REFERENCES Image (ID) ON DELETE CASCADE
);

-- Table: UserLikes (User likes another User)
CREATE TABLE UserLikes
(
    UserID      INTEGER,
    LikedUserID INTEGER,
    Timestamp   DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UserID, LikedUserID),
    FOREIGN KEY (UserID) REFERENCES User (ID) ON DELETE CASCADE,
    FOREIGN KEY (LikedUserID) REFERENCES User (ID) ON DELETE CASCADE
);

-- Table: UserRelationship
CREATE TABLE UserRelationship
(
    SenderID   INTEGER,
    ReceiverID INTEGER,
    Status     TEXT,
    Timestamp  DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SenderID, ReceiverID),
    FOREIGN KEY (SenderID) REFERENCES User (ID) ON DELETE CASCADE,
    FOREIGN KEY (ReceiverID) REFERENCES User (ID) ON DELETE CASCADE
);
