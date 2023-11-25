-- Tabelul 1: Books
create table books (
    book_id serial primary key,
    title varchar(100) not null,
    genre varchar(50),
    publication_year int,
    isbn varchar(20),
    author_id int references authors(author_id),
    publisher_id int references publishers(publisher_id)
);

-- Tabelul 2: Authors
create table authors (
    author_id serial primary key,
    author_name varchar(100) not null,
    birth_year int,
    nationality varchar(50)
);

-- Tabelul 3: Publishers
create table publishers (
    publisher_id serial primary key,
    publisher_name varchar(100) not null,
    location varchar(100),
    established_year int
);

-- Tabelul 4: BookAuthors (Many to many)
create table book_authors (
    book_id int references books(book_id),
    author_id int references authors(author_id),
    primary key (book_id, author_id)
);

-- Adăugare date în tabela authors
insert into authors (author_name, birth_year, nationality) values
    ('John Doe', 1980, 'American'),
    ('Jane Smith', 1975, 'British'),
    ('Mark Johnson', 1990, 'Canadian');

-- Adăugare date în tabela publishers
insert into publishers (publisher_name, location, established_year) values
    ('Random House', 'New York', 1927),
    ('Penguin Books', 'London', 1935),
    ('HarperCollins', 'San Francisco', 1989);

-- Adăugare date în tabela books
insert into books (title, genre, publication_year, isbn, author_id, publisher_id) values
    ('The Great Gatsby', 'Fiction', 1925, '978-3-16-148410-0', 1, 1),
    ('To Kill a Mockingbird', 'Drama', 1960, '978-0-06-112008-4', 2, 2),
    ('1984', 'Science Fiction', 1949, '978-0-452-28423-4', 3, 3);

-- Adăugare relații în tabela book_authors
insert into book_authors (book_id, author_id) values
    (1, 1),
    (1, 2),
    (2, 2),
    (3, 3);

-- Adăugare cărți noi
insert into books (title, genre, publication_year, isbn, author_id, publisher_id) values
    ('The Catcher in the Rye', 'Fiction', 1951, '978-0-316-76948-0', 1, 1),
    ('One Hundred Years of Solitude', 'Magical Realism', 1967, '978-0-06-088328-7', 2, 2),
    ('The Hitchhiker''s Guide to the Galaxy', 'Science Fiction', 1979, '978-0-330-25864-7', 3, 3);


update books set genre = 'Classic' where title = 'The Catcher in the Rye';


delete from books where title = 'The Hitchhiker''s Guide to the Galaxy';


select * from authors;
select * from publishers;
select * from books;
select * from book_authors;


update authors set birth_year = 1985 where author_id = 3;
update publishers set location = 'Los Angeles' where publisher_id = 3;


delete from authors where author_id = 1;
delete from publishers where publisher_id = 2;

-- INNER JOIN
select books.title, authors.author_name
from books
inner join authors on books.author_id = authors.author_id;

-- RIGHT JOIN
select books.title, publishers.publisher_name
from books
right join publishers on books.publisher_id = publishers.publisher_id;

-- LEFT JOIN
select authors.author_name, books.title
from authors
left join books on authors.author_id = books.author_id;

-- FULL JOIN
select books.title, publishers.publisher_name
from books
full join publishers on books.publisher_id = publishers.publisher_id;

select books.title, books.genre, authors.author_name
from books
inner join authors on books.author_id = authors.author_id
where authors.author_name = 'Jane Smith';

select books.title, books.publication_year, publishers.publisher_name
from books
inner join publishers on books.publisher_id = publishers.publisher_id
where publishers.publisher_name = 'Random House';

select publication_year, count(*) as total_books
from books
group by publication_year
order by publication_year;

select authors.author_name, count(*) as total_books
from authors
inner join book_authors on authors.author_id = book_authors.author_id
inner join books on book_authors.book_id = books.book_id
group by authors.author_name
order by total_books desc;

select publishers.publisher_name, count(*) as total_books
from publishers
inner join books on publishers.publisher_id = books.publisher_id
group by publishers.publisher_name
order by total_books desc
limit 5;

select books.title, authors.author_name
from books
inner join book_authors on books.book_id = book_authors.book_id
inner join authors on book_authors.author_id = authors.author_id
order by authors.author_name, books.title;

drop table if exists book_authors;
drop table if exists books;
drop table if exists authors;
drop table if exists publishers;