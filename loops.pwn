// ========================================================================== //
// - PAWN E�itim Alan� - Ders: 1 (( D�ng�ler ))                               //
//                                                                            //
// - ��renci: SkyChord                                      //
// - ��retmen: Volbeat                                   //
// ========================================================================== //

// == (( d�ng� nedir )) ===================================================== //

/*
	�imdi d�ng�ler bir olay ger�ekle�ene kadar otomatik �al��an fonksiyon t�r� elemanlard�r.
	�rne�in sen ekrana 100 tane mesaj yazd�rmak isteseydin 100 tane SendClientMessage yazman gerekirdi.
	Fakat d�ng� kullanarak 100 mesaj� tek seferde g�nderebiliyorsun.
*/

// == (( max_player nedir, d�ng�lerde ne i�e yarar )) ======================= //

#undef MAX_PLAYERS
#define MAX_PLAYERS 100
// - Bunu evoya sordu�umda performans a��s�ndan etkisi oldu�unu s�ylemi�ti.
//E�er b�yle yaparsan evet.
// - Peki for i�inde max_players olarak kullansak? veya max_players olmuyorsa 100 olarak tan�tsak?
// �imdi senin sunucun 125 kapasiteli diyelim.Ama sen MAX_PLAYERS (500) kullanmak istemiyorsun.
// ister d�ng�ye direk 125 yazars�n ister yukar�daki gibi MAX_PLAYERS'�n de�erini 125'e �evirip �yle kullan�rs�n.
// - Yani performans� etkiler mi?
// Etkiler d�ng� saniyede 500 kere d�nece�ine 125 kere d�ner.
// - �stedi�im buydu. :D Tamam kavrad�m.
// - Bir soru daha, d�ng�de MAX_PLAYERS kullanabilir miyiz?
//Kullan�rs�n �rnekte kullanay�m.

// == (( for d�ng�s� )) ===================================================== //
	// �rnek
	// orada belirtti�im i de�i�ken, istedi�in ismi verebilirsin.
	//Daha sonra bu de�i�kene 0 de�eri at�yarak 100'den k���k olup olmad���n� d�ng� i�erisinde kontrol ettiriyorsun.
	for(new i = 0; i < 100; i++) / // buras� 100'den k���k olup olmad���n� sorguluyor.
	//e�er k���kse ++ operat�r� ile i say�s� her seferinde 1 art�yor.
	//Mesela i'e atad���m�z de�er s�f�rd� ama s�f�r 100'den k���k oldu�u i�in 1 artarak de�eri 0'dan 1'e y�kseldi.
	// - i'yi 0 olarak tan�tt�k, e�er i 100'den k���kse i++ olacakt�, i++ yerine -- yapsayd�k d��erdi de�il mi?
	//e�er de�eri -1 olurdu.
	// - Peki for ile sadece bunu mu yapabiliriz?
	//hay�r.For ile oyuncunun kulland��u t�m komutlar� y�neticilere g�steretebilirsin.
	// - Peki nas�l yapaca��m?
	// �imdi full bir �rnek yapal�m.Girilen oyuncu komutlar� y�neticilere gitsin.

	// MAX_PLAYERS yerine id geliyor unutma.Zaten biliyorsundur :D
	// - evet, asl�nda for olay�n� da az-�ok biliyorum mwrp modunda baya u�ra�t�rm��t� ama yine de �st�nden gitmek iyi.
	// - Ben sadece gerekti�i yerlerde al�nt� yaparak kullanm��t�m ��nk�.
	// - Neyse devam.
new bool:yonetici[MAX_PLAYERS] = false; // oyuncular�n y�netici olup olmad���n� sorgulayan bir de�i�ken yaratt�k.
// - Bir soru, engel oluyorum ama, nas�l yap�yor bu i�i, bu kodu yaz�nca makine okurken nas�l anl�yor?
// /setlevel komutunda kime level veriyorsan o oyuncu i�in yonetici[oyuncunun_id] = true; de�eri al�yor.
// - new ile tan�tsayd�k b�yle olmazd� de�il mi, illa new bool ile tan�taca��z?
// Hay�r.Sadece new ile yapsayd�n de�i�ken say�sal de�er al�rd�.De�er 1 ise y�netici, 0 ise de�il anlam�na gelirdi.
//Bool kulland�m ��nk� true ve false de�eri al�yor sadece ve RAM kullan�m� %0.01.
// - Say�sal de�er alsayd� ram kullan�m� ne kadar olacakt�?
// Say�sal olsayd� RAM mod i�in haf�za b�l�m�nde 128kb lik bir alan a�m�� olcakt�.
//Yani de�i�keni kullansanda kullanmasanda 128kb ram yiyor olacakt�.
// - Peki, anlad�m. Bu arada sat�r atlamalar� ben yapar�m bu sohbette.
// - Ayr�ca sadece bir de�i�ken i�in ne kadar �ok konu�tuk fark�nda m�s�n? :D
// De�i�kenler �nemli de�i�kenlere new a[256]; yazd�n mesela.
//O 256kb lik RAM yiyece�i anlam�na ayn� zamanda 256 karakter alaca�� anlam�na gelir.
// - Devam edelim.
public OnPlayerCommandText(playerid, cmdtext[]) // Komut public'i
{
	// �imdi d�ng�de bu sefer 0 ile 500 aras� say� artt�r�caz.��nk� sunucular maksimum 500 oyuncu kabul ediyor.
	// - Fakat diyelim 100slotluk sunucu a�t�k MAX_PLAYERS'i 100 olarak tan�mlay�nca daha fazla performans yapar.
	// - Bunu da max_players gibi bir �eye g�re yapsayd�k performans artmaz m�yd�?
	// MAX_PLAYERS = 500; normal 500 yazsanda ayn� performans, MAX_PLAYERS yazsanda.
	for(new i = 0; i < MAX_PLAYERS; i++) // for d�ng�s�nde i� taraftan yap�l�yordu.
	{
	// �idmi burda i'nin nas�l kullan�ld���n� daha iyi anlars�n.�imdi burada i 0'dan MAX_PLAYERS'�n de�erine kadar art�yordu.HTTP
	// Biz bu artan de�eri oyuncu ID'si gibi kullan�yoruz.Yani ID'si 0 olaran oyuncu y�netici ise mesaj gitsin gibi..
    	if(yonetici[i] == true) // true yazd�m ��nk� bool veritipi sadece true ve false de�eri al�yordu. (Y�netici ise true, de�ilse false)
    	{
    	    new
    	        komutuKullananOyuncu[MAX_PLAYER_NAME]
			;
			GetPlayerName(playerid, komutuKullananOyuncu, MAX_PLAYER_NAME);
			new mesaj[128];
			format(mesaj,sizeof(mesaj), "Oyuncu %s (ID: %i) %s komutunu kulland�.", komutuKullananOyuncu, playerid, cmdtext);
    	    SendClientMessage(i, -1, mesaj);
		}
	}
} // Mikrofon var asl�nda �al��t�ra bilirsem mikrofondan anlatay�m :D
// - Yok, mikrafonda anlat�rsan ses kayd� yapmak gerekir u�ra�amam. :D Yap :D neyse yukarda bir sorun varm�?
// - Yok, format� felan her �eyi anlad�m. For d�ng�s�n� anlad�nm� onu s�yle
// - Evet, kendi kendime biraz pratik yaparak iyice al���r�m ona ben.
// Birde while d�ng�s� var.For'dan farkl� say� artt�rmaks�z�n �al��an.
// Fakat bu d�ng�n�n 2 t�rl� �al��ma yolu var.

// == (( while d�ng�s� )) =================================================== //

// Birincisi:
while(degiken)
{
}

// ikincisi
do
{
	// olaylar zinciri // buras�
}
while(degisken);

// sana ikisinide ��reticem :)
// - <3 :)


// �imdi while � genel olarak tan�mlyacak olursak for gibi bir olay oluncaya kadar �al���r.Fakat for gibi 0'dan 500 kadar say� artt�rarak �al��maz.O kendisi otomatik olarak bu i�lemi yapar.Ancak for'daki gibi while ile y�neticilere mesaj ve 0'dan 500'e kadar olan say�lar� yazd�rmak biraz daha farkl� bir yol ister.HTTP
// He �unuda s�yliyeyim while ile mod kapan�ncaya kadar sonsuza dek s�rebilen d�ng�ler yaratabilirsin :D

// Yava�tan ba�l�yal�m :D
while // bu d�ng� anahtar�m�z.HTTP
while (olaylar) // olaylar ise d�ng�n�n neye g�re ger�ekle�ece�ini belirten i�lemler.Mesela 5 say�s� 10 say�s�ndan k���k ise 5 say�s� 10 say�s�ndan k���k der.Ama 5 say�s�n� her d�ng�dede 1 artt�rman gerekir.Olum mikrofonla analat�m b�yle zor .d
// - Ben b�yle iyi kavr�yorum ama :d
// S�yleyerek anlatmak �ok daha kolay .d
// - Sen �rnek yap, ben ��zerim olay�. :D

new a = 5, b = 10; // iki tane de�i�ken var elinde diyelim.Birinin de�eri 5, �tekinin de�eri 10.
// while d�ng�s�nde a de�i�keni (yani 5), b de�i�keninden k���k oluncaya kadar mesaj g�ndermek i�in a de�i�kenini 1 artt�rma i�lemi for d�ng�s�n�n i�inde de�il d���nda yap�l�r.HTTP
while (a < b) // burda d�ng� soru sordu.A de�i�keni B de�i�kenindenn k���kse a'y� artt�r�yor (1) evet ama o i�lemi alt tarafta yap��yor
{
	a++;
}

// - Peki for ile while aras�nda ne gibi farklar var ba�ka? Performans, kullan�m yerleri vs?
// for performans� while'a g�re fazla yer.Fakat for'la yap�lan her�ey while ile yap�lamaz :D
// - fora f0r <3
// - Neler yapabiliriz while ile ve forda yap�p whilede yapamayacaklar�m�z nelerdir?
// While'da illa artt�rma i�lemi yap�lmad���n� s�ylemi�tim.�rne�in mysql'dan veri �ekersin.While sorar mysql'dan veri �ekilme i�lemi devam ediyormu diye.E�er evet ise s�radki veriyi �eker.Fakat bunu for ile yapmaya kalksan �nce ka� tane veri oldu�unu bulman laz�m ki 0 ile veri_say�s� kadar d�ng� d�ns�n.Yani while veri �ekmede for'dan �st�n.HTTP
// While'�n 1 avantaj�da �u.�nce bir i�lem yap�p sonra d�ng�ye girebiliyor.Yani 2nci y�ntem.do ile �nce 5+5'i toplars�n bir sonuca aktar�rs�n.E�er sonuc 10 say�s�na e�it ise d�ng�den ��kars�n, de�il ise tekrar 5+5 i�lemini yapar.Ta ki 10 oluncaya kadar.
// Oyuncu �zerinden �rnek vericek olursak.Mesela oyuncuyu hapise att�n.Hapis s�resi var.do ile s�reyi 1 azalt�rs�n.Azaltt�ktan sonra while d�ng�ye girer s�renin bitip bitmedi�ini kontrol eder.E�er bitmi�se d�ng�den ��kar, bitmemi� ise tekrar do yerine gelip s�reyi 1 azalt�r.HTTP
// - Tamamd�r.

// �rnek
do
{
	// �nce burda i�lem yap�ld�
	new a = 16;
	new b = 24;
	new sonuc = a + b;
}//��lem yap�ld�ktan sonra while ile i�lemin sonucunu kontrol ettirmeye geldi s�ra
while(sonuc > 50) // e�er sonuc 50'den b�y�kse otomatik d�ng�den ��kar.E�er de�ilse tekrer do'da ayn� i�lemi yapar.HTTP
// He bu arada otomatik d�ng�nden ��kmas�n� istemiyorsan el ile ��kabilirsin d�ng�den.HTTP
while(5 == 5)
{
	break; // break d�ngnden ��k�� anahtar�d�r. ^^ Bunlar� biliyormuydun yok :D :D
	continue; // biliyormuydun yok? :DD devam etmesi?  .d
	// biliyormu�sun devam :D
	// - Sadece 1-2 defa daha g�rm��t�m. :D (yani continue biliyorum ama ba�ka bir �ey varsa s�yle arada kaynamas�n)
	// Continue alt sat�ra ge�meden tekrar d�ng�ye girer.

	while (1 < 100)
	{
	    printf ("aasdadasdasa");
	    continue; // Continue yaz�ld��� yerin alt taraf�na ge�miyor.Tekrar d�ng� yerine gidiyor yani While (1 < 100) olan yere :D devamD�ng�ler bu kadar :DASDA tamam o zaman bug�nl�k bu kadar yapal�m toplant� var evo sikecek :D:D
	    printf ("Buras� yazd�r�lmayacak");

// D�ng�ler tamamd�r.
// Yar�n i�lenecek konu?
// belirleyelim �imdiden.
// if-else mant���n� biliyormusun.
// �yleyse - de�ilse else if
// yapabiliyorum onu. ama emin de�ilim atlamal� m�y�z?.Yar�n �zerinden ge�eriz :D Tamam.
// E�itim i�in �ok sa�ol, Vol-san.
//:D ben sana sesli video �eker youtuba atar�m :D
// iyi olur asl�nda. hmm :alala: :cakalv2: ;D :D
