require 'telegram/bot'

token = ''

questions = [
  "\u{1F516}  Выберите и напишите тип визы:\n\u{1F539} Деловая виза\n\u{1F539} Туристическая виза\n\u{1F539} Туристическая виза для родственников граждан ЕС\n\u{1F539} Транспортная виза\n\u{1F539} Транспортная виза\n\u{1F539} Учебная виза\n\u{1F539} Виза для участия в мероприятии\n\u{1F539} Виза для участия в спортивных мероприятиях\n\u{1F539} Виза для миссии",
  "\u{1F464}  Ваше имя:",
  "\u{1F464}  Ваша фамилия:",
  "\u{1F4C5}  Введите дату рождения в формате ДД.ММ.ГГГГ:",
  "\u{1F30F}  Введите гражданство в настоящее время:",
  "\u{1F4C5}  Введите дату выдачи паспорта в формате ДД.ММ.ГГГГ:",
  "\u{1F4C5}  Введите дату истечения срока действия паспорта в формате ДД.ММ.ГГГГ:",
  "\u{1F4E7}  Введите ваш email:",
  "\u{1F4F3}  Введите мобильный номер телефона в формате +375XXXXXXXXX:",
  "\u{1F4CD}  Основной пункт назначения:\n\u{1F539} Италия\n\u{1F539} Мальта",
  "\u{1F4C5}  Дата прибытия в шенгенскую зону в формате ДД.ММ.ГГГГ:",
  "\u{1F4C5}  Дата выезда из шенгенской зоны в формате ДД.ММ.ГГГГ:",
]

answers = {}

# def cust_key(bot, message)
#   kb = [[
#     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'start', callback_data: 'start')
#   ]]
#   markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
#   bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
# end


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.username}! \nЯ задам тебе несколько вопросов. Напиши ответ на каждый из них.")

      questions.each do |question|

        bot.api.send_message(chat_id: message.chat.id, text: question)

        bot.listen do |answer|
          if answer.text
            bot.api.send_message(chat_id: message.from.id, text: "\u{2705} OK")
            answers['Пользователь ТГ: '] = message.from.username
            answers[question] = answer.text
            break
          end
        end
      end
    end
    bot.api.send_message(chat_id: message.chat.id, text: "\u{2705} Спасибо, #{message.from.username}! Мы с вами свяжемся\nДля повторного заполнения введите команду: /start")
    bot.api.send_message(chat_id: '-1002015712774', text: "Информация для записи: \n#{answers.map { |k, v| "#{k} #{v}" }.join("\n")}")
    answers.clear

    #cust_key(bot, message)

  end
end
