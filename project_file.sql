create table Books(
	Book_ID	serial	primary key,
	Title	varchar(100),
	Author	varchar(100),
	Genre	varchar(100),	
	Published_Year	int,
	Price	numeric(10,2)	,
	Stock	int
);

create table customers(
	Customer_ID	serial	primary key,
	Name	varchar(100),
	Email	varchar(100),
	Phone	varchar(15),
	City	varchar(50),
	Country	varchar(150)
)

create table orders (
	Order_ID	serial	primary key,
	Customer_ID	int	references Customers(Customer_ID),
	Book_ID	int	references Customers(Customer_ID),
	Order_Date	Date,	
	Quantity	int,	
	Total_Amount	Numeric(10,2)	
)

select * from books;
select * from customers;
select * from orders;


-- 1 Retrive all books in the "fiction" genre
select * from books where genre='Fiction';

-- 2. Find books published after the year 1950
select * from books where published_year > 1950;

-- 3. show all customers from the canada
select * from customers where country = 'Canada';

-- 4. Show orders placed in Novembar 2023
select * from orders where order_date between '2023-11-01' and '2023-11-30';

-- 5.Retrive the total stock of books available
select sum(stock) as total_stock from books;

-- 6. Find the details of the most expensive book
select * from books where price = (select max(price) from books);
select * from books order by price desc limit 1;

-- 7. show all customers who ordered more than 1 quantity of a books;
select * from Orders where quantity > 1;

-- 8. Retrive all orders where the total amount exceeds $20
select * from orders where total_amount > 20;

-- 9. List all genres available in the books table
select distinct genre from books;

-- 10. find the book with the lowest stock
select * from books order by stock asc limit 1;

-- 11. Retrieve the total number of books sold for each genre
select b.genre, sum(o.quantity) as total_books_sold
from Orders o
join Books b on 
o.book_id = b.book_id
group by b.genre;

-- 12 find the average price of books in the fantasy genre
select avg(price) as average_price from books where genre='Fantasy';

-- 13 List the customer who have placed at least 2 orders
select o.customer_id,c.name, count(o.order_id) as order_count from orders o
join customers c
on o.customer_id = c.customer_id
group by o.customer_id, c.name
having count(o.order_id) >2

-- 14 find the most frequently ordered books
select o.book_id,b.title, b.author, b.genre, count(o.order_id) as order_count
from orders o
join books b
on o.book_id= b.book_id
group by o.book_id, b.title,b.author, b.genre
order by order_count desc limit 1;


-- 15 show the top 3 most expensive books of fantasy genre
select * from books 
where genre='Fantasy'
order by price desc
limit 3;

-- 16 Retrieve the total quantity of books sold by each author
select b.author, sum(o.quantity) as total_book_sold
from orders o
join books b
on o.book_id=b.book_id
group by b.author;

-- 17 List the cities where customers who spent over $30 are located
select distinct c.city, total_amount
from orders o
join customers c on o.customer_id=c.customer_id
where o.total_amount >= 30;

-- 18 find the customer who spent the most on orders
select c.customer_id, c.name, sum(o.total_amount) as total_spent
from orders o
join customers c
on o.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 1;

-- 19 Calculate the stock remaining after fulfilling all orders
select b.book_id, b.title, b.stock, coalesce(sum(o.quantity),0) as order_quantity,
b.stock - coalesce(sum(o.quantity),0) as Remaining_Quantity
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id;

