require 'rest-client'
require 'json'

# Translator project, final mission of the OneBitCode pure Ruby Course
class Translator
  def receive_text_to_translate
    puts 'Enter the text to be translated:'
    text = gets.chomp

    language_output
    translate(text)
  end

  def language_output
    puts 'What language do you want it to be translated to? '
    @language_to = gets.chomp.downcase
    case @language_to
    when 'pt', 'pt-br', 'portuguese', 'portugues', 'português'
      @language_to = 'pt'
    when 'en', 'english', 'ingles', 'inglês'
      @language_to = 'en'
    when 'it', 'italian', 'italiano'
      @language_to = 'it'
    when 'fr', 'french', 'frances', 'francês'
      @language_to = 'fr'
    when 'ja', 'japanese', 'japones', 'japonês'
      @language_to = 'ja'
    else
      puts 'Invalid answer, available languages are:'
      puts 'Portuguese, english, italian, french and japanese'
      language_output
    end
  end

  def translate(text)
    translator_link = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    translator_key = 'key=trnsl.1.1.20190322T235557Z.a093bc45045aa435.98b380a13f3af4c89c0e6bdc28bd9ab8c137d710'
    request = RestClient.get "#{translator_link}?#{translator_key}&text=#{text}&lang=#{@language_to}"

    translated_json = JSON.parse(request)
    translated_json = { timestamp: Time.now }.merge(translated_json)
    puts translated_json['text']
    save_log(translated_json)
  end

  def save_log(translated_json)
    File.open('log.txt', 'a') do |write|
      write.puts(translated_json)
    end
  end
end

Translator.new.receive_text_to_translate
