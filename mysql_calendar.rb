# -*- encoding : utf-8 -*-
require 'rubygems'
require 'mysql2'



def popular(client)


  client.query("drop table birthdays")
  client.query("drop table hollydays")

  client.query("create table birthdays(login varchar(30),tipo varchar(12),aniversario  date, nome varchar(80), imagem varchar(80))")
  client.query("create table hollydays(tipo varchar(12),aniversario  date, nome varchar(80))")

  client.query("insert into birthdays values ('xyko','F','2011-01-10','Isadora','isadora.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-01-11','Vera','vera.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-01-17','Matheus','matheus.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-01-28','Vitor','vitor.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-02-15','Zé','ze_vivian.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-02-15','Vivian','ze_vivian.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-02-23','Elisia','elisia.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-03-04','Armando','armando.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-04-01','Rafael','rafael.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-04-09','Ilma','ilma.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-04-11','Pedro','pedro.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-04-27','Renata','renata.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-05-10','Xyko','xyko.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-05-12','Deda','deda.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-05-31','Angela','angela.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-06-02','Tia Marcelina','marcelina.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-06-23','Bruno','bruno.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-07-17','Arthur','arthur.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-07-25','Ariane','ariane.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-07-28','Jorge','jorge_nena.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-02','Cida','cida.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-04','Nena','nena.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-08','Bárbara','barbara.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-10','Marcelo','marcelo.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-15','Nalva','nalva.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-08-16','Adriana','adriana.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-09-19','Rachel','rachel.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-12-18','Gabriel','gabriel.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-10-06','Sophia','sophia.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-10-16','Aliete','aliete.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-10-22','Tonico','tonico.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-10-25','Rodrigo','rodrigo.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-11-06','Paulo','paulo.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-11-18','Arlete','arlete.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-11-28','João Victor','joao.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-12-03','Márcio','marcio.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-12-11','Márcia','marcia.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-09-18','Guilherme','guilherme.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-05-25','Priscila','priscila.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-02-26','Tereza','tereza.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-06-12','Milton','milton.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-11-02','Voinha','voinha.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-10-23','Julia','julia.jpg')")
  client.query("insert into birthdays values ('xyko','F','2011-01-02','Luiza','luiza.jpg')")


  client.query("insert into birthdays values ('xykof','FX','2011-04-22','Beatriz','bea.jpg')")
  client.query("insert into birthdays values ('xykof','FX','2011-06-22','Tereza','tete.jpg')")
  client.query("insert into birthdays values ('xykof','FX','2011-08-06','Carlos','carlos.png')")
  client.query("insert into birthdays values ('xykof','FX','2011-09-10','Jorge','jorge.png')")
  client.query("insert into birthdays values ('xykof','FX','2011-10-03','Lisa','lisa.png')")
  client.query("insert into birthdays values ('xykof','FX','2011-12-30','Jim','jim.png')")
  client.query("insert into birthdays values ('xykof','FX','2011-06-12','Ana','ana.png')")

  client.query("insert into birthdays values ('cristina','AP','2011-02-03','Lucas','lucas.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-03-07','Cristina','cristina.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-05-30','Esdras','esdras.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-12-04','Barbara Cristina','bcristina.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-05-01','Diana','diana.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-03-26','Pedro','pedro,png')")
  client.query("insert into birthdays values ('cristina','AP','2011-12-26','Priscila','cpriscila.png')")
  client.query("insert into birthdays values ('cristina','AP','2011-03-04','Ednaldo','ednaldo.png')")

  client.query("insert into birthdays values ('cleanto','AP','2011-08-06','Rafael','rafael_gabriela.png')")
  client.query("insert into birthdays values ('cleanto','AP','2011-08-23','Dona Jurema','jurema_gabriela.png')")
  client.query("insert into birthdays values ('cleanto','AP','2011-09-05','Dona Miriam','miriam_gabriela.png')")
  client.query("insert into birthdays values ('cleanto','AP','2011-10-27','Gabriela','gabriela_gabriela.png')")
  client.query("insert into birthdays values ('cleanto','AP','2011-10-31','Cleanto','cleanto_gabriela.png')")
  client.query("insert into birthdays values ('cleanto','AP','2011-10-08','Marcia','marcia_gabriela.png')")

  client.query("insert into hollydays values ('N','2013-01-01','Confraternização Universal')")
  client.query("insert into hollydays values ('N','2013-01-20','São Sebastião do Rio de Janeiro')")
  client.query("insert into hollydays values ('N','2013-02-11','Carnaval')")
  client.query("insert into hollydays values ('N','2013-02-12','Carnaval')")
  client.query("insert into hollydays values ('N','2013-02-13','Quarta-feira de Cinzas')")
  client.query("insert into hollydays values ('N','2013-04-21','Tiradentes')")
  client.query("insert into hollydays values ('N','2013-03-29','Sexta-Feira Santa')")
  client.query("insert into hollydays values ('N','2013-03-31','Páscoa')")
  client.query("insert into hollydays values ('N','2013-04-23','São Jorge')")
  client.query("insert into hollydays values ('N','2013-05-01','Dia do Trabalhador')")
  client.query("insert into hollydays values ('N','2013-05-30','Corpus Christi')")


  client.query("insert into hollydays values ('N','2013-09-07','Independência do Brasil')")
  client.query("insert into hollydays values ('N','2013-10-12','Nossa Senhora Aparecida')")
  client.query("insert into hollydays values ('N','2013-10-15','Dia do Comércio')")
  client.query("insert into hollydays values ('N','2013-10-28','Dia do Servidor Público')")
  client.query("insert into hollydays values ('N','2013-11-02','Dia de Finados')")
  client.query("insert into hollydays values ('N','2013-11-15','Proclamação da República')")
  client.query("insert into hollydays values ('N','2013-11-20','Dia da Consciência Negra')")
  client.query("insert into hollydays values ('N','2013-12-25','Natal')")


  client.query("insert into birthdays values ('sample','A','2011-01-05','Leo' ,'1.png')")
  client.query("insert into birthdays values ('sample','A','2011-01-09','Obama','2.png')")
  client.query("insert into birthdays values ('sample','A','2011-01-20','Fátima'  ,'3.png')")
  client.query("insert into birthdays values ('sample','A','2011-01-28','Angelina' ,'4.png')")
  client.query("insert into birthdays values ('sample','C','2011-02-05','Angelina & Leo'  ,'5.png')")
  client.query("insert into birthdays values ('sample','A','2011-02-12','Xuxa'  ,'6.png')")
  client.query("insert into birthdays values ('sample','A','2011-02-14','Lineu'  ,'7.png')")
  client.query("insert into birthdays values ('sample','A','2011-02-20','D. Nenê'  ,'8.png')")
  client.query("insert into birthdays values ('sample','A','2011-02-28','Agostinho'  ,'9.png')")
  client.query("insert into birthdays values ('sample','A','2011-03-07','Tuco'  ,'10.png')")
  client.query("insert into birthdays values ('sample','A','2011-03-15','Bebel'  ,'11.png')")
  client.query("insert into birthdays values ('sample','A','2011-03-27','Beiçola'  ,'12.png')")

end




@birthdays = Array.new
@hollydays = Array.new
@samples   = Array.new

client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => "", :database => "calendar")

results = client.query("select login, tipo, date_format(aniversario,'%c %d') data, nome, imagem  from birthdays where tipo = 'F' and date_format(aniversario,'%c') = '6' order by aniversario").each(:symbolize_keys => true) do |row|
  @birthdays << {:login => row[:login], :tipo => row[:tipo], :dia => row[:data] , :nome => row[:nome].to_s, :imagem => row[:imagem].to_s}
end

results = client.query("select date_format(aniversario,'%c %d') data,nome from hollydays where tipo = 'N' order by aniversario").each(:symbolize_keys => true) do |row|
  @hollydays << {:dia => row[:data] , :nome => row[:nome].to_s}
end

results = client.query("select login, tipo, date_format(aniversario,'%c %d') data, nome, imagem  from birthdays where login='sample' order by aniversario").each(:symbolize_keys => true) do |row|
  @samples << {:login => row[:login], :tipo => row[:tipo], :dia => row[:data] , :nome => row[:nome].to_s, :imagem => row[:imagem].to_s}
end

puts "aniversarios"

@birthdays.each_index do |x|
  dia = @birthdays[x]
    puts dia[:tipo] + " " + dia[:dia] + " " + dia[:nome]   + " " + dia[:imagem]
end

puts "feriados"

@hollydays.each_index do |x|
   dia = @hollydays[x]
    puts dia[:dia] + " " + dia[:nome]
end

puts "samples"

@samples.each_index do |x|
  dia = @samples[x]
    puts dia[:tipo] + " " + dia[:dia] + " " + dia[:nome]   + " " + dia[:imagem]
end


popular(client)






