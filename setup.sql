-- You can paste this entire file into MySQL Workbench and run it with Crtl+Shift+Enter to get the full people and zodiac tables.

DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS zodiac;

-- Create and populate the zodiac table:
CREATE TABLE zodiac (
  name VARCHAR(12) PRIMARY KEY,
  symbol CHAR(1),
  description VARCHAR(255)
);
INSERT INTO zodiac VALUES
  ('Aries', '♈', 'Eager, dynamic, quick and competitive'),
  ('Taurus', '♉', 'Strong, dependable, sensual and creative'),
  ('Gemini', '♊', 'Versatile, expressive, curious and kind'),
  ('Cancer', '♋', 'Intuitive, sentimental, compassionate and protective'),
  ('Leo', '♌', 'Dramatic, outgoing, fiery and self-assured'),
  ('Virgo', '♍', 'Practical, loyal, gentle and analytical'),
  ('Libra', '♎', 'Social, fair-minded, diplomatic and gracious'),
  ('Scorpio', '♏', 'Passionate, stubborn, resourceful and brave'),
  ('Sagittarius', '♐', 'Extroverted, optimistic, funny and generous'),
  ('Capricorn', '♑', 'Serious, independent, disciplined and tenacious'),
  ('Aquarius', '♒', 'Deep, imaginative, original and uncompromising'),
  ('Pisces', '♓', 'Affectionate, empathetic, wise and artistic'),
  ('Rat', '🐀', 'Imaginative, generous, successful, popular, curious'),
  ('Ox', '🐂', 'Confident, honest, patient, conservative, strong'),
  ('Tiger', '🐅', 'Sensitive, tolerant, brave, active, resilient'),
  ('Rabbit', '🐇', 'Affectionate, kind, gentle, compassionate, merciful'),
  ('Dragon', '🐉', 'Enthusiastic, intelligent, lively, energetic, innovative'),
  ('Snake', '🐍', 'Charming, intuitive, romantic, highly perceptive, polite'),
  ('Horse', '🐎', 'Diligent, friendly, sophisticated, talented, clever'),
  ('Sheep', '🐑', 'Artistic, calm, reserved, happy, kind'),
  ('Monkey', '🐒', 'Witty, lively, flexible, humorous, curious'),
  ('Rooster', '🐓', 'Shrewd, honest, communicative, motivated, punctual'),
  ('Dog', '🐕', 'Loyal, honest, responsible, courageous, warm-hearted'),
  ('Pig', '🐖', 'Sincere, tolerant, hard-working, honest, optimistic');

-- Create the people table:
CREATE TABLE people (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  house ENUM('Kauri', 'Pohutukawa', 'Totara', 'Rimu', 'Nikau', 'Matai'),
  birthday DATE,
  western_sign VARCHAR(12),
  eastern_sign VARCHAR(12),
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (western_sign) REFERENCES zodiac(name),
  FOREIGN KEY (eastern_sign) REFERENCES zodiac(name)
);

-- DATE datatypes look like strings in the format '2022-03-07'.
-- TIMESTAMP datatypes are integers that count the seconds since 1st Jan 1970.
-- TIMESTAMP datatypes are not ideal because 2,147,483,647 seconds will have passed by 2038,
-- which is the maximum number that can be stored in 32 bits,
-- but they do give us the very neat special SQL value CURRENT_TIMESTAMP,
-- which we use as the default for the 'created' and 'updated' fields
-- to record the time each record was created or updated.

-- We added the FOREIGN KEYs at a later stage, in the Foreign Key tab.
-- They make sure that eastern_sign and western_sign can only be set to values in the zodiac.name field.

-- Insert the data:
INSERT INTO people (first_name, last_name, house, birthday) VALUES
  ('Abdul', 'Boateng', 'Matai', '2005-04-22'),
  ('Alex', 'Tee', 'Totara', '2004-08-21'),
  ('Alex', 'Shen', 'Nikau', '2004-12-22'),
  ('Bosco', 'Kwan', 'Rimu', '2004-01-15'),
  ('Dalbir', 'Singh', 'Rimu', '2004-07-10'),
  ('Jade', 'King', 'Matai', '2005-01-3'),
  ('Joshua', 'McKenzie', 'Nikau', '2004-05-25'),
  ('Kevin', 'Nguyen', 'Matai', '2005-01-18'),
  ('Liam', 'Naidoo', 'Pohutukawa', '2005-01-19'),
  ('Lulu', 'Li', 'Kauri', '2004-05-20'),
  ('Peter', 'Sun', 'Matai', '2004-09-10'),
  ('Riley', 'Cross', 'Pohutukawa', '2004-09-29'),
  ('Shreya', 'Achar', 'Matai', '2005-01-23'),
  ('Tobias', 'Heyes', 'Matai', '2004-09-18'),
  ('William', 'Cao', 'Totara', '2005-01-20'),
  ('Zaid', 'Salman', 'Kauri', '2005-05-19'),
  ('Mr', 'McLeod', 'Matai', '1993-03-10');

-- Insert a new set of rows into the people table, including the eastern_sign and western_sign,
-- using an INSERT ... SELECT statement (this is different to an INSERT ... VALUES statement).

INSERT INTO people (first_name, last_name, house, birthday, western_sign, eastern_sign) SELECT
  first_name,
  last_name,
  house,
  birthday,
  CASE
    WHEN (MONTH(birthday) = 3 AND DAY(birthday) >= 21) OR (MONTH(birthday) = 4 AND DAY(birthday) <= 19) THEN 'Aries'
    WHEN (MONTH(birthday) = 4 AND DAY(birthday) >= 20) OR (MONTH(birthday) = 5 AND DAY(birthday) <= 20) THEN 'Taurus'
    WHEN (MONTH(birthday) = 5 AND DAY(birthday) >= 21) OR (MONTH(birthday) = 6 AND DAY(birthday) <= 20) THEN 'Gemini'
    WHEN (MONTH(birthday) = 6 AND DAY(birthday) >= 21) OR (MONTH(birthday) = 7 AND DAY(birthday) <= 22) THEN 'Cancer'
    WHEN (MONTH(birthday) = 7 AND DAY(birthday) >= 23) OR (MONTH(birthday) = 8 AND DAY(birthday) <= 22) THEN 'Leo'
    WHEN (MONTH(birthday) = 8 AND DAY(birthday) >= 23) OR (MONTH(birthday) = 9 AND DAY(birthday) <= 22) THEN 'Virgo'
    WHEN (MONTH(birthday) = 9 AND DAY(birthday) >= 23) OR (MONTH(birthday) = 10 AND DAY(birthday) <= 22) THEN 'Libra'
    WHEN (MONTH(birthday) = 10 AND DAY(birthday) >= 23) OR (MONTH(birthday) = 11 AND DAY(birthday) <= 21) THEN 'Scorpio'
    WHEN (MONTH(birthday) = 11 AND DAY(birthday) >= 22) OR (MONTH(birthday) = 12 AND DAY(birthday) <= 21) THEN 'Sagittarius'
    WHEN (MONTH(birthday) = 12 AND DAY(birthday) >= 22) OR (MONTH(birthday) = 1 AND DAY(birthday) <= 19) THEN 'Capricorn'
    WHEN (MONTH(birthday) = 1 AND DAY(birthday) >= 20) OR (MONTH(birthday) = 2 AND DAY(birthday) <= 18) THEN 'Aquarius'
    WHEN (MONTH(birthday) = 2 AND DAY(birthday) >= 19) OR (MONTH(birthday) = 3 AND DAY(birthday) <= 20) THEN 'Pisces'
  END AS western_sign,
  CASE
    WHEN birthday BETWEEN '2008-02-07' AND '2009-01-25' THEN 'Rat'
    WHEN birthday BETWEEN '2009-01-26' AND '2010-02-13' THEN 'Ox'
    WHEN birthday BETWEEN '2010-02-14' AND '2011-02-02' THEN 'Tiger'
    WHEN birthday BETWEEN '2011-02-03' AND '2012-01-22' THEN 'Rabbit'
    WHEN birthday BETWEEN '2000-02-05' AND '2001-01-23' THEN 'Dragon'
    WHEN birthday BETWEEN '2001-01-24' AND '2002-02-13' THEN 'Snake'
    WHEN birthday BETWEEN '2002-02-12' AND '2003-01-31' THEN 'Horse'
    WHEN birthday BETWEEN '2003-02-01' AND '2004-01-21' THEN 'Sheep'
    WHEN birthday BETWEEN '2004-01-22' AND '2005-02-08' THEN 'Monkey'
    WHEN birthday BETWEEN '2005-02-09' AND '2006-01-28' THEN 'Rooster'
    WHEN birthday BETWEEN '2006-01-29' AND '2007-02-17' THEN 'Dog'
    WHEN birthday BETWEEN '2007-02-18' AND '2008-02-06' THEN 'Pig'
  END AS eastern_sign
FROM people;

-- We did this in two steps by first saving the SELECT statement as a VIEW.
-- A view acts like a table but is really a stored SELECT statement.
-- CREATE VIEW people_with_signs AS SELECT -- (Copy the SELECT statement above);
-- INSERT INTO people SELECT * FROM people_with_signs;

-- Delete the old rows without eastern_sign and western_sign information.
-- MySQL Workbench restricts us from running DELETE FROM people WHERE western_sign = NULL;
-- so you have to look at your id column.
-- WARNING: Your ids might be different.

-- If you are running this whole file, the below id should be correct.
DELETE FROM people WHERE id < 18;

-- Get the descriptions from people's zodiac signs:
SELECT
  first_name,
  last_name,
  z1.description as western_description,
  z2.description as eastern_description
FROM people
JOIN zodiac AS z1 ON western_sign = z1.name
JOIN zodiac AS z2 ON eastern_sign = z2.name;

-- The above query won't include my name, because I don't have an eastern_sign
-- (our earlier SELECT statement checked birthdays between 2000 and 2012).
-- If you want to include me in the results, the second join on eastern_signs should read:
-- LEFT JOIN zodiac AS z2 ON eastern_sign = z2.name;
