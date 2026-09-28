CREATE TABLE IF NOT EXISTS fly_system (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    fly_enabled BOOLEAN DEFAULT FALSE,
    fly_speed FLOAT DEFAULT 1.0
);

INSERT INTO fly_system (identifier, fly_enabled, fly_speed) VALUES ('default', FALSE, 1.0);