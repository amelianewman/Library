CREATE DATABASE library;
USE library; 


-- ***TABLE CREATION***

CREATE TABLE books (
	book_id INT PRIMARY KEY UNIQUE NOT NULL,
    title VARCHAR(50) NOT NULL, 
    author VARCHAR(50) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    price FLOAT NOT NULL,
    copies INT NOT NULL
);

CREATE TABLE members (
	member_id INT PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL, 
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(150) NOT NULL,
    join_date DATE NOT NULL
);

CREATE TABLE loans (
	book_id INT NOT NULL,
	member_id INT NOT NULL,
	loan_date DATE NOT NULL,
	due_date DATE NOT NULL,
	return_date DATE NULL,
	fine FLOAT NULL,
	PRIMARY KEY (book_id, member_id),
	FOREIGN KEY (book_id) REFERENCES books(book_id),
	FOREIGN KEY (member_id) REFERENCES members(member_id)
);

ALTER TABLE loans
ADD days_late INT NULL AFTER return_date;


-- *** DATA INSERTION -- NOTE: "INSERT" COMMENTED OUT TO PREVENT DUPLICATE DATA INSERTION*** 

INSERT INTO books (book_id, title, author, genre, year, price, copies) 
VALUES
(1, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 12.99, 5),
(2, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 9.99, 7),
(3, 'The Da Vinci Code', 'Dan Brown', 'Thriller', 2003, 14.99, 4),
(4, 'Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Fantasy', 1997, 11.99, 6),
(5, 'Nineteen Eighty-Four', 'George Orwell', 'Dystopia', 1949, 10.99, 3),
(6, 'The Lord of the Rings: The Fellowship of the Ring', 'J.R.R. Tolkien', 'Fantasy', 1954, 15.99, 2),
(7, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 13.99, 4),
(8, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 'Science Fiction', 1979, 8.99, 5),
(9, 'The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Mystery', 2005, 12.99, 3),
(10,'The Hunger Games: Catching Fire','Suzanne Collins','Dystopia',2009,14.99,4);


INSERT INTO members (member_id, name, phone, address, join_date) 
VALUES
(1, 'Alice Smith', '+44-123-4567890', 'Flat A, Baker Street, London, UK', '2023-01-01'),
(2, 'Bob Jones', '+44-234-5678901', 'Flat B, Oxford Street, London, UK', '2023-01-02'),
(3, 'Charlie Brown', '+44-345-6789012', 'Flat C, Piccadilly Circus, London, UK', '2023-01-03'),
(4, 'David Green', '+44-456-7890123', 'Flat D, Hyde Park, London, UK', '2023-01-04'),
(5, 'Emma Watson', '+44-567-8901234', 'Flat E, Covent Garden, London, UK', '2023-01-05'),
(6, 'Eve Adams', '+44-678-9012345', 'Flat F, Westminster Abbey, London, UK', '2023-01-06'),
(7, 'Fred Wilson', '+44-789-0123456', 'Flat G, Tower Bridge, London, UK', '2023-01-07'),
(8, 'Gina Lee', '+44-890-1234567', 'Flat H, Big Ben, London, UK', '2023-01-08'),
(9, 'Hugo Martin', '+44-901-2345678', 'Flat I, Buckingham Palace, London, UK', '2023-01-09'),
(10,'Iris Fry','+44-012-3456789','Flat J,Trafalgar Square,London,Uk','2023-01-10');

INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date, days_late, fine) 
VALUES
(1, 2, '2023-01-15', '2023-02-15', '2023-02-10', NULL, 0),
(2, 4, '2023-01-16', '2023-02-16', '2023-02-18', NULL, 0), 
(3, 6, '2023-01-17', '2023-02-17', '2023-02-19', NULL, 0), 
(4, 8, '2023-01-18', '2023-02-18', '2023-02-22', 4, 6.00), 
(5, 10,'2023-01-19','2023-02-19','2023-02-21', 2, 2.00), 
(6, 1,'2023-01-20','2023-02-20','2023-02-15', NULL, 0), 
(7, 3,'2023-01-21','2023-02-21','2023-02-23',2, 2.00), 
(8, 5,'2023-01-22','2023-02-22','2023-02-04', NULL, 0), 
(9, 7,'2023-01-23','2023-02-23','2023-02-27', 4, 4.00), 
(10,9,'2023-01-24','2023-02-24','2023-01-30', NULL, 0); 


-- *** CHECKING DATA IS IN TABLE ** 

SELECT * FROM members;
SELECT * FROM books; 
SELECT * FROM loans; 


-- ** STORED PROCEDURE **
DELIMITER //

CREATE procedure addMember(
IN member_id INT,
IN name VARCHAR(50), 
IN phone VARCHAR(20),
IN address VARCHAR(150),
IN join_date DATE)

BEGIN
INSERT INTO members(member_id, name, phone, address, join_date) 
VALUES (member_id, name, phone, address, join_date); 

END// 
DELIMITER ; 

CALL addMember(11, 'Ryan Hopper', '+44 12344567678', '23 Leafy Avenue, Notting Hill, London', '2023-01-27'); 
SELECT * FROM members; 


-- ** STORED PROCEDURE **
DELIMITER //
CREATE procedure addBook(
IN book_id INT,
IN title VARCHAR(50), 
IN author VARCHAR(50),
IN genre VARCHAR(50),
IN year INT,
IN price FLOAT,
IN copies INT)

BEGIN
INSERT INTO books (book_id, title, author, genre, year, price, copies)
VALUES (book_id, title, author, genre, year, price, copies); 

END// 
DELIMITER ; 

CALL addBook(11, 'The Secret History', 'Donna Tartt', 'Mystery', '1992', '8.99', 3); 
SELECT * FROM books; 


-- ** USING A QUERY TO DELETE DATA**
DELETE FROM members WHERE name= 'Ryan Hopper'; 


-- ** WRITING QUERIES** 

	-- ** selecing all fantasy books**
SELECT * FROM books WHERE genre = 'Fantasy'; 

	-- ** counting books by genre**
SELECT genre, COUNT(book_id) AS number_of_books FROM books GROUP BY genre;

	-- ** sorting library books by price **
SELECT * FROM books ORDER BY price ASC;

	-- ** ordering all books by publication date**
SELECT * FROM books ORDER BY year ASC; 

	-- ** calculating library stock sum**
SELECT ROUND(SUM(price * copies),2) AS total_value FROM books; 

-- ** calculating cheapest, most expensive and average price of book in library** 
SELECT MIN(price) FROM books; 
SELECT MAX(price) FROM books; 
SELECT ROUND(AVG(price),2)FROM books;

	-- ** displaying members who joined latest to newest**
SELECT * FROM members ORDER BY join_date DESC; 

	-- ** count how many members there are**
SELECT COUNT(*) FROM members; 

	-- ** count memeber name length**
SELECT character_length(name) as name_length
FROM members; 

	-- ** checking book loan history**
SELECT
    loans.book_id,
    books.title,
    books.author,
    loans.member_id,
    members.name,
    loans.loan_date,
    loans.return_date,
    loans.days_late
FROM
    loans
JOIN
    books ON loans.book_id = books.book_id
JOIN
    members ON loans.member_id = members.member_id;


-- ** creating a function to check books out the library **

DELIMITER //
CREATE procedure CheckOutBook(
    IN p_book_id INT, 
    IN p_member_id INT, 
    IN p_loan_date DATE, 
    OUT result BOOLEAN
)

BEGIN
    DECLARE available_copies INT;
    
    SELECT copies INTO available_copies
	FROM books b 
	WHERE b.book_id = p_book_id; 
    
    IF available_copies > 0 THEN
		INSERT INTO loans (book_id, member_id, loan_date, due_date)
		VALUES (p_book_id, p_member_id, p_loan_date, DATE_ADD(p_loan_date, INTERVAL 30 DAY)); 
        
        -- Decrease the available copies
        UPDATE books b 
        SET copies = copies - 1
        WHERE b.book_id = p_book_id; 
        
        SET result = TRUE;
    ELSE
        SET result = FALSE;
    END IF;
END //
DELIMITER ;

-- checking out a book example

CALL CheckOutBook(4, 1, '2023-10-05', @result);
SELECT @result;
SELECT * FROM loans;


 
-- SCENARIO : busy day at library: delivery of 3 new books, 2 new members sign up, 2 people take out books 

	-- adding books
CALL addBook(12,'The Kite Runner', 'Khaled Hosseini', 'Fiction', '2003', '10.99', 4);
CALL addBook(13, 'The Girl on the Train', 'Paula Hawkins', 'Thriller', '2015', '9.99', 5); 
CALL addBook(14, "The Hitchhiker's Guide to the Galaxy", 'Douglas Adams', 'Science Fiction', '1979', '8.99', 6);
SELECT * FROM books; 

	-- adding members 
CALL addMember (12,'Sara Jones', '+44 2345678901', '45 Green Street, Camden Town, London', '2023-01-28');
CALL addMember(13, 'Tom Smith', '+44 3456789012', '67 Red Road, Kensington, London', '2023-01-29');
SELECT * FROM members; 

	-- checking out books
CALL CheckOutBook(2, 12, '2023-10-07', @result);
SELECT @result;
SELECT * FROM loans ORDER BY loan_date DESC;

CALL CheckOutBook(8, 13, '2023-10-07', @result);
SELECT @result;
SELECT * FROM loans ORDER BY loan_date DESC;

	-- checking all books currently on loan (ie not returned)

SELECT b.book_id, b.title, b.author, m.name as member_name , l.loan_date, l.due_date, l.return_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL; 

	-- ** checking who has a fine ** 
SELECT m.name, SUM(l.fine) AS total_fine
FROM members m
JOIN loans l ON m.member_id = l.member_id
WHERE L.fine > 0
GROUP BY m.member_id; 


