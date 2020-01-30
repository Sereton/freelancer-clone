class Ahorcado

    def initialize
      @words =  words
      @secreto = words.sample
      @lives = 7
      @frase = ""
      @secreto.first.size.times do  @frase << "_ " end
     
    end

    def words
        [["Calabria", "A place in Italy"],["Murcielago", "Como vuela este pibe"],["Democracia", "Cuentame una de vaqueros"]]
    end

    def impri
        puts"Bienvenido al Ahorcado, tienes 7 oportunidades de adivinar la palabra para salir escribe qq"
        puts
        puts @secreto.last
        puts
        puts @frase
    end
end

loquis = Ahorcado.new
loquis.impri