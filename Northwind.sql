

use Northwind --burada SQL server'a Northwind veritabanını kullanacağımız bildirdim.


select * from Products 
select CategoryName, Description from Categories

--Employees(Çalışanlar Tablosundan) FirstName, LastName, Title bilgileri

select FirstName, LastName, Title from Employees

--Suppliers (Tedarikçiler) tablosundan CompanyName, ContactName, Address, City, Region bilgilerini getirin

select CompanyName, 
	   ContactName, 
	   Address, 
	   City, 
	   Region 
from Suppliers


--bu sorguda fark ettiyseniz ilk önce select kodumu yazdım (her zamanki gibi), daha sonra filtreme işlemini yani where sorgusunu devreye soktum, son olarak soru sonucundaki bana dönen veri kümesinde hangi sütunları görmek istiyorsam onları yazdım.
select FirstName,
	   LastName, 
	   Title 
from Employees 
where EmployeeID = 1
--Not: Matematikten bildiğiniz eşitlik sembolü burada da aynı anlamda kullanılmaktadır. O zaman şu yorumu yapabiliriz, büyüktür, küçüktür yada küçük eşittir sembolleride aynı anlama gelmektedir.

--Soru: Ürünler (Products) tablosundan ürün fiyatı (UnitPrice) 200'den büyük olan ürünlerin, ProductID, ProductName, UnitInStock, UnitPrice bilgilerini getirin...!

select ProductID,
	   ProductName,
	   UnitsInStock,
	   UnitPrice 
from Products 
where UnitPrice > 200

-- Soru: Ürünler tablosundan stok miktarı 100 ve 200 arasında olan ürünlerin Id, adını, birim fiyatı, stok miktarını getirin..!

--Not: Farkındaysanız bu soruda iki tane şart var. Burada where ifadesi yanında ve (and) anlamına gelen bir operatör daha kullanmalıyız.
--Örneğin:
-- where sütun_adı = değer and sütun_adı = değer

select ProductID,
	   ProductName, 
	   UnitPrice, 
	   UnitsInStock 
from Products 
where UnitsInStock > 100 
	and UnitsInStock < 200


--Soru: EmployeeId'si 2 yada 5 olan kullanıcıların Id, Adını, Soyadını, ünvanını getirin.
--Not: Bu soruda dikkat ederseniz "yada" ifadesi geçmektedir. Bunun yazılımdaki karşılığı "or" ifadesidir.
-- "and" vs "or"
-- "and" operatörü bir aralık kontrolü yapılmak istenildiğinde kullanılmaktadır. "And "operatörü ile koyduğum şartların hepsine uyulmak zorundadır. "or" operatöründe ise şartlardan birisinin tutması yeterlidir.

select EmployeeID, 
	   FirstName, 
	   LastName, 
	   TitleOfCourtesy 
from Employees
where EmployeeID = 2 
	or EmployeeID = 5


-- Ünvanı (TitleOfCourtesy) Mr. veya  Dr. olan çalışanların, Id, Adını, soyadını, ünvanını getirin.
-- Not: sözel ifadeler tek tırnak arasında yazılırlar.

SELECT EmployeeID,
	   FirstName,
	   LastName,
	   TitleOfCourtesy
	   FROM Employees 
	   where TitleOfCourtesy = 'Mr.' or TitleOfCourtesy = 'Dr.'

-- Ürün fiyatı 50'den büyük ve stok miktarı 100 den büyük olan ürünleir listeleyin
select ProductID,
	   ProductName,
	   UnitPrice,
	   UnitsInStock from Products 
where UnitPrice > 50 and UnitsInStock > 100


--1960 yılında doğan çalışanların Id, Adını,Soyadını, ünvanını getirin
--Not: Year(datetime parametre)=> bu method datetime tipinde parametre içerisine alır. 1948-12-08 00:00:00.000 datetime tipindeki bu data içerisinden bize yıl bilgisini alarak bu bilgiyi geri döner. Year methodu SQL içerisinde gömülü yani built-in bir methodtur. 
select EmployeeID,
	   FirstName+' '+LastName as [Full Name], -- FirstName ve LastName sütunlarındaki bilgileri bileştirerek tek sütun haline getirdik. "as" yardımıyla bu sütuna isim verdik. Şayet birleştirme işleminden sonra isim vermeseydik. NoColumnName şeklinde bir isimlendirme olacaktı
	   Title 
from Employees 
where YEAR(BirthDate) = 1960

--1950 ile 1961 yılları arasında doğan çalışanların listeleyin, Id'si, adı ve soyadı alanlarını birleştirin, adress

select EmployeeID, 
	   FirstName+SPACE(1)+LastName as [Full Name],
	   Address from Employees 
where YEAR(BirthDate) >= 1950 and YEAR(BirthDate) <= 1961

--Soru: İngilterede oturan (Country) kadınların, adı ve soyadını birleştirerek, ünvanı, ülkesi ve doğum tarihini listeleyin

select EmployeeID, 
	   FirstName+Space(1)+LastName as [Full Name], 
	   Country, 
	   TitleOfCourtesy, 
	   YEAR(BirthDate) as [Birth Date] from Employees
where Country = 'UK' 
AND 
(TitleOfCourtesy = 'Mrs.' Or TitleOfCourtesy = 'Ms.')

-- Ünvanı Mr. olanlar veya yaşı 60'tan büyük olanların, Id, Adı,Soyadı, Doğum tarihi, ünvanı bilgileirni getitir.

select TitleOfCourtesy+SPACE(1)+FirstName+SPACE(1)+LastName AS Info,
	   Year(Getdate()) - Year(BirthDate) as Age	 from Employees
where TitleOfCourtesy = 'Mr.'
or
(DATEDIFF(YY, BirthDate, GETDATE()) > 60)

--DATEDIFF() fonksiyonu içerisine parametre olarak verilen referans bilgisine göre başlangıç ve bitiş değerleri arasında matematiksel olarak işlem yapar. Örneği incelediğimizde "YY" parametresi, 2. ve 3. parametrelerdeki datetime tipindeki değerlerden yıl bilgisini söküp almaya yaramaktadır. Ayrıca 2. ve 3. parametrelerden elde edilen değerler çıkarma işlemi yaparak int tipinde bize eldde edilen değeri teslim edilmiştir.
--GETDATE() fonksiyonu ise sistem saatini bize teslim eder. Kullanıldığı zamanın bilgisini teslim eden dinamik bir fonksiyondur.

--Null Verileri Sorgulamak
-- select * from Employees yaptığımızda Region bilgisi olmayan bazı çalışanlar olduğunu tespi ettik

--Region bilgisi olmayan kullnacılar
select * from Employees where Region is null

--Null olmayanlar 
select * from Employees where Region is not null

--Sıralama İşlemleri
-- Ascending (Azdan Çoka - Artan Sırada) & Descending (Çoktan Aza - Azalan Sırada)

select * from Employees 
where EmployeeID > 2
order by FirstName ASC
-- Not: Order by varsayılan olarak ASC kullanmaktadır. Yani bir şey belirtmezsek ASC kabul ederek artan sırada sıralar

--Soru: Kullanıcıları yaşlarına göre büyükten küçüğe doğru sıralayın, Id, Adı,Soyadı, ünvanı
-- Not: Order By'da sütunlara verilen takma isimler kullanılabilir
select EmployeeID,
	   FirstName+' '+LastName as [Full Name],
	   TitleOfCourtesy,
	   DATEDIFF(YY, BirthDate, GETDATE()) as Age 
from Employees
order by age desc

--Not:Order by ile birlikte sütun isimlerinin yerine select sorgusundaki sıralmasındaki değeride kullanılanbilinir
select EmployeeID,
	   FirstName+' '+LastName as [Full Name],
	   TitleOfCourtesy,
	   BirthDate,
	   HireDate
from Employees
order by 3 desc

--Not: Order by ile birlikte birden fazla parametere kullanabiliriz

-- Çalışanlarrın ünvanlarına göre ve ünvanları aynıysa yaşlarına göre büyükten küçüğe sıralayınız..

select EmployeeID, 
	   FirstName+' '+LastName as [Full Name], 
	   TitleOfCourtesy, 
	   DATEDIFF(YY, BirthDate, GETDATE()) as Age from Employees
where TitleOfCourtesy is Not null
order by 3, 4 desc

--Yukarıdaki sorguda yapılan sıralama işlminde ilk önce 3 sütunda yer alan TitleOfCourtesy'ye göre azalan sıralama yapılda daha sonra ünvanı aynı olan kullanıcılar için 4. sütundaki yaş parametresine bakılarak sıralmaa yapılır.

--Between - And Kullanımı
--Aralık kontrolü yapmka için kullanılır

--Doğum tarihi 1952 ile 1960 arasında olan kullanıcıları listeleyin
select FirstName,
	   LastName, 
	   YEAR(BirthDate) as [Birth Date] from Employees
where Year(BirthDate) between 1952 and 1960
order by 3 desc

--Alfebetik olarak Janet Robert arasında olan çalışanların listeleyin
select FirstName,LastName 
from Employees
where FirstName between 'Janet' and 'Robert'
order by FirstName

--In Kullanımı: Birden fazla or yazmamız gereken durumlarada kullanabileceğimiz bir yapıdır.

--Örneğin: Ünvanı Mr. veya Dr. olan çalışanları listeleyin

select TitleOfCourtesy+' '+FirstName+' '+LastName as [Title of Person] from Employees
where TitleOfCourtesy In ('Mr.', 'Dr.')

--1950, 1955 veya 1960 yıllarında doğan çalışanları listeleyin
select TitleOfCourtesy+' '+FirstName+' '+LastName as [Title of Person], 
	   YEAR(BirthDate) as [Birth Date] from Employees
where Year(BirthDate) in (1950, 1955, 1960)

--Top kullanımı
-- Sorgu sonucunda dönen sonuç kümesinden top 3 ifadesi ile ilk üç satırı bize döner. 

--Soru: Fosil çalışanı bulun. Ölmüş ama haberi olmayan dinozor çalışanı bulun.
select Top 1 FirstName+' '+LastName as [Full Name], 
       YEAR(BirthDate) as Age
	   from Employees
	   Order by age asc

--Like Kullanımı
select FirstName,LastName from Employees where FirstName Like 'Robert'

--Adının ilk harfi A ile başlayan çalışanlar
select * from Employees where FirstName Like 'A%' -- yüzde işareti ile ilk harfi sorgulayabiliriz.burada önemli olan sonda olmasıdır.

--Soyadı N harfi ile bitenler
select * from Employees where LastName Like '%N'

--Adının içerisinde E harfi geçenler
select * from Employees where FirstName Like '%E%'

--Adının ilk harfi A yada L olanlar
--I.Yol
select * from Employees where FirstName Like '[AL]%'
--II.Yol
select * from Employees where FirstName Like 'A%' or FirstName Like 'L%'

--Adının içerisinde  R yada T olanalar
select * from Employees where FirstName Like '%[RT]%'

--Adının içerisinde R ve E arasında 2 karakter olan

select * from Employees where FirstName Like '%R__E%' 

--Adı T harfi ile bitmeyenler
--I.Yol
select * from Employees where FirstName Not Like '%T'
--II.YOl
select * from Employees where FirstName  Like '%[^T]'

--Not: Select sadece tablodan veri çekerken kullanılmaz..

select GetDate() as [O an]

select 5+9 as Toplam

select 5 - 9  as Fark

select 5 % 2 as [Mod] -- 5'şin 2'ye bölümünden kalanı verir

select 'YZL 5112 SQL Eğitimi'

--String Fonksioynlar

select ASCII('A') as [ASCII KODU]

select CHAR(65) as Karakter

select CHARINDEX('@', 'burakyilmaz@bilgeadam.com') as Konum -- her sözel ifade aslında karakter dizisidir. Yani bu karakterler içerisinde dolaşabiliriz, konum bilgilerini alabiliriz. Bu karakter dizilerinde index mantığı bulunmaktadır. SQL'de birden başlayarak vektörel olarak atrı yönde artarak her bir karaktere bir index değeri denk gelmektedir. Bulamazsa sıfır dönmesi gerekir.

select LEFT('Bilge Adam', 4) as [Soldan Karakter Sayısı]

select Right('Bilge Adam', 4) as [Sağdan Karakter Sayısı]

select Len('Bilge Adam') as [Karakter Sayısı]

select lower('BiLgE AdaM') as [Hepsi Küçük]

select upper('BiLgE AdaM') as [Hepsi Büyük]

select LTRIM('          Bilge Adam') as [Soldaki Boşlukları Siler]

select LTRIM(RTRIM('          Bilge Adam            ')) as [Tüm Boşlukları Siler]

select RTRIM('Bilge Adam        ') as [Sağdaki Boşlukları Siler]

select Replace('Birbirbirilerine', 'bir', 'iki') as [Metinlerin yerine yenilerini yazar]

select SUBSTRING('Öz Bilge Adam', 3, 6) as [Alt Metin] -- 1. parametredeli söz öbeğinden, 2. ve 3. parametrelere denk gelen index değerlerindeki harfleri bize teslim eder. 

select REPLICATE('Bilge', 5) -- Belirtilen metni 2. parametredeki değer kadar tekrar ettirir

--Aggragate Functions

select COUNT(*) from Products -- Count() fonksiyonu bize satır sayısını döner

select COUNT(ProductID) from Products

select COUNT(Region) from Employees -- Employees tablosunda Region sütununda Null olan alanlar olduğundan 5 satır data olduğunu bize söyledi. 

select COUNT(City) from Employees -- bu sorgu sonucunda bize 9 döndün. Lakin city sütununda tekrar eden satırlar vardı. Bunları göz ardı ederek bize satırları saydı.

--Not: O halde şu usavurumu yapabiliriz. Count ile birlikte herzaman biricik sayılabilecek yani ID gibi bir sütun kullanılmalıdır.

select COUNT(DISTINCT City) from Employees --Tekrar edilen satırlar Distinct sayesinde görmezden gelindi

select Sum(UnitPrice) as [Total Price] from Products -- SUM() verilen sütundaki bilgileri toplar

--Çalışanların yaşlarının toplamını hesaplayanız

select Sum(DATEDIFF(YY, Birthdate, GetDate())) from Employees

--AVG() ortalama değeri hesaplar

--Ürünlerin ortalama fiyatını hesaplayın

select AVG(UnitPrice) from Products

--Çalışanların yaşlarının ortalaması

select AVG(DATEDIFF(YY, Birthdate, GetDate())) from Employees

--MIN() => Minimum değeri teslim eder
--Max() => Maxsimum değeri teslim eder

--En ucuz ve en pahalı ürün
select MIN(UnitPrice) as [en ucuz] from Products
select Max(UnitPrice) as [en pahalı] from Products

--Group By
--Sorgu sonucunda dönen veri kümesi üzerinde gruplama işlemleri yaptığımız yapıdır.

--hangi ülkede kaç çalışanım var
select Country, Count(*) as [Çalışan Sayısı] from Employees
where Country is not null
group by Country

--Ürün fiyatı 35'ten az olan ürünleri kategorilerine göre grouplayınız
select Count(*) as [Total Product], CategoryID from Products
where UnitPrice < 35
group by CategoryID

--Çalışanların yapmış olduğu sipariş sayısı

select Count(*) as [Sipariş Adedi], EmployeeID from Orders
group by EmployeeID
order by [Sipariş Adedi] desc

--Baş harfi A-K aralığında olan ve stok miktarı 5-50 aralığında olan ürünleri kategorilerine göre gruplayınız
select CategoryID, Count(*) Adet from Products
where (ProductName Like '[A-K]%')
	  and
	  (UnitsInStock Between 5 and 50)
group by CategoryID

--Her bir siparişteki ürün sayısını bulunuz (Order Details)
select


--Her bir süparişin tutarına göre listeleyiniz (UnitPrice * Quantity  * (1-Discount))

select OrderID, 
	   Sum(UnitPrice * Quantity  * (1-Discount)) as Tutar 
from [Order Details]
group by OrderID
order by 2 desc

--Having 
-- Sorgu sonucunda dönen veri kümesi üzerinde Aggregate Fonksiyonlara bağlı olarak filtreleme işlmelerinde kullanılır. şayet sorguda aggregate function yoksa having, where ile aynı görevi görür.

--Toplam tutarı 2500 ile 3500 arasında olan siparişleri sıralayalım
select OrderID as [Sipariş Kodu],
	   Sum(UnitPrice * Quantity  * (1-Discount)) as [Toplam Tutar]
from [Order Details]
group by OrderID
having Sum(UnitPrice * Quantity  * (1-Discount)) between 2500 and 3500
order by 2 desc

--her bir saparişteki toplam ürün sayısı 200 üzerinde olan siparişleri listeleyeniz
select OrderID, SUM(Quantity) as Adet from [Order Details]
group by OrderID
having sum(Quantity) > 200
order by 2 desc

--Hangi kategory altındaki ürünlerin stokları 400'zün altında
select CategoryID, 
	   Sum(UnitsInStock) as [Stok Mikatarı] 
from Products
group by CategoryID
having SUM(UnitsInStock) < 400
order by 2 desc

--DML (Data Manipulating Language)
--Veri Tabanına veri ekleme, günceleleme  ve silme.
-- Backend developer olarak bizim omuzumuzdaki en büyük yük CRUD(Create-Read-Update-Delete) operasyonlarıdır. Bu operasyonlar bir projenin yüzde 70'şini kapsamaktadır. Veri tabanı tarafında bugüne kadar yaptığımız sorgular hep Read operasyonuydu.

--Insert: Veri eklemek için kullandığımız bir yapıdır.
insert Categories (CategoryName, Description) values ('Baklagiller','Vitamindir bunlar')

insert Shippers (CompanyName, Phone) values ('MNG Kargo','(212)9999999')

--Update: Güncelleme işlemi, bu işlemde her zaman ama her zaman güncellemek istediğimiz varlığı Id'sinden yakalıyoruz ve sonra güncelliyoruz.

update Shippers
Set
	Phone = '(216)8881288'
where ShipperID = 4 -- buradaki filtrelemeyi yapmazsam gider bütün telefon numaralarını günceller


--Trick: İşe girdiğiniz zaman, size verilen görevde (task) kendinize güvenmiyorsanız, çalışacağınız tabloyu bu şekilde bir test tablosuna aktarak görevinizi icra edip akabinde testleriniz yaptıktan sonra gerçek tablo üzerinde uygulaya bilirsiniz ve test tablosunuda silerisniz
select * into test_env_Calisanlar from Employees

select * from test_env_Calisanlar

--Delete: Bu işlemde update gibi uygulanacak varlığın muhakak Id'sinden yakalanması gerekmektedir.

delete from Shippers where ShipperID = 4

----SQL TABLo Yaratma Güncelleme ve Silme

use LibraryDb

Create Table Books(
	[Id] int Identity(1,1) Not Null,
	[Title] Nvarchar(50) Not Null
);

Create Table Authors(
	[Id] int Identity(1,1) Not Null,
	[Full Name] NVarchar(50) not null
);

-- Bir yazarın birden fazla kitabı olabilir, bir kitabında birden fazla yazarı olabilir. Bu gibi durumlarda dummy yada assigned table dediğimiz, tablolar kullanıyoruz.

Create Table AssignedBooksToAuthor(
	[Id] int Identity(1,1) Not Null,
	[AuthorId] int Not Null,
	[BookId] int Not Null
);

use LibraryDb

Create Table Books(
	[Id] int Identity(1,1) Not Null,
	[Title] Nvarchar(50) Not Null
);

Create Table Authors(
	[Id] int Identity(1,1) Not Null,
	[Full Name] NVarchar(50) not null
);

-- Bir yazarın birden fazla kitabı olabilir, bir kitabında birden fazla yazarı olabilir. Bu gibi durumlarda dummy yada assigned table dediğimiz, tablolar kullanıyoruz.

Create Table AssignedBooksToAuthor(
	[Id] int Identity(1,1) Not Null,
	[AuthorId] int Not Null,
	[BookId] int Not Null
);

--Joins
--Birden fazla tablodan veri çekmemize imkan tanıyan yapıdır. Join işlemlerinde tabloları birşeltiriken ilgili tabloların primary key ve forenign key'lerinden faydalanıyoruz.
use Northwind
--Categories tablosundan categoryname, product tablosundan productname
--Yukarıdaki soruyu çözmek için iki tablo arasındaki ilişkiyide bilmemiz gerekmektedir. 
select c.CategoryID,
	   c.CategoryName,
	   p.ProductID,
	   P.ProductName 
from Categories c join Products p on c.CategoryID = p.CategoryID 

--Kategorilerine göre toplam stok miktarı
select c.CategoryName,
	    SUM(p.UnitsInStock) as Adet
from Categories c join Products p on C.CategoryID = p.CategoryID
group by c.CategoryName
order by Adet desc

--Suppliers tablosundan CompanyName, COntactName
--Products tablosundan ProductName, UnitPrice
--Categories tablosundan Categoryname
--CompanyName'e göre artan sırada sıralayın
select s.CompanyName,
	   s.ContactName,
	   p.ProductName,
	   p.UnitPrice,
	   c.CategoryName 
from Suppliers s join Products p on s.SupplierID = p.SupplierID
			     join Categories c on c.CategoryID = p.CategoryID
order by 1


--Hangi sipariş hangi çalışan tarafından hangi müşteriye hangi tarihte yapılmış
select o.OrderID, O.OrderDate, c.CompanyName, c.ContactName, e.FirstName+' '+e.LastName as [Full Name], e.Title
from Customers c join Orders O on c.CustomerID = o.CustomerID
			     join Employees e on e.EmployeeID = o.EmployeeID

--Her bir çalışanın ne kadarlık satış yapmış?
select (FirstName+' '+LastName) as [Calışan],
	   Cast(Sum(UnitPrice * Quantity * (1-Discount)) as decimal) as [Toplam]
	from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] od on od.OrderID = o.OrderID
group by (FirstName+' '+LastName)
order by 2
	

----Ürünlerime göre satışlarım nasıl?
select ProductName,
	   Sum(od.Quantity) as Adet,
	   Sum(od.Quantity * od.UnitPrice * (1-od.Discount)) as Gelir
from Products P
join [Order Details] od on p.ProductID = od.ProductID
group by ProductName
order by 3 desc


--Ürün categorilerine göre satışlarım nasıl?
select c.CategoryName,
	   Sum(od.Quantity * od.UnitPrice * (1-	od.Discount)) as Gelir
from Categories C
join Products P on C.CategoryID = P.CategoryID
join [Order Details] Od on od.ProductID = p.ProductID
group by c.CategoryName
order by 2 desc


--Hangi kargo şirketine ne kadar ödeme yapmışım

select s.CompanyName,
	   SUM(o.Freight) as [Ödenen Ücret] 
from Shippers s
join Orders o on o.ShipVia = s.ShipperID
group by s.CompanyName

--Hangi tedarikçiden aldığım üründen ne kadar satmışım
select s.CompanyName,
	   p.ProductName,
	   Sum(od.Quantity) As Adet,
	   Sum(od.Quantity * od.UnitPrice * (1- od.Discount)) as Gelir
from Suppliers s
join Products p on s.SupplierID = p.SupplierID
join [Order Details] od on od.ProductID = p.ProductID
group by CompanyName, ProductName
order by 3 desc


--En değerli müşterim kim

select top 1 c.CompanyName,
	   Sum(od.Quantity) as Adet,
	   Sum(od.Quantity * od.UnitPrice * (1- od.Discount)) as Gelir
from Customers C
join Orders O on C.CustomerID = o.CustomerID
join [Order Details] od on Od.OrderID = o.OrderID
group by c.CompanyName
order by 3 desc


--Zamanında teslim edemediğim siparişlerin id'leri nelerdir? kaç günde gönderememişim?
select OrderID, 
	   DATEDIFF(Day, RequiredDate, ShippedDate) as Dt 
from Orders
where DATEDIFF(Day, RequiredDate, ShippedDate) > 0

--Her bir siparişin sahibi kim ve bu müşteriler hangi ürünleri almış?
select c.CompanyName,
	   p.ProductName
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join [Order Details] od on od.OrderID = o.OrderID
join Products p on od.ProductID = p.ProductID

--Hangi müşteri
--Hangi siparişi vermiş
--hangi çalışan almış
--hangi tatihte gerçekleşmiş
--hangi kargo firması taşımış
--hangi fiyattan almış
--hangi kategoridenmiş
--bu ürün hangi tadarikçi sağlamış

select o.OrderID,
	   c.CompanyName,
	   e.FirstName+' '+e.LastName,
	   o.OrderDate,
	   s.CompanyName,
	   p.ProductName,
	   od.Quantity,
	   od.Quantity * od.UnitPrice * (1- od.Discount) as Gelir,
	   ca.CategoryName,
	   su.CompanyName
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join Customers c on c.CustomerID = o.CustomerID
join Shippers s on s.ShipperID = o.ShipVia
join [Order Details] od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID
join Categories ca  on ca.CategoryID = p.CategoryID
join Suppliers su on su.SupplierID = p.SupplierID


--Left Join: Sorguya katılan tablolardan soldaki tablodaki tüm veriyi getirirken sağdakinden sadece kesişen veriyi getirir.

--Sipariş vermeyen müşteriler
select CompanyName,
       Address
	   OrderID from Customers c 
left join Orders o on c.CustomerID = o.CustomerID
where OrderID is null

--Hiç satılmayan ürünlerim
--select o.OrderID,
--	   p.ProductName,
--	   od.Quantity,
--	   OrderDate,
--	   ShippedDate,
--	   od.UnitPrice from 
--Products p
--left join [Order Details] od on od.ProductID = p.ProductID
--left join Orders o on o.OrderID = od.OrderID
--order by o.OrderID


--User Defined Functions
--UDF'ler sorgu sonucunda kullanulabilinirler. Biz bugüne kadar SQL içerisindeki built-in fonksiyonları gördük. Bu methodları kullanırken fark etmişsinizdirki bu fonksiyonlar içerilerine parametre almaktadır. Aldıkları parametrelerin hep bir tipi bulunmaktaydı.

--fonksiyon yaratırken create terimini kullanıyourz. 
go
Create Function KDVHesapla(@fiyat money)
returns money -- built-in fonksiyonlarda hatırlarsanız kullandığımız fonksiyonların bir geri dönüş tipi bulunmaktaydı.
	begin
		return @fiyat * 1.08
	end;
go

--fonksiyonu yazdıktan sonra ilgli fonksiyonu seçip execute ettik. Bu işlemi bir kez yapacağız. bir daha yapmaya gerek yoktur bir kez execute edildiğinde veritabanı içerisinde depolanmış oldu.

select ProductName,
	   CategoryName,
	   UnitPrice,
	   dbo.KDVHesapla(UnitPrice) as [KDV] from Products
join Categories on Products.CategoryID = Categories.CategoryID

--Kişilerin yaşlarını hesaplayan fonksiyon yazınız..
create function yasHesapla(@dogumTarihi datetime)
returns int
begin
	return Datediff(YY, @dogumTarihi, GetDate())
end
--not: fonksiyonun dönüş tipi ile return edeceği tip aynı olmalı. Önceki deneyimlerimden Datediff() fonksiyonunun "int" döndüğünü biliyorum, bu yüzden yasHesapla() fonksiyonun'da int dönmesi gerekmketedir.

select FirstName+' '+LastName, dbo.yasHesapla(BirthDate) as [Age] from Employees
order by age desc

--Tablo döndüren fonksiyonlar: dışarıdan gelen parametre sonucunda tablo döndurürüler. Normal fonksiyonlar gibi Begin-End mekanizmları yoktur.
create function calisanbilgilerinigetir(@employeeId int)
returns table
	return select * from Employees where EmployeeID = @employeeId


select * from calisanbilgilerinigetir(5)

--Kullanıcıdan alınan stok miktarı aralığına göre, bu aralıkta kalan ürünleri listeleyen fonksiyonu yazın
create function stokDurumu(@baslangıc int, @bitis int)
returns table
	return select * from Products where UnitsInStock = @baslangıc and UnitsInStock = @bitis


select * from stokDurumu(20,50)

alter function stokDurumu(@baslangıc smallint, @bitis smallint)
returns table
	return select * from Products where UnitsInStock > @baslangıc and UnitsInStock < @bitis


--Çalışanşarın adının baş hargine göre listeleyen fonksiyonu yazınız
create function basHarfeGoreGetir(@basHarf varchar(1))
returns table
	return select * from Employees where left(FirstName, 1) = @basHarf


select * from basHarfeGoreGetir('A')

alter function basHarfeGoreGetir(@basHarf varchar(1))
returns table
	return select * from Employees where left(FirstName, 1) = @basHarf

--kullanıcıdan alınan parametre değerinin üzerinde satılan ürünlerinin listesini getirin
create function satilanUrun(@satismiktari int)
returns table
	return 
		select ProductName,
			   Sum(od.Quantity) as [Satılan Urun] 
		from [Order Details] od
		join Products p on od.ProductID = p.ProductID
		group by ProductName
		having Sum(od.Quantity) > @satismiktari
		

select * from satilanUrun(1000)


--Stored Procedure(Saklı Yordam)
--TSQL komutları ile hazrıladığımız işlemler bütünün çalıştırılma anında derlenmesi ile size bir sonuç kümesi üreten sql server bileşenleridir.
--Çalışma anı planlama sağlar ve tekrar tekrar kullanılabilirler. (Fonksiyonlar gibi)
--Querylerimizide otomatik parametre getiriler
--Uygulmalar arasında ortak olarak kullanılabilinirler.
--Güvenli data modifikasyonu sağlar
--Job olarak tanımlanabilinirler ve schedule edilebilinirler. Yani her gün saat 01:00'da bir sp tetiklenerek ona işlem yaptırabiliriz.

use Northwind

-- İlk kez sp yazarken "Create" kullanılmaktadır. Güncellerkende her zamanki gibi "Alter".
Create Procedure sp_CalisanlariListele --procedure oluşturduk
as
	Begin
		select FirstName,
			   LastName,
			   Title from Employees
	End

execute sp_CalisanlariListele --procedure çalıştırdık

drop procedure sp_CalisanlariListele -- procudure silmek için

--Sp'lerde parametre kullanımı

create proc sp_UrunByKategori @id int
as 
	Begin
		select ProductName,
			   CategoryName
		from Categories c
			join Products p on c.CategoryID = p.CategoryID
		where c.CategoryID = @id
	End


execute sp_UrunByKategori @id=8


--ad ve soyadına göre çalışanları listeleme
create proc sp_GetEmployeesByFullName @firstName nvarchar(20), @lastName nvarchar(30)
as
	Begin
		select FirstName+Space(1)+LastName, Title from Employees
			where FirstName = @firstName and LastName = @lastName
	End

execute sp_GetEmployeesByFullName @firstName='Robert', @lastName='King'

--Dışarıdan girilen iki tarih aralığında bulunan siparişler için sp
create proc sp_GetOrderByDate @startDate datetime, @endDate datetime
as
	Begin
		select OrderId,
			   OrderDate,
			   ShippedDate
		from Orders
		where OrderDate between @startDate and @endDate			
	End


execute sp_GetOrderByDate '01/01/1997', '12/30/1997'

--Id'si verilen müşterinin toplamda ne kadar alışveriş yaptığını hesaplayan sp'yi yazınız
create proc sp_GetCustomerOrders @Id nchar(5)
as
	begin
		select c.CompanyName, sum(od.Quantity * od.UnitPrice * (1- od.Discount)) as [Gelir] 
		from [Order Details] od
		join Orders o on od.OrderID = o.OrderID
		join Customers c on c.CustomerID = o.CustomerID
		where c.CustomerID = @Id
		group by c.CompanyName
	end

execute sp_GetCustomerOrders 'Ocean'
	

--Dışarıdan ismi girilen çalışanın toplam yapmış olduğu satışı hesaplayan sp
Create proc sp_GetEmployeeTotalSale @fistName nvarchar(20)
as
	Begin
		select e.EmployeeID,
			   e.FirstName+Space(1)+e.LastName as [Full Name],
			   Cast(Sum(od.Quantity * od.UnitPrice * (1- od.Discount)) as decimal)
		from Employees e
		join Orders o on e.EmployeeID = o.EmployeeID
		join [Order Details] od on od.OrderID= o.OrderID
		where e.FirstName = @fistName
		group by e.EmployeeID, e.FirstName+Space(1)+e.LastName
	End

alter proc sp_GetEmployeeTotalSale @fistName nvarchar(20)
as
	Begin
		select e.EmployeeID,
			   e.FirstName+Space(1)+e.LastName as [Full Name],
			   Cast(Sum(od.Quantity * od.UnitPrice * (1- od.Discount)) as decimal) as [Gelir]
		from Employees e
		join Orders o on e.EmployeeID = o.EmployeeID
		join [Order Details] od on od.OrderID= o.OrderID
		where e.FirstName = @fistName
		group by e.EmployeeID, e.FirstName+Space(1)+e.LastName
	End

execute sp_GetEmployeeTotalSale 'Robert'

--Hangi kargo şirketine ne kadar ödeme yapmışım
create proc sp_GetShippersPaymentByCompanyName @companyName nvarchar(30)
as
	Begin
		select CompanyName, Sum(o.Freight) from Shippers s join Orders o on o.ShipVia = s.ShipperID
		where s.CompanyName = @companyName
		group by s.CompanyName
	End

execute sp_GetShippersPaymentByCompanyName 'Federal Shipping'

alter proc sp_GetShippersPaymentByCompanyName @companyName nvarchar(30)
as
	Begin
		select CompanyName, Sum(o.Freight) as [Total Price] from Shippers s join Orders o on o.ShipVia = s.ShipperID
		where s.CompanyName = @companyName
		group by s.CompanyName
	End

--Trigger(Tetikleyiciler)
--Bir tablo üzerinde insert, update, delete işlemlerinden biri yapıldığında otomatik olarak devreye girmesini istediğimiz işlemler varsa bunu trigger kullanarak geçekleştirebiliriz. Bu işlemlerde bize yardımıcı olacak iki tane sanal tablo vardır. Bunlar inserted ve deleted tablolarıdır. Bu tablolardan trigger'ın üzerinde tanımlı olduğu base tablo ile birebir aynıdır. Yani böylece girilen bir kaydı Inserted tablosundan, silinen bir kaydı Deleted tablosundan elde edebiliriz. Bir kaydı güncellemek istediğimiz zaman update işlelerinde Inserted ve Deleted tablolarından faydalanılabilinir. Yani updated diye bir tablomuz bulunmamaktadır.

--İki tip trigger vardır.
--DDL (Data Definition Language) ve DML (Data Manuplation Language) triggerları olmak üzere ikiye ayrılırlar.
--DDL: Triggerlar ise After ve Instead of olmak üzere iki ayrılmaktadır.
--After Trigger: Yaptığımız işlemden sonra (insert, update, delete) devreye girer.

--Bir üründen sipariş alınınca stok miktarından düşen trigger
--Not: Select bölümünde en son eklenen (inserted tablosundan) ürünün id'si ve miktarını yakalıyoruz

Create Trigger trg_SiparisEklendi on [Order Details]
After Insert
AS
	--Trigger içerisinde işlem yaparken RAM'da yaratılacak ve anlık olarak üzerinde değer depolayacak değişkenler tanımlıyoruz.
	Declare @kacAdet int, @hangiUrunId int;--iki tane değişken tanımladık. değişken tanımlarken türkçe karakter kullanmalaıyız, kelimeler arasında boşluk olmamalıdır. değişkenlerin isimleri yer alacakları görev ile ilintili olmalıdır. muhakak bir ismi ve tipi olmalıdır.
	select @hangiUrunId = ProductID, @kacAdet = Quantity from inserted
	Update Products
	SET UnitsInStock = UnitsInStock - @kacAdet
	where ProductID = @hangiUrunId

--İlk Insert
--Insert [Order Details] (ProductID, Quantity, OrderID, UnitPrice) Values (3, 5, 10248, 10)
--İkinci Insert
Insert [Order Details] (ProductID, Quantity, OrderID, UnitPrice) Values (10, 5, 10248, 10) -- Order Details tablosuna insert işlemi gerçekleştikten sonra "trg_SiparisEklendi" trigger teriklenerek Product tablosundaki UnitInStok bilgisini günceleyecek


select ProductID,ProductName, UnitsInStock from Products where ProductID = 10

select * from [Order Details]

--Sipariş silinirse, silinen adet kadarını stoğa geri ekleyen trigger
create trigger trg_SiparişSilindi on [Order Details]
after delete
as
	Begin
		declare @kacAdet int, @hangiUrun int;
		select @hangiUrun = ProductID, @kacAdet=Quantity from deleted
		Update Products
		Set UnitsInStock += @kacAdet -- UnitsInStock = UnitsInStock + @kacAdet
		where ProductID = @hangiUrun
	End


delete from [Order Details] where OrderID = 10248 and ProductID = 10

select ProductID,ProductName, UnitsInStock from Products where ProductID = 3

--Bir siparişin içerisindeki ürün adedi değiştirildiğinde (silindiğinde) stok miktarını ona göre güncelleyen trigger yazın
alter trigger trg_SiparisGüncellendi on [Order Details]
after update
as
	Begin
		declare @eskiAdet int, @yeniAdet int, @urunId int;
	
		select @eskiAdet=Quantity from deleted
	
		select @yeniAdet=Quantity, @urunId= ProductID from inserted
	
		update Products
		set UnitsInStock +=  @eskiAdet - @yeniAdet
		where ProductID = @urunId
	End

select * from [Order Details]
select * from Products where ProductID = 11

update [Order Details] set Quantity = 32 where OrderID = 10248 and ProductID=11

--Eksi Sipariş adedi   Yeni sipariş Adedi    Eski Stok   Yeni Stok Miktarı
--       22			            32               22             12


--instead of trigger
--Employees tablosundan bir çalışanı sildiğimizde bu çalışalının id bilgisini diğer tablolarda da bulunduğundan için silinemez. Cascade on delete hatası yersin. Zaten çalışanları tablodan silmek çok akıllıca bir hareket değildir. Çünkü bu çalışanın yapmış olduğu satış bilgileri de diğer tablolarda yer almaktadır.

--Silme işlemi yerine Employee tablosunda isDeleted isminde bir sürun oluşturuyoruz. Artık bir çalışan işten ayrıldığında bu çalışalın isDelted sütunu üzerinde değişiklik yapacağız. Kullanıcı aktif ise 0 işten ayrıldıysa 1 olarak bu durumu yöneteceğiz. Bu mantıkla satılan satılmayan, üyeliğini donduran donrurayan olarak çoğaltabiliriz.

--İlk önce isDelete sütununu Employee tablosuna ekleyelim
alter table Employees add isDelete int;

select * from Employees

create trigger trg_FiredEmpployee on Employees
instead of delete -- yani employee tablosunda ne zaman delete gerçekleşirse o zaman bu trigger ototmatik olarak tetiklenecek
as
	declare @kovulanId int;
	select @kovulanId=EmployeeID from deleted
	update Employees set isDelete=1 where EmployeeID = @kovulanId

delete from Employees where EmployeeID =9

--Shippers tablosuna insert edilirken kargo numarası 02219999999 şeklinde girildiğinde onu formatlı bir şekilde 0(222)999-99-99 şekli kaydeden triger yazın
create trigger trg_InsterShipper on Shippers
instead of insert
as
	Begin
		declare @kargoAdi nvarchar(50), @telefon nvarchar(50);
		select @kargoAdi = CompanyName, @telefon = Phone from inserted
		declare @yeniTelefon nvarchar(50);
		set @yeniTelefon = Left(@telefon, 1)+'('+SUBSTRING(@telefon, 2, 3)+')'+SUBSTRING(@telefon, 5, 3)+'-'+SUBSTRING(@telefon, 8,2)+'-'+Right(@telefon,2)
		insert Shippers (CompanyName, Phone) Values (@kargoAdi, @yeniTelefon)
	End

insert into Shippers values ('Aras Kargo', '02129783443')
insert into Shippers values ('Yurtiçi Kargo', '02129783443')
select * from Shippers
