# -*- encoding : utf-8 -*-

require 'rubygems'
require 'RMagick'
require 'rvg/rvg'
require 'cairo'
require 'mysql2'

class XykoCal

	#attr_accessor  :calName, :, :village, :report

	def initialize(options = {})
		@cream  = Cairo::Color::CREAM
		@black  = Cairo::Color::BLACK
		@green  = Cairo::Color::GREEN

		@A4width  = 595
		@A4height = 842

		cream  = Cairo::Color::CREAM
		black  = Cairo::Color::BLACK
		@green = Cairo::Color::GREEN

		@days      = [0,1,2,3,4,5,6]
		@weeks     = [0,1,2,3,4]
		@month     = Array.new
	end #initialize

	def getCalendar(mes,ano)
		@mes      = mes
		vet_nome_mes 	  = Array.new
		vet_nome_mes[1]   = "Janeiro"
		vet_nome_mes[2]   = "Fevereiro"
		vet_nome_mes[3]   = "Março"
		vet_nome_mes[4]   = "Abril"
		vet_nome_mes[5]   = "Maio"
		vet_nome_mes[6]   = "Junho"
		vet_nome_mes[7]   = "Julho"
		vet_nome_mes[8]   = "Agosto"
		vet_nome_mes[9]   = "Setembro"
		vet_nome_mes[10]  = "Outubro"
		vet_nome_mes[11]  = "Novembro"
		vet_nome_mes[12]  = "Dezembro"
		@vet_nome_semana  = ["Domingo","Segunda","Terça","Quarta","Quinta","Sexta","Sábado"]
		@nome_mes = vet_nome_mes[mes.to_i]
		@ano      = ano
		io = IO.popen("cal "+mes+" "+ano)
		calendar = io.readlines
		calendar.each_index do |index|
			@month << calendar[index] if  index > 1 &&  calendar[index].strip.size > 0
		end
		io.close
		@birthdays = Array.new
		@hollydays = Array.new
		client = Mysql2::Client.new(:host => "127.0.0.1", :username => "root", :password => "", :database => "calendar")
		results = client.query("select date_format(aniversario,'%d') data,nome,imagem from birthdays where tipo = 'F' and date_format(aniversario,'%c') = "+mes+" order by aniversario").each(:symbolize_keys => true) do |row|
			@birthdays << {:dia => row[:data] , :nome => row[:nome].to_s, :imagem => row[:imagem].to_s}
		end
		results = client.query("select date_format(aniversario,'%d') data,nome from hollydays where tipo = 'N' and date_format(aniversario,'%c') = "+mes+" order by aniversario").each(:symbolize_keys => true) do |row|
			@hollydays << {:dia => row[:data] , :nome => row[:nome].to_s}
		end

	end #GetCalendar

	def paintText(x,y,texto,tamanho,fonte,cor)
	  @cr.set_source_color(cor)
	  @cr.select_font_face(fonte, Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD)
	  @cr.set_font_size(tamanho)
	  @cr.move_to(x + @tamanho_texto_calendario/4, y + @tamanho_texto_calendario)
	  @cr.show_text(texto)
	end #PaintText

	def paintPhoto(x,y,imagem)

	  if FileTest.exist?( 'fotos/thumbs/'+imagem)
	    clown = Magick::Image.read('fotos/thumbs/'+imagem).first
	  else
	    clown = Magick::Image.read('fotos/thumbs/coringa.png').first
	  end

	  clown.crop_resized!(@dimensao_dia, @dimensao_dia, Magick::SouthWestGravity)
	  clown.write('fotos/resized.png')

	  resizedImage = Cairo::ImageSurface.from_png('fotos/resized.png')
	  cr = Cairo::Context.new(@surface)
	  cr.set_source(resizedImage,x,y)
	  cr.rectangle(x,y,@dimensao_dia,@dimensao_dia)
	  cr.clip
	  cr.paint
	end #PaintFoto 

	def paintBaseDayBackground(x,y)
		clown = Magick::Image.read('fotos/thumbs/transparente.png').first
		clown.crop_resized!(@A4width, @A4height, Magick::NorthWestGravity)
		clown.write('fotos/thumbs/day_resized.png')
		resizedImage = Cairo::ImageSurface.from_png('fotos/thumbs/day_resized.png')
		cr = Cairo::Context.new(@surface)
		cr.set_source(resizedImage,x,y)
		cr.rectangle(x,y,@dimensao_dia,@dimensao_dia)
		cr.clip
		cr.paint
	end #paintBaseDayBackground

	def paintDay(x,y,texto)
		@birthdays.each do |birthday|
			if (birthday[:dia].to_i == texto.to_i)
				paintPhoto(x,y,birthday[:imagem])
			end
		end
		@cr.set_source_color(Cairo::Color::BLACK)
		@cr.rectangle(x,y , @dimensao_dia, @dimensao_dia)
		@cr.stroke
		@cr.set_source_color(Cairo::Color::BLACK)
		@cr.rectangle(x,y , @tamanho_texto_calendario * 1.4, @tamanho_texto_calendario*1.4)
		@cr.fill
		@hollydays.each do |hollyday|
			if (hollyday[:dia].to_i == texto.to_i)
				@cr.set_source_color(Cairo::Color::RED)
				@cr.rectangle(x-1,y-1 , @dimensao_dia+2, @dimensao_dia+2)
				@cr.stroke
				@cr.set_source_color(Cairo::Color::RED)
				@cr.rectangle(x,y , @tamanho_texto_calendario * 1.4, @tamanho_texto_calendario*1.4)
				@cr.fill
			end
		end
		paintText(x,y,texto,@tamanho_texto_calendario,"Arial",Cairo::Color::WHITE)
	end #paintDay

	def paintCalendario

		@month.each_index do |pos_linha|
		linha = @month[pos_linha].split(" ")
		linha.each_index do |pos|
			complemento = 0
			if pos_linha == 0
				complemento = ((7 - linha.size) * (@dimensao_dia + @dimensao_dia*0.1))
			end
			x = @x_origem + pos * (@dimensao_dia + @dimensao_dia*0.1) + complemento
			y = @y_origem + pos_linha * (@dimensao_dia + @dimensao_dia*0.1)
			paintBaseDayBackground(x,y)
			paintDay(x,y,linha[pos])
		end

		end

	end

	def paintLegenda

		if (@birthdays.size > 0)
			@y_atual = @y_origem_legenda
			paintText(@x_origem, @y_atual , "Aniversariantes", @tamanho_texto_legenda*1.5,"URW Chancery L",@cor_legenda)
			@y_atual += @tamanho_texto_legenda * 2
			@birthdays.each_index do |index|
				aniversario = @birthdays[index]
				texto = aniversario[:dia] + " " + aniversario[:nome]
				paintText(@x_origem, @y_atual , texto, @tamanho_texto_legenda,"Arial",@cor_legenda)
				@y_atual += @tamanho_texto_legenda*1.5
			end
		end

		if (@hollydays.size > 0)
			@y_atual += @tamanho_texto_legenda * 2
			paintText(@x_origem, @y_atual , "Feriados", @tamanho_texto_legenda*1.5,"URW Chancery L",@cor_legenda)
			@y_atual += @tamanho_texto_legenda * 2
			@hollydays.each_index do |index|
				aniversario = @hollydays[index]
				texto = aniversario[:dia] + " " + aniversario[:nome]
				paintText(@x_origem,  @y_atual , texto, @tamanho_texto_legenda,"Arial",@cor_legenda)
				@y_atual += @tamanho_texto_legenda *1.5
			end
		end
	end

	def paintBackground

		if FileTest.exist?( "#{Dir.pwd}/fotos/backgrounds/"+@nome_mes.downcase+".jpg" )
			clown = Magick::Image.read("#{Dir.pwd}/fotos/backgrounds/"+@nome_mes.downcase+".jpg").first
		else
			clown = Magick::Image.read("#{Dir.pwd}/fotos/backgrounds/coringa_background.jpg").first
		end

		clown.crop_resized!(@A4width, @A4height, Magick::NorthWestGravity)
		clown.write('fotos/backgrounds/background_resized.png')

		resizedImage = Cairo::ImageSurface.from_png('fotos/backgrounds/background_resized.png')
		cr = Cairo::Context.new(@surface)
		cr.set_source(resizedImage,0,0)
		cr.paint

		cr.set_source_color(@cor_titulo)
		cr.select_font_face("URW Chancery L", Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_BOLD)
		cr.set_font_size(@tamanho_titulo)
		extents = cr.text_extents(@nome_mes + " " + @ano)
		x = @A4width/2-(extents.width/2 + extents.x_bearing)
		y = @y_origem_titulo
		xdif = extents.width*0.1
		ydif = extents.height*0.1
		clown = Magick::Image.read('fotos/thumbs/transparente.png').first
		clown.crop_resized!(extents.width*1.15,extents.height*1.2, Magick::NorthWestGravity)
		clown.write('fotos/titulo_base_resized.png')
		basetitulo = Cairo::ImageSurface.from_png('fotos/titulo_base_resized.png')

		cr2 = Cairo::Context.new(@surface)
		cr2.set_source(basetitulo,x - xdif/2, y - extents.height )
		cr2.paint

		cr.move_to(x, y)
		cr.show_text(@nome_mes + " " + @ano)

		clown = Magick::Image.read('fotos/thumbs/transparente.png').first

		@legenda_altura = (@birthdays.size + @hollydays.size) * (@tamanho_texto_legenda *1.5) + (@tamanho_texto_legenda * 2) * 5

		clown.crop_resized!(@A4width*0.45, @legenda_altura, Magick::NorthWestGravity)
		clown.write('fotos/titulo_legenda_resized.png')
		baseLegenda = Cairo::ImageSurface.from_png('fotos/titulo_legenda_resized.png')
		cr3 = Cairo::Context.new(@surface)
		cr3.set_source(baseLegenda,@x_origem * 0.9, @y_origem_legenda * 0.9 )
		cr3.paint

		cr3 = Cairo::Context.new(@surface)
		@days.each_index do |pos|
		  x = x = @x_origem + pos * (@dimensao_dia + @dimensao_dia*0.1)
		  y = @y_origem - @dimensao_dia / 2
		  cr3.set_source_color(Cairo::Color::BLACK)
		  cr3.rectangle(x,y , @dimensao_dia, @tamanho_texto_calendario*1.5)
		  cr3.fill
		  paintText(x,y,@vet_nome_semana[pos],@tamanho_texto_calendario,"Arial",Cairo::Color::WHITE)
		end
	end

	def criaCalendario(mes,ano)

		cream  = Cairo::Color::CREAM
		@green = Cairo::Color::GREEN

		@days      = [0,1,2,3,4,5,6]
		@weeks     = [0,1,2,3,4,6]
		@month     = Array.new

		getCalendar(mes,ano)

		@A4width  = 595*3
		@A4height = 842*3

		@dimensao_dia = @A4width / 9.5
		@tamanho_texto_legenda    = @dimensao_dia * 0.2
		@tamanho_texto_calendario = @dimensao_dia * 0.2
		@tamanho_titulo           = @dimensao_dia
		@cor_legenda = Cairo::Color::BLACK
		@cor_titulo  = Cairo::Color::BLACK
		@x_origem  = @A4width  - (@dimensao_dia + @dimensao_dia*0.1) * 7  - ((@dimensao_dia + @dimensao_dia*0.1) * 7) * 0.1
		@y_origem  = @A4height - (@dimensao_dia + @dimensao_dia*0.1) * @month.size  #- (((@dimensao_dia + @dimensao_dia*0.1) * 7) * 0.1) * 2

		@y_origem_legenda =  @A4height * 0.15
		@y_origem_titulo  =  @A4height * 0.1

		@surface = Cairo::ImageSurface.new(@A4width, @A4height)

		@surface.set_fallback_resolution(300.0,300.0)

		@cr = Cairo::Context.new(@surface)
		@cr.set_source_rgba(*cream)
		@cr.paint

		@cr.set_line_width(1)

		paintBackground
		paintLegenda
		paintCalendario

		@cr.target.write_to_png("./calendarios/"+@mes+"_"+@nome_mes+"_"+@ano+".png")
	end


end #XykoCal

cal = XykoCal.new

#cal.criaCalendario("01","2013")
#cal.criaCalendario("02","2013")
#cal.criaCalendario("03","2013")
cal.criaCalendario("04","2013")
#cal.criaCalendario("05","2013")
#cal.criaCalendario("06","2013")
#cal.criaCalendario("07","2013")
#cal.criaCalendario("08","2013")
#cal.criaCalendario("09","2013")
#cal.criaCalendario("10","2013")
#cal.criaCalendario("11","2013")
#cal.criaCalendario("12","2013")




