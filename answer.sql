-- Create Database
CREATE DATABASE LibraryManagementSystem;
USE LibraryManagementSystem;

-- Create Authors table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key
    first_name VARCHAR(50) NOT NULL,            -- Author's first name (NOT NULL)
    last_name VARCHAR(50) NOT NULL,             -- Author's last name (NOT NULL)
    bio TEXT,                                  -- Biography of the author
    UNIQUE(first_name, last_name)               -- Unique constraint for first and last name
);

-- Create Books table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,    -- Primary Key
    title VARCHAR(100) NOT NULL,                -- Title of the book (NOT NULL)
    author_id INT,                              -- Foreign Key to Authors table
    published_year YEAR,                        -- Year the book was published
    genre VARCHAR(50),                          -- Genre of the book
    price DECIMAL(10, 2),                       -- Price of the book
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES Authors(author_id) 
    ON DELETE CASCADE                           -- If author is deleted, books by that author are deleted
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    first_name VARCHAR(50) NOT NULL,            -- Customer's first name (NOT NULL)
    last_name VARCHAR(50) NOT NULL,             -- Customer's last name (NOT NULL)
    phone_number VARCHAR(15),                   -- Customer's phone number
    email VARCHAR(100) UNIQUE                   -- Customer's email (Unique constraint)
);

-- Create Borrowing table to track which customer borrowed which book
CREATE TABLE Borrowing (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key
    customer_id INT,                           -- Foreign Key to Customers table
    book_id INT,                               -- Foreign Key to Books table
    borrow_date DATE NOT NULL,                 -- Date when the book was borrowed
    return_date DATE,                          -- Date when the book was returned (can be NULL if not yet returned)
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
    ON DELETE CASCADE,                        -- If customer is deleted, borrowing records are deleted
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES Books(book_id) 
    ON DELETE CASCADE                          -- If book is deleted, borrowing records are deleted
);

-- Insert sample data
-- Authors
INSERT INTO Authors (first_name, last_name, bio)
VALUES ('J.K.', 'Rowling', 'British author, best known for the Harry Potter series.');

-- Books
INSERT INTO Books (title, author_id, published_year, genre, price)
VALUES ('Harry Potter and the Sorcerer\'s Stone', 1, 1997, 'Fantasy', 29.99);

-- Customers
INSERT INTO Customers (first_name, last_name, phone_number, email)
VALUES ('John', 'Doe', '123-456-7890', 'john.doe@example.com');

-- Borrowing record
INSERT INTO Borrowing (customer_id, book_id, borrow_date)
VALUES (1, 1, '2025-05-14');
