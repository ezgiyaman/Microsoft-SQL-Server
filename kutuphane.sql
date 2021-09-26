
use kutuphaneyeni -- Bu sql databese kullanıldı.

--select * from : Veritabanından veri çekmek istediğimizde kullanırız.

select * from kitap -- Kitap Tablosundaki tüm değerleri bulur.

select kitapno,
       ad,
	   sayfasayisi,
	   puan 
from kitap -- İstenilen sütunları bize verir.

select ad,
       yazarno,
	   sayi
from kitap2
where yazarno = 9 --> 'WHERE' kayıtları filtrelemek için kullanılır.

--WHERE deyiminin kullanımının birden fazla koşulla da sağlanabilir.Bunun için AND ve OR deyimlerini kullanılır. 

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

-- AS KULLANIMI : SELECT <sütun adı> AS <yeni ad> FROM <tablo adı> AS <yeni tablo adı>

select ad+' '+soyad as [adsoyad] from yazar

--YEAR( GETDATE())- YEAR( BirthDate)) as Age

select YEAR(dtarih) as [Birth Day] from ogrenci

select YEAR( GETDATE())- YEAR(dtarih) as age from ogrenci where DATEDIFF( YEAR, dtarih, GETDATE())>70

--ORDER BY komutu sıralı tablolar elde etmek için kullanılan komuttur. 

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

--- TOP : Sınırlı sayıda veri çekmek için kullanılır.

select top 1 ad,soyad,dtarih from ogrenci order by dtarih desc

--IN KULLANIMI : Birden fazla or yazmamız gereken durumlarda kullanabileceğimiz bir yapıdır.

select * from ogrenci where ogrno IN (5,8,12)

--LİKE----

select ad,
      soyad,
      sinif 
from ogrenci 
where ad like 'H%' --> Adı H İle başlayan öğrenciler

select ad,
      soyad,
      sinif
from ogrenci
where soyad like '%A' --> Soyadı A ile biten öğrenciler

select ad,
       soyad,
       sinif 
from ogrenci 
where ad like '%L%'  --> Adının içinde L harfi geçenler

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '[RE]%' --> Adının ilk harfi  R veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '%[SE]%' --> Adının içerisinde S veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad  not like '%A' --> Adı A ile bitmeyenler 

---STRİNG FONKSİYONLARI 

select ASCII('A') as [ASCII Kodu ] --> Sayı değer bulunur. 

select CHAR(25) as Karakter   -- harf değerini buluyor 

select CHARINDEX('z', 'ezgiyaman@gmail.com') as Konum  
 
select LEFT('ezgi yaman ', 4) as [Soldan Karakter Sayısı]

select Right('ezgi yaman', 4) as [Sağdan  Karakter Sayısı]

select Len('ezgi yaman ') as [Karakter sayısı]
 
select lower('EzGi YaMAN') as [Hepsi Küçük ]

select upper('ezgi Yaman') as [Hepsi Büyük ]

select LTRIM('              Ezgi YAMAN') as [Soldaki boşlukları siler ]

select RTRIM('Ezgi YAMAN            ') as [Sağdaki boşlukları siler ]

select LTRIM( RTRIM('     Ezgi YAMAN '    )) as [Her iki taraftan da siler ]

select REPLACE('birbirlerine','bir','iki') as [Metinlerin yerine yenilerini yazar]

select SUBSTRING('Ezgi Yaman',1,4) as [Alt Metin ] 

select REPLICATE('Ezgi',7) --> Belirtilen değeri 7 kere tekrar eder. 


--AGGRATE FUNCTİON

--COUNT fonksiyonu, belirtilen ölçütlerle eşleşen satır sayısını döndürür.

select count (islemno) from islem

--SUM  fonksiyonu belirtilen sütundaki sayısal değerlerin bir toplamını geri döndürür

select SUM(puan) as [Toplam Puan] from ogrenci

--AVG : Ortalama değer

select AVG(puan) from ogrenci

--MİN= MİNİMUM DEĞERİ TEMSİL EDER / MAX= MAKSİMUM DEĞERİ TEMSİL EDER.

select  MIN(puan) as [ en düşük puan] from ogrenci
 
select  Max(puan) as [en yüksek puan] from ogrenci


--GROUP BY :Sorgu sonucunda dönen veri kümesi üzerinde gruplama işlemi yapılan yapıdır.

select sinif,
       cinsiyet,
       count(*) as OgrenciSayısı
from ogrenci 
group by cinsiyet,sinif


Select sinif,
       cinsiyet,
       count(*) as OgrenciSayısı
from ogrenci 
where cinsiyet = 'K'
group by cinsiyet,sinif


Select sinif,
       COUNT(*) as ogrenciSayısı
from ogrenci 
group by sinif


--HAVİNG : Having yapısı temelde where ile aynı görevi yapmaktadır.GROUP BY ile kullanılır. 

Select sinif,count(*) as OgrenciSayısı
from ogrenci 
group by sinif
having count(*) >= 30

--DML(Data Manipulating Language)

--iNSERT,UPDATE,DELETE

 insert ogrenci(ad,soyad,puan,sinif) values ('ezgi','yaman','100','11B') --> Database kayıt eklemek

 update tur set ad='hikaye' where turno =5 --> Var olan bir database güncelleme yapmak

 delete FROM siniflar where id=2 --> Database kayıt silmek
 
 
--JOİN

--(INNER) JOIN: İki tablodaki eşleşen kayıtlar için kullanılır.
--LEFT (OUTER) JOIN: İki tablodaki eşleşen kayıtlar ve eşleşmeyen sol kayıtlar için kullanılır.
--RIGHT (OUTER) JOIN: İki tablodaki eşleşen kayıtlar ve eşleşmeyen sağ kayıtlar için kullanılır.
--FULL (OUTER) JOIN: İki tablodaki eşleşen kayıtlar ve eşleşmeyen sol ve sağ kayıtlar için kullanılır. LEFT ve RIGHT JOIN birleşimidir.

select ogrenci.ogrno,ograd,ogrsoyad,sinif,kitapadi
from ogrenci
join islem on ogrenci.ogrno=islem.ogrno
join kitap on islem.kitapno=kitap.kitapno
where sinif='10B' or sinif='10C'
order by ogrenci.ograd

select ograd,ogrsoyad,islem.atarih from ogrenci
left join islem on islem.ogrno=ogrenci.ogrno
where islem.atarih is null

select ograd,ogrsoyad yazarad,yazarsoyad,kitapadi,turadi from islem
join kitap on islem.kitapno=kitap.turno
right join ogrenci on ogrenci.ogrno=islem.ogrno
left join tur on kitap.turno=tur.turno
left join yazar on yazar.yazarno=kitap.yazarno

