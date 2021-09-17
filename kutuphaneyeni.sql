
use kutuphaneyeni -- Bu sql databese kullanýldý.

--select * from : Veritabanýndan veri çekmek istediðimizde kullanýrýz.

select * from kitap -- Kitap Tablosundaki tüm deðerleri bulur.

select kitapno,
       ad,
	   sayfasayisi,
	   puan 
from kitap -- Ýstenilen sütunlarý bize verir.

select ad,
       yazarno,
	   sayi
from kitap2
where yazarno = 9 --> 'WHERE' kayýtlarý filtrelemek için kullanýlýr.

--WHERE deyiminin kullanýmýnýn birden fazla koþulla da saðlanabilir.Bunun için AND ve OR deyimlerini kullanýlýr. 

select  ad,
        kitapno,
        sayfasayisi 
from kitap  
where sayfasayisi>100
  and sayfasayisi<200 

select ad,
puan,
sayfasayisi 
from kitap 
where sayfasayisi = 140 
    OR sayfasayisi = 150

select ad,
       soyad,
	   sinif,
	   cinsiyet 
from ogrenci
where (sinif='9A' and cinsiyet='E') or (sinif='9B' and cinsiyet='K')

-- AS KULLANIMI : SELECT <sütun adý> AS <yeni ad> FROM <tablo adý> AS <yeni tablo adý>

select ad+' '+soyad as [adsoyad] from yazar

--YEAR( GETDATE())- YEAR( BirthDate)) as Age

select YEAR(dtarih) as [Birth Day] from ogrenci

select YEAR( GETDATE())- YEAR(dtarih) as age from ogrenci where DATEDIFF( YEAR, dtarih, GETDATE())>70

--ORDER BY komutu sýralý tablolar elde etmek için kullanýlan komuttur. 

--(ASC)Ascending(Azdan Çoka - Artan) / (DESC)Descending (Çoktan Aza- Azalan  )

  select * from islem where islemno <100 order by kitapno ASC

  select puan,ad+' '+soyad as [Full namer] ,
  YEAR(GETDATE()) - YEAR(dtarih) as age  
  from ogrenci 
  where puan>70 order by age desc

 -- BETWEEN - AND KULLANIMI 

select kitapno,atarih,vtarih from islem where islemno between 1000 and 2500 order by 1 desc

select ad,id,yazarno from kitap2 where yazarno between '10' and '40' Order by 3

select * from ogrenci where ogrno between 30 and 70 and cinsiyet = 'K'

--- TOP : Sýnýrlý sayýda veri çekmek için kullanýlýr.

select top 1 ad,soyad,dtarih from ogrenci order by dtarih desc

--IN KULLANIMI : Birden fazla or yazmamýz gereken durumlarda kullanabileceðimiz bir yapýdýr.

select * from ogrenci where ogrno IN (5,8,12)

--LÝKE----

select ad,
      soyad,
      sinif 
from ogrenci 
where ad like 'H%' --> Adý H Ýle baþlayan öðrenciler

select ad,
      soyad,
      sinif
from ogrenci
where soyad like '%A' --> Soyadý A ile biten öðrenciler

select ad,
       soyad,
       sinif 
from ogrenci 
where ad like '%L%'  --> Adýnýn içinde L harfi geçenler

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '[RE]%' --> Adýnýn ilk harfi  R veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '%[SE]%' --> Adýnýn içerisinde S veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad  not like '%A' --> Adý A ile bitmeyenler 

---STRÝNG FONKSÝYONLARI 

select ASCII('A') as [ASCII Kodu ] --> Sayý deðer bulunur. 

select CHAR(25) as Karakter   -- harf deðerini buluyor 

select CHARINDEX('z', 'ezgiyaman@gmail.com') as Konum  
 
select LEFT('ezgi yaman ', 4) as [Soldan Karakter Sayýsý]

select Right('ezgi yaman', 4) as [Saðdan  Karakter Sayýsý]

select Len('ezgi yaman ') as [Karakter sayýsý]
 
select lower('EzGi YaMAN') as [Hepsi Küçük ]

select upper('ezgi Yaman') as [Hepsi Büyük ]

select LTRIM('              Ezgi YAMAN') as [Soldaki boþluklarý siler ]

select RTRIM('Ezgi YAMAN            ') as [Saðdaki boþluklarý siler ]

select LTRIM( RTRIM('     Ezgi YAMAN '    )) as [Her iki taraftan da siler ]

select REPLACE('birbirlerine','bir','iki') as [Metinlerin yerine yenilerini yazar]

select SUBSTRING('Ezgi Yaman',1,4) as [Alt Metin ] 

select REPLICATE('Ezgi',7) --> Belirtilen deðeri 7 kere tekrar eder. 


--AGGRATE FUNCTÝON

--COUNT fonksiyonu, belirtilen ölçütlerle eþleþen satýr sayýsýný döndürür.

select count (islemno) from islem

--SUM  fonksiyonu belirtilen sütundaki sayýsal deðerlerin bir toplamýný geri döndürür

select SUM(puan) as [Toplam Puan] from ogrenci

--AVG : Ortalama deðer

select AVG(puan) from ogrenci

--MÝN= MÝNÝMUM DEÐERÝ TEMSÝL EDER / MAX= MAKSÝMUM DEÐERÝ TEMSÝL EDER.

select  MIN(puan) as [ en düþük puan] from ogrenci
 
select  Max(puan) as [en yüksek puan] from ogrenci


--GROUP BY :Sorgu sonucunda dönen veri kümesi üzerinde gruplama iþlemi yapýlan yapýdýr.

select sinif,
       cinsiyet,
       count(*) as OgrenciSayýsý
from ogrenci 
group by cinsiyet,sinif


Select sinif,
       cinsiyet,
       count(*) as OgrenciSayýsý
from ogrenci 
where cinsiyet = 'K'
group by cinsiyet,sinif


Select sinif,
       COUNT(*) as ogrenciSayýsý
from ogrenci 
group by sinif


--HAVÝNG : Having yapýsý temelde where ile ayný görevi yapmaktadýr.GROUP BY ile kullanýlýr. 

Select sinif,count(*) as OgrenciSayýsý
from ogrenci 
group by sinif
having count(*) >= 30

--DML(Data Manipulating Language)

--iNSERT,UPDATE,DELETE

 insert ogrenci(ad,soyad,puan,sinif) values ('ezgi','yaman','100','11B') --> Database kayýt eklemek

 update tur set ad='hikaye' where turno =5 --> Var olan bir database güncelleme yapmak

 delete FROM siniflar where id=2 --> Database kayýt silmek


  













































