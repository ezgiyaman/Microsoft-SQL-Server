
use kutuphaneyeni -- Bu sql databese kullan�ld�.

--select * from : Veritaban�ndan veri �ekmek istedi�imizde kullan�r�z.

select * from kitap -- Kitap Tablosundaki t�m de�erleri bulur.

select kitapno,
       ad,
	   sayfasayisi,
	   puan 
from kitap -- �stenilen s�tunlar� bize verir.

select ad,
       yazarno,
	   sayi
from kitap2
where yazarno = 9 --> 'WHERE' kay�tlar� filtrelemek i�in kullan�l�r.

--WHERE deyiminin kullan�m�n�n birden fazla ko�ulla da sa�lanabilir.Bunun i�in AND ve OR deyimlerini kullan�l�r. 

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

-- AS KULLANIMI : SELECT <s�tun ad�> AS <yeni ad> FROM <tablo ad�> AS <yeni tablo ad�>

select ad+' '+soyad as [adsoyad] from yazar

--YEAR( GETDATE())- YEAR( BirthDate)) as Age

select YEAR(dtarih) as [Birth Day] from ogrenci

select YEAR( GETDATE())- YEAR(dtarih) as age from ogrenci where DATEDIFF( YEAR, dtarih, GETDATE())>70

--ORDER BY komutu s�ral� tablolar elde etmek i�in kullan�lan komuttur. 

--(ASC)Ascending(Azdan �oka - Artan) / (DESC)Descending (�oktan Aza- Azalan  )

  select * from islem where islemno <100 order by kitapno ASC

  select puan,ad+' '+soyad as [Full namer] ,
  YEAR(GETDATE()) - YEAR(dtarih) as age  
  from ogrenci 
  where puan>70 order by age desc

 -- BETWEEN - AND KULLANIMI 

select kitapno,atarih,vtarih from islem where islemno between 1000 and 2500 order by 1 desc

select ad,id,yazarno from kitap2 where yazarno between '10' and '40' Order by 3

select * from ogrenci where ogrno between 30 and 70 and cinsiyet = 'K'

--- TOP : S�n�rl� say�da veri �ekmek i�in kullan�l�r.

select top 1 ad,soyad,dtarih from ogrenci order by dtarih desc

--IN KULLANIMI : Birden fazla or yazmam�z gereken durumlarda kullanabilece�imiz bir yap�d�r.

select * from ogrenci where ogrno IN (5,8,12)

--L�KE----

select ad,
      soyad,
      sinif 
from ogrenci 
where ad like 'H%' --> Ad� H �le ba�layan ��renciler

select ad,
      soyad,
      sinif
from ogrenci
where soyad like '%A' --> Soyad� A ile biten ��renciler

select ad,
       soyad,
       sinif 
from ogrenci 
where ad like '%L%'  --> Ad�n�n i�inde L harfi ge�enler

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '[RE]%' --> Ad�n�n ilk harfi  R veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad like '%[SE]%' --> Ad�n�n i�erisinde S veya E olanlar

select ad,
      soyad,
      sinif 
from ogrenci
where soyad  not like '%A' --> Ad� A ile bitmeyenler 

---STR�NG FONKS�YONLARI 

select ASCII('A') as [ASCII Kodu ] --> Say� de�er bulunur. 

select CHAR(25) as Karakter   -- harf de�erini buluyor 

select CHARINDEX('z', 'ezgiyaman@gmail.com') as Konum  
 
select LEFT('ezgi yaman ', 4) as [Soldan Karakter Say�s�]

select Right('ezgi yaman', 4) as [Sa�dan  Karakter Say�s�]

select Len('ezgi yaman ') as [Karakter say�s�]
 
select lower('EzGi YaMAN') as [Hepsi K���k ]

select upper('ezgi Yaman') as [Hepsi B�y�k ]

select LTRIM('              Ezgi YAMAN') as [Soldaki bo�luklar� siler ]

select RTRIM('Ezgi YAMAN            ') as [Sa�daki bo�luklar� siler ]

select LTRIM( RTRIM('     Ezgi YAMAN '    )) as [Her iki taraftan da siler ]

select REPLACE('birbirlerine','bir','iki') as [Metinlerin yerine yenilerini yazar]

select SUBSTRING('Ezgi Yaman',1,4) as [Alt Metin ] 

select REPLICATE('Ezgi',7) --> Belirtilen de�eri 7 kere tekrar eder. 


--AGGRATE FUNCT�ON

--COUNT fonksiyonu, belirtilen �l��tlerle e�le�en sat�r say�s�n� d�nd�r�r.

select count (islemno) from islem

--SUM  fonksiyonu belirtilen s�tundaki say�sal de�erlerin bir toplam�n� geri d�nd�r�r

select SUM(puan) as [Toplam Puan] from ogrenci

--AVG : Ortalama de�er

select AVG(puan) from ogrenci

--M�N= M�N�MUM DE�ER� TEMS�L EDER / MAX= MAKS�MUM DE�ER� TEMS�L EDER.

select  MIN(puan) as [ en d���k puan] from ogrenci
 
select  Max(puan) as [en y�ksek puan] from ogrenci


--GROUP BY :Sorgu sonucunda d�nen veri k�mesi �zerinde gruplama i�lemi yap�lan yap�d�r.

select sinif,
       cinsiyet,
       count(*) as OgrenciSay�s�
from ogrenci 
group by cinsiyet,sinif


Select sinif,
       cinsiyet,
       count(*) as OgrenciSay�s�
from ogrenci 
where cinsiyet = 'K'
group by cinsiyet,sinif


Select sinif,
       COUNT(*) as ogrenciSay�s�
from ogrenci 
group by sinif


--HAV�NG : Having yap�s� temelde where ile ayn� g�revi yapmaktad�r.GROUP BY ile kullan�l�r. 

Select sinif,count(*) as OgrenciSay�s�
from ogrenci 
group by sinif
having count(*) >= 30

--DML(Data Manipulating Language)

--iNSERT,UPDATE,DELETE

 insert ogrenci(ad,soyad,puan,sinif) values ('ezgi','yaman','100','11B') --> Database kay�t eklemek

 update tur set ad='hikaye' where turno =5 --> Var olan bir database g�ncelleme yapmak

 delete FROM siniflar where id=2 --> Database kay�t silmek


  













































